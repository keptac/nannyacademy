import 'package:flutter/material.dart';

import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:nannyacademy/widgets/phoneNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:csc_picker/csc_picker.dart';

class GoogleForms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleFormsState();
}

class _GoogleFormsState extends State<GoogleForms> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _emailAddressController = TextEditingController();
  var employeeClassSelected = 'Level 1';
  String serviceDurationSelected = 'Care giver';
  String _status = '';

  var employeeClasses = [
    {'name': 'Nanny Level 1: N30, 000 to N35,000', 'value': 'Level 1'},
    {'name': 'Nanny Level 2:  N45, 000 to N65, 000', 'value': 'Level 2'},
    {'name': 'Nanny Level 3: N75, 000', 'value': 'Level 3'},
    {'name': 'Cooks: N60,000', 'value': 'Cook'}
  ];

  var serviceDurations = [
    {
      'name': 'Care Giver: Live-in / Live-out',
      'value': 'Care giver',
    },
    {
      'name': 'Nanny',
      'value': 'Nanny',
    },
    {
      'name': 'House Keeper',
      'value': 'House Keeper',
    },
    {'name': 'Cook', 'value': 'Cook'}
  ];

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'googleFormsEmailAddress',
        _emailAddressController.text,
      );
      pref.setString(
        'serviceEmployeeOffers',
        serviceDurationSelected,
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordCreation(userTypeValue: 'employee'),
      ),
    );
  }

  Widget _proceedButton() {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        label: Text(
          'Submit Application',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () {
          if (_emailAddressController.text != '') {
            _storePersonalDetails();
          } else {
            setState(() {
              _status = 'All fields marked with * are required!';
            });
          }
        },
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        elevation: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomSheet: KyBottomSheet(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 40),
          children: <Widget>[
            Center(
              child: Text(
                'Additional Information (3/4)',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            // SizedBox(height: 15),
            SizedBox(
              width: 10,
              height: 35,
              child: Text(
                _status,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),

            Text(
              "Please click on the link below and fill out additional information required *",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
            ),

            SizedBox(
              height: 30,
            ),

            Text(
              "https://google.com/forms/as66377gsfw252fa",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
            SizedBox(
              height: 30,
            ),
            GenericTextField(
              Icons.alternate_email,
              _emailAddressController,
              'Email Address used to fill form*',
              TextInputType.emailAddress,
              Color.fromRGBO(34, 167, 240, 1),
            ),
            SizedBox(
              height: 30,
            ),

            Container(
              margin: EdgeInsets.only(left: 37, right: 37, bottom: 15),
              child: Text(
                "Please Select services you are registering to offer  *",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
              ),
            ),

            Container(
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0) //
                    ),
                border: Border.all(color: Colors.grey),
              ),
              margin: EdgeInsets.only(left: 37, right: 37, bottom: 15),
              padding: EdgeInsets.only(left: 30),
              child: DropdownButton(
                underline: Text(""),
                value: serviceDurationSelected,
                icon: Icon(Icons.keyboard_arrow_down),
                items: serviceDurations.map((var serviceDurations) {
                  return DropdownMenuItem(
                    value: serviceDurations['value'],
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        serviceDurations['name'],
                        style: TextStyle(fontFamily: 'Quicksand', fontSize: 15),
                      ),
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
            _proceedButton(),
            SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
