import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:intl/intl.dart';

import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class MyRequests extends StatefulWidget {
  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  List serviceRequests = [
    {
      "requestType": "Gardener",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested": "watering the garden ",
      "requestStatus": "pending",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000",
      "jobStatus": "pending"
    },
    {
      "requestType": "Gardener",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested": "watering the garden ",
      "requestStatus": "approved",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000",
      "jobStatus": "pending"
    },
  ];

  String _meetingText = 'Meeting Date *';
  var _finaldate;

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

  Future<DateTime> getDate() {
    return showRoundedDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 11),
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year - 9),
        borderRadius: 16);
  }

  void callDatePicker() async {
    var _newDateTime = await getDate();
    setState(() {
      _finaldate = DateFormat('dd-MM-yyyy').format(_newDateTime);
      _meetingText = _finaldate.toString();
    });
  }

  Widget _selectDate(context) {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 50, right: 50, top: 14, bottom: 14),
        label: Text(
          _meetingText,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: callDatePicker,
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
        elevation: 0,
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text(
        'Select Meeting Date',
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _selectDate(context),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Submit'),
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
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              initialElevation: 3,
              baseColor: Colors.white,
              expandedColor: serviceRequest['requestStatus'] == "approved"
                  ? Colors.green[50]
                  : Colors.orange[50],
              leading: CircleAvatar(
                backgroundColor: serviceRequest['requestStatus'] == "approved"
                    ? Colors.green
                    : Color.fromRGBO(255, 200, 124, 1),
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
                serviceRequest['requestStatus'] == "approved"
                    ? ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          serviceRequest['jobStatus'] == "granted"
                              ? ActionChip(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  label: Text(
                                    'Currently Employeed',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  onPressed: () {},
                                  backgroundColor: Colors.green,
                                  elevation: 1,
                                )
                              : Row(
                                  children: [
                                    ActionChip(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      label: Text(
                                        'Schedule Meeting',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupDialog(context),
                                        );
                                      },
                                      backgroundColor:
                                          Color.fromRGBO(255, 200, 124, 1),
                                      elevation: 1,
                                    ),
                                    SizedBox(width: 50),
                                    ActionChip(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      label: Text(
                                        'Offer Job',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                      onPressed: () {},
                                      backgroundColor: Colors.green,
                                      elevation: 1,
                                    ),
                                  ],
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
                              'Pending Approval',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {},
                            backgroundColor: Color.fromRGBO(255, 200, 124, 1),
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
