import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class EmployerRegistrations extends StatefulWidget {
  @override
  _EmployerRegistrationsState createState() => _EmployerRegistrationsState();
}

class _EmployerRegistrationsState extends State<EmployerRegistrations> {
  List serviceRequests = [
    {
      "firstName": "Kelvin",
      "surname": "Chelenje",
      "gender": "MALE",
      "address": "186 Helvetia Drive Borrowdale",
      "phoneNumber": "263785302628",
      "idNumber": "2021-10-30",
      "photoUrl":
      "https://lh3.googleusercontent.com/ogw/ADea4I4wWPHXockcfJemnnm4OGPaSrhXIVmqium_Zoe9=s192-c-mo",

      "verificationStatus": "Pending",
      "applicationNumber": "REQ67889997",
      "services": "Gold - Level 2",
      "employeeCount":0,
      "activeEmployment":false,  // widget.activeEmployment
      "employeeId": "",
      "employeeName": ""
    }
  ];

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
      body: ListView.builder(
        // padding: const EdgeInsets.all(8),

        itemCount: serviceRequests.length,
        itemBuilder: (BuildContext context, int index) {
          var serviceRequest = serviceRequests[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                      serviceDisplay("ID Number", serviceRequest['idNumber']),
                      serviceDisplay("Gender", serviceRequest['gender']),
                      serviceDisplay(
                          "Phone Number", serviceRequest['phoneNumber']),
                      serviceDisplay("Address", serviceRequest['address'])
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
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          onPressed: () {},
                          backgroundColor: Colors.red.shade900,
                          elevation: 1,
                        ),
                        SizedBox(width: 50),
                        ActionChip(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          label: Text(
                            'Approve ',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          onPressed: () {},
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
      ),
      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
