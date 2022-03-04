import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/employers/myRequests.dart';

class SearchResults extends StatefulWidget {
  final String requestNumber;

  SearchResults({Key key, @required this.requestNumber}) : super(key: key);
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  //TODO: request from server the requests. all requestsResults with widget.requestNumber
  List serviceRequestResults = [
    // {
    //   "verified": true,
    //   "firstName": "Batsirai",
    //   "surname": "Gwembere",
    //   "gender": "MALE",
    //   "age": "25",
    //   "services": "Gardener",
    //   "location": "Lagos",
    //   "phoneNumber": "263785********",
    //   "photoUrl":
    //       "https://lh3.googleusercontent.com/ogw/ADea4I4wWPHXockcfJemnnm4OGPaSrhXIVmqium_Zoe9=s192-c-mo",
    //   "employeeId": "58-293952-Q-86",
    //   "jobStatus": "Pending",
    //   "requestStatus": "Approved",
    //   "serviceRequested": "Silver 1 - Stay In ",
    //   "active": "1",
    //   "salary": "1000",
    //   "requestNumber": "REQ678897",
    //   "employerId": "763",
    //   "employerName": "Name",
    // },
  ];

  File popFile;
  String _meetingText = 'Meeting Date *';
  String popText = 'POP *';
  String _errorMsg = '';

  var _finalDate;
  final _receiptNumber = TextEditingController();
  final _amount = TextEditingController();

  void _scheduleMeeting(var body) async {
    body['meetingDate'] = _finalDate;
    body['jobStatus'] = "Hold";

    try {
      await FirebaseFirestore.instance.collection('Employments').add(body);
      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Meeting scheduled successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRequests(jobStatus: 'Hold'),
                  ),
                );
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
          title: Text(' Ops! Failed to Schedule Meeting. Try again later.'),
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

  void _choose() async {
    popFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      popText = popFile.path.split("/").last;
    });
  }

  //Uploads the files
  void _upload() async {
    if (popFile == null) {
      setState(() {
        _errorMsg = 'Please Proof of payment';
      });
    } else {
      String popBase64Image = base64Encode(popFile.readAsBytesSync());
      String popFileName = popFile.path.split("/").last;

      final data = {
        "requestNumber": widget.requestNumber,
        "amount": _amount.text,
        "receiptNumber": _receiptNumber.text,
        "pof": {
          "image": popBase64Image,
          "name": popFileName,
          "description": "Proof of Payment File upload"
        },
      };

      try {
        await FirebaseFirestore.instance.collection('Payments').add(data);

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(' Success!'),
            content: Text('Proof of payment has been submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Close'),
              )
            ],
          ),
        );
      } on FirebaseException catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(' Oops! Upload failed try again later.'),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Close'),
              )
            ],
          ),
        );
      }

      Navigator.pop(context);
    }
  }

  void callDatePicker() async {
    var _newDateTime = await getDate();
    setState(() {
      _finalDate = DateFormat('dd-MM-yyyy').format(_newDateTime);
      _meetingText = _finalDate.toString();
    });
  }

  Future<DateTime> getDate() {
    return showRoundedDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 11),
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year - 9),
        borderRadius: 16);
  }

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

  Widget _selectDate(context) {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 50, right: 50, top: 14, bottom: 14),
        label: Text(
          _meetingText,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: callDatePicker,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        elevation: 0,
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, var serviceRequest) {
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
            _scheduleMeeting(serviceRequest);

            Navigator.of(context).pop();
          },
          // textColor: Theme.of(context).primaryColor,
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget _uploadPop(BuildContext context) {
    return new AlertDialog(
      title: Center(
        child: Text(
          widget.requestNumber,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_errorMsg),
          SizedBox(height: 10),
          TextField(
            controller: _amount,
            keyboardType: TextInputType.number,
            style: TextStyle(fontFamily: 'Quicksand', fontSize: 12),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.monetization_on_sharp,
                color: Color.fromRGBO(255, 200, 124, 1),
                size: 20,
              ),
              labelText: 'Amount Paid *',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _receiptNumber,
            keyboardType: TextInputType.text,
            style: TextStyle(fontFamily: 'Quicksand', fontSize: 12),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.payment,
                color: Color.fromRGBO(255, 200, 124, 1),
                size: 20,
              ),
              labelText: 'Transaction Reference*',
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _uploadButton(popText),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _upload();
          },
          child: const Text('Submit Proof'),
        ),
      ],
    );
  }

  Widget _uploadButton(String label) {
    return InkWell(
      child: Card(
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 0,
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 170),
                    child: Icon(
                      Icons.file_present,
                      color: Color.fromRGBO(255, 200, 124, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onTap: () => _choose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Search Results',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: serviceRequestResults.length > 0
          ? ListView.builder(
              itemCount: serviceRequestResults.length,
              itemBuilder: (BuildContext context, int index) {
                var serviceRequest = serviceRequestResults[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ExpansionTileCard(
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                    initialElevation: 3,
                    baseColor: Colors.white,
                    expandedColor: serviceRequest['requestStatus'] == "Approved"
                        ? Colors.green[50]
                        : Colors.orange[50],
                    leading: CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: NetworkImage(serviceRequest['photoUrl']),
                    ),
                    title: serviceRequest['requestStatus'] == "Approved"
                        ? Text(serviceRequest['firstName'] +
                            ' ' +
                            serviceRequest['surname'])
                        : Text(serviceRequest['firstName']),
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
                            serviceRequest['requestStatus'] == "Approved"
                                ? CircleAvatar(
                                    maxRadius: 30,
                                    backgroundImage: NetworkImage(
                                        serviceRequest['photoUrl']),
                                  )
                                : SizedBox(
                                    height: 10,
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            serviceDisplay("Request Number",
                                serviceRequest['requestNumber']),
                            serviceDisplay(
                                "Services", serviceRequest['services']),
                            serviceDisplay("Gender", serviceRequest['gender']),
                            serviceDisplay("Age", serviceRequest['age']),
                            serviceRequest['requestStatus'] == "Approved"
                                ? serviceDisplay("Phone Number",
                                    serviceRequest['phoneNumber'])
                                : Text(""),
                            serviceDisplay("Request Description",
                                serviceRequest['serviceRequested']),
                            serviceDisplay("Service Requested By",
                                serviceRequest['location']),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      serviceRequest['requestStatus'] == "Approved"
                          ? ButtonBar(
                              alignment: MainAxisAlignment.spaceAround,
                              buttonHeight: 52.0,
                              buttonMinWidth: 90.0,
                              children: <Widget>[
                                serviceRequest['jobStatus'] == "Granted"
                                    ? ActionChip(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        label: Text(
                                          'Currently Employeed',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
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
                                                  color: Colors.white,
                                                  fontSize: 13),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        _buildPopupDialog(
                                                            context,
                                                            serviceRequest),
                                              );
                                            },
                                            backgroundColor: Color.fromRGBO(
                                                255, 200, 124, 1),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  onPressed: () {},
                                  backgroundColor:
                                      Color.fromRGBO(255, 200, 124, 1),
                                  elevation: 1,
                                )
                              ],
                            )
                    ],
                  ),
                );
              },
            )
          : Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Center(
                  child: Text(
                    "No results returned. \nPending payment confirmation.",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ActionChip(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    label: Text(
                      'Upload Proof of Payment',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _uploadPop(context),
                      );
                    },
                    backgroundColor: Colors
                        .black, //Color.fromRGBO(255, 200, 124, 1), //Color.fromRGBO(34, 167, 240, 1),
                    elevation: 1,
                  ),
                )
              ],
            ),
    );
  }
}
