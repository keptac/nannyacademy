import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:intl/intl.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeApplications extends StatefulWidget {
  @override
  _EmployeeApplicationsState createState() => _EmployeeApplicationsState();
}

class _EmployeeApplicationsState extends State<EmployeeApplications> {

  void _approval(var id, var decision) async {
    try {
      await FirebaseFirestore.instance
          .collection('Employee Accounts')
          .doc(id)
          .update({'applicationStatus': decision});

      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Application Response submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Ok'),
            )
          ],
        ),
      );

    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(' Ops! Failed to submit response. Try again later.'),
          content: Text('${e.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Dismiss'),
            )
          ],
        ),
      );
    }
  }

  Widget serviceDisplay(var title, var value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Nanny Applications',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Employee Accounts')
              .where('applicationStatus', isEqualTo: 'Pending')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((document) {
                final from = DateFormat("dd-MM-yyyy").parse(document['dob']);
                final to = DateTime.now();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ExpansionTileCard(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    initialElevation: 1,
                    baseColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        (1).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title:
                        Text(document['firstName'] + ' ' + document['surname']),
                    subtitle: Text(document['applicationStatus']),
                    children: <Widget>[
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              maxRadius: 25,
                              backgroundImage:
                                  NetworkImage(document['photoUrl']),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            serviceDisplay("Application Number",
                                document['applicationNumber']),
                            // serviceDisplay("Services", document['services']),
                            serviceDisplay("Gender", document['gender']),
                            serviceDisplay(
                                "Phone Number", document['phoneNumber']),
                            serviceDisplay("Address", document['address']),
                            serviceDisplay(
                                "Date of Birth",
                                document['dob'] +
                                    ' (' +
                                    (to.difference(from).inDays / 365.4)
                                        .round()
                                        .toString() +
                                    ')'),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          Row(
                            children: [
                              ActionChip(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                label: Text(
                                  'Decline Application',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                onPressed: () {
                                  _approval(document.id, "Declined");
                                },
                                backgroundColor: Colors.red.shade900,
                                elevation: 1,
                              ),
                              SizedBox(width: 50),
                              ActionChip(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                label: Text(
                                  'Approve ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                onPressed: () {
                                  _approval(document.id, "Approved");
                                },
                                backgroundColor: Colors.green,
                                elevation: 1,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
