import 'package:flutter/material.dart';

import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class GoogleForms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoogleFormsState();
}

class _GoogleFormsState extends State<GoogleForms> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _numberOfChildrenController = TextEditingController();
  final _workDurationController = TextEditingController();
  final _petController = TextEditingController();
  var experienceLevelSelected = 'Level 1';
  String serviceDurationSelected = 'Care giver';
  String _petVal = 'No';
  String _expPlaceVal = 'Both';
  int group = 1;
  int groupExp = 1;

  String _status = '';

  var experienceLevels = [
    {'name': '6 months or less', 'value': 'Level 1'},
    {'name': '6 months to 2 years', 'value': 'Level 2'},
    {'name': '3 or more years', 'value': 'Level 3'},
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
        'numberOfChildren',
        _numberOfChildrenController.text,
      );
      pref.setString(
        'workDuration',
        _workDurationController.text,
      );
      pref.setString(
        'serviceEmployeeOffers',
        serviceDurationSelected,
      );
      pref.setString(
        'experience',
        experienceLevelSelected,
      );
      pref.setString(
          'pets',
          _petVal == "No"
              ? _petVal
              : _petVal + ' (' + _petController.text + ')');
      pref.setString(
        'experiencePlace',
        _expPlaceVal,
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
          if (_numberOfChildrenController.text != '' &&
              _workDurationController.text != '') {
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

  Widget _radio() {
    return Padding(
      padding: EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: 15,
      ),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: group,
            onChanged: (T) {
              setState(() {
                group = T;
                _petVal = 'No';
              });
            },
          ),
          Text('No'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: group,
            value: 2,
            onChanged: (T) {
              setState(() {
                group = T;
                _petVal = 'Yes';
              });
            },
          ),
          Text('Yes'),
        ],
      ),
    );
  }

  Widget _experiencePlaces() {
    return Padding(
      padding: EdgeInsets.only(
        left: 40,
        right: 40,
        bottom: 15,
      ),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: groupExp,
            onChanged: (T) {
              setState(() {
                groupExp = T;
                _expPlaceVal = 'Home Care';
              });
            },
          ),
          Text('Home Care'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: groupExp,
            value: 2,
            onChanged: (T) {
              setState(() {
                groupExp = T;
                _expPlaceVal = 'Day Care';
              });
            },
          ),
          Text('Day Care'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: groupExp,
            value: 3,
            onChanged: (T) {
              setState(() {
                groupExp = T;
                _expPlaceVal = 'Both';
              });
            },
          ),
          Text('Both'),
        ],
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
              "EXPERIENCE",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Quicksand', color: Colors.blue),
            ),
            SizedBox(
              height: 20,
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
                value: experienceLevelSelected,
                icon: Icon(Icons.keyboard_arrow_down),
                items: experienceLevels.map((var experienceLevel) {
                  return DropdownMenuItem(
                    value: experienceLevel['value'],
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        experienceLevel['name'],
                        style: TextStyle(fontFamily: 'Quicksand', fontSize: 15),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    experienceLevelSelected = newValue;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 10),
              child: Text('Experience Place  : * '),
            ),
            _experiencePlaces(),
            SizedBox(
              height: 30,
            ),
            Text(
              "PREFERENCES",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Quicksand', color: Colors.blue),
            ),
            SizedBox(
              height: 30,
            ),

            Container(
              margin: EdgeInsets.only(left: 37, right: 37, bottom: 15),
              child: Text(
                "Please Select services you are registering to offer  *",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
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
            GenericTextField(
              Icons.people,
              _numberOfChildrenController,
              'Number of children prefered *',
              TextInputType.number,
              Color.fromRGBO(34, 167, 240, 1),
            ),

            GenericTextField(
              Icons.timelapse,
              _workDurationController,
              'Duration of employment in months *',
              TextInputType.number,
              Color.fromRGBO(34, 167, 240, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 10),
              child:
                  Text('Are you comfortable to work in a home with Pets: * '),
            ),
            _radio(),
            _petVal == "Yes"
                ? GenericTextField(
                    Icons.pets,
                    _petController,
                    'Specify the Pet (Dog/Cat) *',
                    TextInputType.text,
                    Color.fromRGBO(34, 167, 240, 1),
                  )
                : SizedBox(),

            Text(
              "ADDITIONAL DUTIES",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Quicksand', color: Colors.blue),
            ),
            SizedBox(
              height: 30,
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
