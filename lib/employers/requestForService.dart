import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:math';
import 'package:nannyacademy/termsAndConditions.dart' as fullDialog;

class RequestForService extends StatefulWidget {
  @override
  _RequestForServiceState createState() => _RequestForServiceState();
}

class _RequestForServiceState extends State<RequestForService> {
  final _cityController = TextEditingController();
  final _startAgeController = TextEditingController();
  final _endAgeController = TextEditingController();
  String _genderVal = 'Male';
  int group = 1;
  final LocalStorage storage = new LocalStorage('employeePreference');
  String employeeClassSelected = 'Silver (xp 0 - 6 Months)';
  String serviceDurationSelected = 'Live-in (2 off days)';
  var employeeClasses = [
    'Silver (xp 0 - 6 Months)',
    'Gold (xp 1 - 2 Years)',
    'Platinum (xp 3+ Years)'
  ];

  var serviceDurations = [
    'Live-in (2 off days)',
    'Live-out (Mon to Sat)',
    'Hourly (< 6 hours)'
  ];

  Widget _radio() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 10, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Text('Gender: * '),
          Radio(
            value: 1,
            groupValue: group,
            onChanged: (T) {
              setState(() {
                group = T;
                _genderVal = 'Male';
              });
            },
          ),
          Text('Male'),
          // SizedBox(width: 15.0),
          Radio(
            groupValue: group,
            value: 2,
            onChanged: (T) {
              setState(() {
                group = T;
                _genderVal = 'Female';
              });
            },
          ),
          Text('Female'),
        ],
      ),
    );
  }

  Future _openAgreeDialog(context, var employeeClass, var serviceType) async {
    final random = new Random();
    int randomNumber = random.nextInt(1000000);
    String requestNumber = "REQ" + randomNumber.toString();
    var requestBody = {
      "serviceName": employeeClass,
      "startSalary": serviceType,
      "startAge": _startAgeController.text,
      "endAge": _endAgeController.text,
      "gender": _genderVal,
      "userId": "1000", //Get from user session
      "requestId": requestNumber,
      "paymentStatus": "Pending"
    };

    final info = json.encode(requestBody);

    storage.setItem('info', info);

    String result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.CreateAgreement(
              requestBody: requestBody, requestNumber: requestNumber);
        },
        fullscreenDialog: true));
    print(result);
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
          value == null ? '' : value,
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
          'Request for Service',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.72,
                child: Card(
                  child: ListView(
                    padding: EdgeInsets.only(top: 30),
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(left: 37, right: 37, bottom: 10),
                        child: Text("Nanny Class"),
                      ),
                      Container(
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0) //
                                  ),
                          border: Border.all(color: Colors.grey),
                        ),
                        margin:
                            EdgeInsets.only(left: 37, right: 37, bottom: 15),
                        child: DropdownButton(
                          underline: Text(""),
                          value: employeeClassSelected,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: employeeClasses.map((String employeeClasses) {
                            return DropdownMenuItem(
                              value: employeeClasses,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Text(employeeClasses),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              employeeClassSelected = newValue;
                            });
                          },
                        ),
                      ),

                      Container(
                        margin:
                            EdgeInsets.only(left: 37, right: 37, bottom: 10),
                        child: Text("Service Type"),
                      ),

                      Container(
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0) //
                                  ),
                          border: Border.all(color: Colors.grey),
                        ),
                        margin:
                            EdgeInsets.only(left: 37, right: 37, bottom: 15),
                        child: DropdownButton(
                          underline: Text(""),
                          value: serviceDurationSelected,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items:
                              serviceDurations.map((String serviceDurations) {
                            return DropdownMenuItem(
                              value: serviceDurations,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Text(serviceDurations),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValue) {
                            setState(() {
                              serviceDurationSelected = newValue;
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: 70,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, bottom: 15),
                          child: TextField(
                            controller: _cityController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Color.fromRGBO(255, 200, 124, 1),
                                size: 20,
                              ),
                              labelText: 'City/Location *',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, bottom: 15),
                          child: TextField(
                            controller: _startAgeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_add_alt,
                                color: Color.fromRGBO(255, 200, 124, 1),
                                size: 20,
                              ),
                              labelText: 'Start Age *',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, bottom: 15),
                          child: TextField(
                            controller: _endAgeController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_add_alt,
                                color: Color.fromRGBO(255, 200, 124, 1),
                                size: 20,
                              ),
                              labelText: 'Ending Age *',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                      ),

                      _radio(),
                      // ]),
                      ActionChip(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        label: Text(
                          'Search Service',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          _openAgreeDialog(context, employeeClassSelected,
                              serviceDurationSelected);
                        },
                        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                        elevation: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
