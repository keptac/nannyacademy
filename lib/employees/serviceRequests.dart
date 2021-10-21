import 'dart:io';

import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ServiceRequests extends StatefulWidget {
  @override
  _ServiceRequestsState createState() => _ServiceRequestsState();
}

class _ServiceRequestsState extends State<ServiceRequests> {
  List serviceRequests = [
    {
      "requestType": "Gardener",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested": "watering the garden ",
      "requestStatus": "apprved",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000"
    },
    {
      "requestType": "Nanny Services",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested":
          "Monitoring and cooking for 2 children while parent is at work",
      "requestStatus": "approved",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000"
    }
  ];

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
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
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
              expandedColor: serviceRequest['requestStatus'] == "approved"
                  ? Colors.green[50]
                  : Colors.red[50],
              leading: CircleAvatar(
                backgroundColor: serviceRequest['requestStatus'] == "approved"
                    ? Colors.green
                    : Color.fromRGBO(233, 166, 184, 1),
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
                      serviceDisplay(
                          "Description", serviceRequest['serviceRequested']),
                      serviceDisplay(
                          "Work Duration", serviceRequest['periodOfRequest']),
                      serviceDisplay("Service Requested By",
                          serviceRequest['requestorId']),
                      serviceDisplay("Salary", serviceRequest['salary']),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                serviceRequest['requestStatus'] != "approved"
                    ? ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          ActionChip(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            label: Text(
                              'Accept Offer',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onPressed: () {},
                            backgroundColor: Colors.green,
                            elevation: 1,
                          ),
                          ActionChip(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            label: Text(
                              'Decline Offer',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            onPressed: () {},
                            backgroundColor: Colors.red[900],
                            elevation: 1,
                          ),
                        ],
                      )
                    : ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          ActionChip(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            label: Text(
                              'Terminate Contract',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {},
                            backgroundColor: Color.fromRGBO(233, 166, 184, 1),
                            elevation: 1,
                          )
                        ],
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
