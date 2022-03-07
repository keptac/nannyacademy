import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class ActivatedEmployers extends StatefulWidget {
  final activeEmployment;
  ActivatedEmployers({Key key, @required this.activeEmployment})
      : super(key: key);

  @override
  _ActivatedEmployersState createState() => _ActivatedEmployersState();
}

class _ActivatedEmployersState extends State<ActivatedEmployers> {
  int index = 0;

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
          'Verified Profiles',
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Employer Accounts')
              .where('activeEmployment', isEqualTo: widget.activeEmployment)
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
                                  "Services Selected",
                                  serviceRequest['services'] == ""
                                      ? "All Services"
                                      : serviceRequest['services']),

                              serviceDisplay(
                                  "Gender", serviceRequest['gender']),
                              serviceDisplay("Phone Number",
                                  serviceRequest['phoneNumber']),
                              serviceDisplay(
                                  "Address", serviceRequest['address']),
                              serviceDisplay("Total Employments",
                                  serviceRequest['employeeCount'].toString()),
                              serviceRequest['activeEmployment']
                                  ? serviceDisplay("Employee",
                                      serviceRequest['employeeName'])
                                  : Text("No Active Employees")
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
                            ActionChip(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              label: Text(
                                serviceRequest['verificationStatus'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                              onPressed: () {},
                              backgroundColor: Colors.green,
                              elevation: 1,
                            )
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
