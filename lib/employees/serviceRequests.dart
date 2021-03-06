import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ServiceRequests extends StatefulWidget {
  @override
  _ServiceRequestsState createState() => _ServiceRequestsState();
}

class _ServiceRequestsState extends State<ServiceRequests> {
  List serviceRequests = [];

  Widget serviceDisplay(var title, var value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget statusButton(Color buttonColor, var serviceStatus) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      buttonHeight: 52.0,
      buttonMinWidth: 90.0,
      children: <Widget>[
        ActionChip(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          label: Text(
            serviceStatus,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          onPressed: () {},
          backgroundColor: buttonColor,
          elevation: 1,
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
          'Service Requests',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
      ),
      body: ListView.builder(
        // padding: const EdgeInsets.all(8),

        itemCount: serviceRequests.length,
        itemBuilder: (BuildContext context, int index) {
          var serviceRequest = serviceRequests[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ExpansionTileCard(
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              initialElevation: 3,
              baseColor: Colors.white,
              expandedColor: Colors.green[50],
              leading: CircleAvatar(
                backgroundColor: serviceRequest['requestStatus'] == "APPROVED"
                    ? Colors.green
                    : Color.fromRGBO(34, 167, 240, 1),
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(serviceRequest['requestType']),
              subtitle: Text(serviceRequest['location']),
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
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        maxRadius: 35,
                        backgroundImage:
                            NetworkImage(serviceRequest['photoUrl']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      serviceDisplay(
                          "Description", serviceRequest['serviceRequested']),
                      serviceDisplay("Service Requested By",
                          serviceRequest['requestorName']),
                      serviceRequest['requestStatus'] != "DECLINED"
                          ? serviceDisplay("Employer phone number",
                              serviceRequest['phoneNumber'])
                          : Text(""),
                      serviceDisplay(
                          "Meeting Date", serviceRequest['meetingDate'])
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                serviceRequest['requestStatus'] == "APPROVED"
                    ? statusButton(
                        Colors.green, serviceRequest['requestStatus'])
                    : serviceRequest['requestStatus'] == "PENDING"
                        ? statusButton(Color.fromRGBO(255, 200, 124, 1),
                            serviceRequest['requestStatus'])
                        : statusButton(
                            Colors.red[900], serviceRequest['requestStatus'])
              ],
            ),
          );
        },
      ),
    );
  }
}
