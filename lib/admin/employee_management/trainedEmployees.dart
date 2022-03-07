import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class TrainedEmployees extends StatefulWidget {
  final employmentStatus;

  TrainedEmployees({Key key, @required this.employmentStatus})
      : super(key: key);
  @override
  _TrainedEmployeesState createState() => _TrainedEmployeesState();
}

class _TrainedEmployeesState extends State<TrainedEmployees> {
  // List serviceRequests = [
  //   {
  //     "firstName": "Fradrick",
  //     "surname": "Chelenje",
  //     "gender": "MALE",
  //     "age": "28",
  //     "services": "Gold - Level 2",
  //     "location": "186 Helvetia Drive Borrowdale",
  //     "phoneNumber": "263785302628",
  //     "photoUrl":
  //         "",
  //     "employeeId": "58-293952-Q-86",
  //     "employmentStatus": "Employed", //Widget.employmentStatus
  //     "dob": "2021-10-30",
  //     "applicationNumber": "REQ67889997",
  //     "employer": "Kelvin Chelenje",
  //     "employmentCount":1
  //   }
  // ];

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
              .collection('Employee Accounts')
              .where('employmentStatus', isEqualTo: widget.employmentStatus)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((serviceRequest) {
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
                        (index + 1).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(serviceRequest['firstName'] +
                        ' ' +
                        serviceRequest['surname']),
                    subtitle: Text(serviceRequest['employmentStatus']),
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
                            serviceDisplay("Application Number",
                                serviceRequest['applicationNumber']),
                            // serviceDisplay("Services", serviceRequest['services']),
                            serviceDisplay("Gender", serviceRequest['gender']),
                            serviceDisplay(
                                "Phone Number", serviceRequest['phoneNumber']),
                            serviceDisplay(
                                "Address", serviceRequest['address']),
                            serviceDisplay(
                                "Date of Birth", serviceRequest['dob']),
                            serviceRequest['employmentStatus'] == "Employed"
                                ? serviceDisplay(
                                    "Employer", serviceRequest['employer'])
                                : Text("")
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
                              serviceRequest['employmentStatus'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onPressed: () {},
                            backgroundColor:
                                serviceRequest['employmentStatus'] == 'Employed'
                                    ? Colors.green
                                    : Colors.orange,
                            elevation: 1,
                          )
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
