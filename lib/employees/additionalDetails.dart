import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyacademy/employees/googleForms.dart';
import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:nannyacademy/widgets/phoneNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
// import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:csc_picker/csc_picker.dart';

class AdditionalDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdditionalDetailsState();
}

class _AdditionalDetailsState extends State<AdditionalDetails> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _nameController = TextEditingController();
  final _occupationController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String _status = '';
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  final _secondNameController = TextEditingController();
  final _secondoccupationController = TextEditingController();
  final _secondrelationshipController = TextEditingController();
  final _secondaddressController = TextEditingController();
  final _secondemailAddressController = TextEditingController();
  final _secondphoneNumberController = TextEditingController();

  String secondcountryValue = "";
  String secondstateValue = "";
  String secondcityValue = "";
  String secondaddress = "";

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'guardianFullName',
        _nameController.text,
      );
      pref.setString(
        'relationship',
        _relationshipController.text,
      );
      pref.setString(
        'guardianAddress',
        _addressController.text,
      );
      pref.setString(
        'guardianCountry',
        countryValue,
      );
      pref.setString(
        'guardianState',
        stateValue,
      );
      pref.setString(
        'guardianCity',
        cityValue,
      );
      pref.setString(
        'guardianEmailAddress',
        _emailAddressController.text,
      );
      pref.setString(
        'guardianPhoneNumber',
        _phoneNumberController.text,
      );

      pref.setString(
        'secondguardianFullName',
        _secondNameController.text,
      );
      pref.setString(
        'secondrelationship',
        _secondrelationshipController.text,
      );
      pref.setString(
        'secondguardianAddress',
        _secondaddressController.text,
      );
      pref.setString(
        'secondguardianCountry',
        secondcountryValue,
      );
      pref.setString(
        'secondguardianState',
        secondstateValue,
      );
      pref.setString(
        'secondguardianCity',
        secondcityValue,
      );
      pref.setString(
        'secondguardianEmailAddress',
        _secondemailAddressController.text,
      );
      pref.setString(
        'secondguardianPhoneNumber',
        _secondphoneNumberController.text,
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleForms(),
      ),
    );
  }

  Widget _proceedButton() {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        label: Text(
          'Proceed',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () {
          if (_nameController.text != '' &&
              _relationshipController.text != '' &&
              _emailAddressController.text != '' &&
              (_occupationController.text != 'Date of Birth *') &&
              _addressController.text != '') {
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
                'Referees and Next of Kin Details (2/4)',
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
              "Emergency Contact Person 1: (FATHER/ HUSBAND/ BROTHER)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GenericTextField(Icons.person, _nameController, 'Full Name *'),
            GenericTextField(
                Icons.person_add, _relationshipController, 'Relationship *'),
            GenericTextField(
                Icons.cases, _occupationController, 'Occupation *'),
            PhoneNumberField(_phoneNumberController),
            GenericTextField(
              Icons.alternate_email,
              _emailAddressController,
              'Email Address *',
              TextInputType.emailAddress,
              Color.fromRGBO(34, 167, 240, 1),
            ),

            GenericTextField(
                Icons.location_on, _addressController, 'Physical Address *'),
            Container(
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: CSCPicker(
                  searchBarRadius: 10.0,
                  dropdownDialogRadius: 10.0,
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.grey, width: 1)),

                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  countryDropdownLabel: "Country *",
                  stateDropdownLabel: "State *",
                  cityDropdownLabel: "*City *",

                  defaultCountry: DefaultCountry.Nigeria,
                  // disableCountry: true,

                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),

                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                )),
            SizedBox(
              height: 30,
            ),
            //Second Referal
            Text(
              "Emergency Contact Person 2: (FATHER/ HUSBAND/ BROTHER/WIFE)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GenericTextField(
                Icons.person, _secondNameController, 'Full Name *'),
            GenericTextField(Icons.person_add, _secondrelationshipController,
                'Relationship *'),
            GenericTextField(
                Icons.cases, _secondoccupationController, 'Occupation *'),
            PhoneNumberField(_secondphoneNumberController),
            GenericTextField(
              Icons.alternate_email,
              _secondemailAddressController,
              'Email Address *',
              TextInputType.emailAddress,
              Color.fromRGBO(34, 167, 240, 1),
            ),

            GenericTextField(Icons.location_on, _secondaddressController,
                'Physical Address *'),
            Container(
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: CSCPicker(
                  searchBarRadius: 10.0,
                  dropdownDialogRadius: 10.0,
                  dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.grey, width: 1)),

                  disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.grey.shade300,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),

                  countryDropdownLabel: "Country *",
                  stateDropdownLabel: "State *",
                  cityDropdownLabel: "*City *",

                  defaultCountry: DefaultCountry.Nigeria,
                  // disableCountry: true,

                  selectedItemStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),

                  onCountryChanged: (value) {
                    setState(() {
                      secondcountryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      secondstateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      secondcityValue = value;
                    });
                  },
                )),

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
