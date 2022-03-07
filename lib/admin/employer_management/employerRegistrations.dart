import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class EmployerRegistrations extends StatefulWidget {
  @override
  _EmployerRegistrationsState createState() => _EmployerRegistrationsState();
}

class _EmployerRegistrationsState extends State<EmployerRegistrations> {
  // List serviceRequests = [
  //   {
  //     "firstName": "Kelvin",
  //     "surname": "Chelenje",
  //     "gender": "MALE",
  //     "address": "186 Helvetia Drive Borrowdale",
  //     "phoneNumber": "263785302628",
  //     "idNumber": "2021-10-30",
  //     "photoUrl":
  //     "",
  //
  //     "verificationStatus": "Pending",
  //     "applicationNumber": "REQ67889997",
  //     "services": "Gold - Level 2",
  //     "employeeCount":0,
  //     "activeEmployment":false,  // widget.activeEmployment
  //     "employeeId": "",
  //     "employeeName": ""
  //   }
  // ];

  int index = 0;

  void _approval(var id, var decision, var profileid) async {
    try {
      var results = await FirebaseFirestore.instance
          .collection('Account Type')
          .where('profileid', isEqualTo: profileid)
          .get();

      if (decision == 'Approved') {
        await FirebaseFirestore.instance
            .collection('Account Type')
            .doc(results.docs[0].id)
            .update({'activated': true});
      }

      await FirebaseFirestore.instance
          .collection('Employer Accounts')
          .doc(id)
          .update({'verificationStatus': decision});

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
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Employer Accounts')
              .where('verificationStatus', isEqualTo: "Pending")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map(
                (serviceRequest) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: ExpansionTileCard(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      initialElevation: 1,
                      baseColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(serviceRequest['firstName'] +
                          ' ' +
                          serviceRequest['surname']),
                      subtitle: Text(serviceRequest['verificationStatus']),
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
                                    NetworkImage(serviceRequest['photoUrl']),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              serviceDisplay(
                                  "ID Number", serviceRequest['idNumber']),
                              serviceDisplay(
                                  "Gender", serviceRequest['gender']),
                              serviceDisplay("Phone Number",
                                  serviceRequest['phoneNumber']),
                              serviceDisplay(
                                  "Address", serviceRequest['address'])
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
                                    _approval(serviceRequest.id, "Declined",
                                        serviceRequest['profileid']);
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
                                    _approval(serviceRequest.id, "Approved",
                                        serviceRequest['profileid']);
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
                },
              ).toList(),
            );
          }),
      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
