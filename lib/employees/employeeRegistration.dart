import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyacademy/employees/additionalDetails.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:nannyacademy/widgets/phoneNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:csc_picker/csc_picker.dart';

class EmployeeRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeeRegistrationState();
}

class _EmployeeRegistrationState extends State<EmployeeRegistration> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _addressController = TextEditingController();
  final _religionController = TextEditingController();
  final _religionAddressController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _genderVal = 'Male';
  String _maritalStatus = 'Single';
  String _dobText = 'Date of Birth *';
  String _status = '';
  int group = 1;
  int maritalGroup = 1;
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  var _finaldate;

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'firstName',
        _nameController.text,
      );
      pref.setString(
        'surname',
        _surnameController.text,
      );
      pref.setString(
        'gender',
        _genderVal,
      );
      pref.setString(
        'maritalStatus',
        _maritalStatus,
      );
      pref.setString(
        'dob',
        _dobText,
      );
      pref.setString(
        'address',
        _addressController.text,
      );
      pref.setString(
        'country',
        countryValue,
      );
      pref.setString(
        'state',
        stateValue,
      );
      pref.setString(
        'city',
        cityValue,
      );
      pref.setString(
        'emailAddress',
        _emailAddressController.text,
      );
      pref.setString(
        'phoneNumber',
        _phoneNumberController.text,
      );
      pref.setString(
        'religion',
        _religionController.text,
      );
      pref.setString(
        'religionAddress',
        _religionAddressController.text,
      );

      pref.setString(
        'userType',
        'employee',
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdditionalDetails(),
      ),
    );
  }

  Widget _maritalStatusRadio() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 10, bottom: 15),
      child: Row(
        children: <Widget>[
          Text('Marital Status: * '),
          Radio(
            value: 1,
            groupValue: maritalGroup,
            onChanged: (T) {
              setState(() {
                maritalGroup = T;
                _maritalStatus = 'Single';
              });
            },
          ),
          Text('Single'),
          Radio(
            groupValue: maritalGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                maritalGroup = T;
                _maritalStatus = 'Married';
              });
            },
          ),
          Text('Married'),
          // Radio(
          //   groupValue: group,
          //   value: 3,
          //   onChanged: (T) {
          //     setState(() {
          //       group = T;
          //       _maritalStatus = 'Divorced';
          //     });
          //   },
          // ),
          // Text('Divorced'),
        ],
      ),
    );
  }

  Widget _radio() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Text('Select Gender: * '),
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
          SizedBox(width: 15.0),
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
              _surnameController.text != '' &&
              _emailAddressController.text != '' &&
              (_dobText != 'Date of Birth *' && _dobText != '') &&
              _addressController.text != '' &&
              _genderVal != '') {
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

  Future<DateTime> getDate() {
    return showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year - 16),
        fieldHintText: "DATE/MONTH/YEAR",
        errorFormatText: "Enter a Valid Date",
        errorInvalidText: "Date Out of Range",
        initialDatePickerMode: DatePickerMode.year,
        initialEntryMode: DatePickerEntryMode.input);
  }

  void callDatePicker() async {
    var _newDateTime = await getDate();
    setState(() {
      _finaldate = DateFormat('dd-MM-yyyy').format(_newDateTime);
      _dobText = _finaldate.toString();
    });
  }

  Widget _selectDate(context) {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 100, right: 100, top: 14, bottom: 14),
        label: Text(
          _dobText,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: callDatePicker,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        elevation: 0,
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
                'Apply to Nanny Academy Training (1/4)',
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
            GenericTextField(Icons.person, _nameController, 'First Name *'),
            GenericTextField(
                Icons.perm_identity, _surnameController, 'Surname *'),
            _selectDate(context),
            _radio(),
            _maritalStatusRadio(),

            GenericTextField(
                Icons.person_add, _religionController, 'Religion *'),
            GenericTextField(Icons.person_add, _religionAddressController,
                'Address of Worhip place *'),
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
            _proceedButton(),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
