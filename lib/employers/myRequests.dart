import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class MyRequests extends StatefulWidget {
  final String jobStatus;

  MyRequests({Key key, @required this.jobStatus}):super(key: key);

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {

  // List serviceRequests = [
  //   {
  //     "firstName": "Charlotte",
  //     "surname": "Chelenje",
  //     "gender": "FEMALE",
  //     "age": "23",
  //     "services": "Nanny",
  //     "location": "Lagos",
  //     "phoneNumber": "263785302628",
  //     "photoUrl":
  //         "https://lh3.googleusercontent.com/ogw/ADea4I4wWPHXockcfJemnnm4OGPaSrhXIVmqium_Zoe9=s192-c-mo",
  //     "employeeId": "58-293952-Q-86",
  //     "jobStatus": "Granted",
  //     "requestStatus": "Approved",
  //     "serviceRequested": "watering the garden ",
  //     "requestType": "Gardener",
  //     "meetingDate": "2021-10-30",
  //     "active": "1",
  //     "salary": "1000",
  //     "requestNumber": "REQ67889997",
  //   }
  // ];

  int index = 0;

  String _meetingText = 'Meeting Date *';
  var _finalDate;

  void _scheduleMeeting(var body) async {
    try {
      //Get the document ID to update
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('Employments')
          .where('requestNumber', isEqualTo: body['requestNumber'])
          .get();
      await FirebaseFirestore.instance
          .collection('Employments')
          .doc(result.docs[0].id)
          .update({'meetingDate':_finalDate});

      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Meeting rescheduled successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRequests(jobStatus:'Pending'),
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

  void _offerJob(var body) async {
    try {
      //Get the document ID to update
      final QuerySnapshot serviceRequestId = await FirebaseFirestore.instance
          .collection('Service Requests')
          .where('requestNumber', isEqualTo: body['requestNumber'])
          .get();
      await FirebaseFirestore.instance
          .collection('Service Requests')
          .doc(serviceRequestId.docs[0].id)
          .update({'requestStatus':'Completed'});

      final QuerySnapshot employmentDocumentId = await FirebaseFirestore.instance
          .collection('Employments')
          .where('requestNumber', isEqualTo: body['requestNumber'])
          .get();
      await FirebaseFirestore.instance
          .collection('Employments')
          .doc(employmentDocumentId.docs[0].id)
          .update({'jobStatus':'Granted'});

      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Job offer successfully submitted. You will receive an email shortly with your confirmation and invoice details.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyRequests(jobStatus:'Granted'),
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
          title: Text(' Ops! Failed to offer job. Try again later.'),
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
      _finalDate = DateFormat('dd-MM-yyyy').format(_newDateTime);
      _meetingText = _finalDate.toString();
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
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Employments')
        .where('jobStatus', isEqualTo: widget.jobStatus)
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ExpansionTileCard(
                  borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  initialElevation: 3,
                  baseColor: Colors.white,
                  expandedColor: serviceRequest['requestStatus'] == "Approved"
                      ? Colors.green[50]
                      : Colors.orange[50],
                  leading: CircleAvatar(
                    backgroundColor: serviceRequest['requestStatus'] == "Approved"
                        ? Colors.green
                        : Color.fromRGBO(255, 200, 124, 1),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(color: Colors.white),
                    ),
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
                            backgroundImage:
                            NetworkImage(serviceRequest['photoUrl']),
                          )
                              : SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          serviceDisplay(
                              "Request Number", serviceRequest['requestNumber']),
                          serviceDisplay("Services", serviceRequest['services']),
                          serviceDisplay("Gender", serviceRequest['gender']),
                          serviceDisplay("Age", serviceRequest['age']),
                          serviceRequest['requestStatus'] == "Approved"
                              ? serviceDisplay(
                              "Phone Nunber", serviceRequest['phoneNumber'])
                              : Text(""),
                          serviceDisplay("Request Description",
                              serviceRequest['serviceRequested']),
                          serviceDisplay(
                              "Service Requested By", serviceRequest['location']),
                          serviceDisplay(
                              "Meeting Date", serviceRequest['meetingDate']),
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
                                      _buildPopupDialog(context, serviceRequest),
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
                              onPressed: () {
                                _offerJob(serviceRequest);
                              },
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
            }).toList(),
          );
        })
    );
  }
}
