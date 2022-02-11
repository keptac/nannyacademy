import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class EmployeeRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeeRegistrationState();
}

class _EmployeeRegistrationState extends State<EmployeeRegistration> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _idController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _genderVal = 'Male';
  String _dobText = 'Date of Birth *';
  String _status = '';
  int group = 1;

  var _finaldate;

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'firstName',
        _nameController.text,
      );
      pref.setString(
        'idNumber',
        _idController.text,
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
        'dob',
        _dobText,
      );
      pref.setString(
        'address',
        _addressController.text,
      );
      pref.setString(
        'phoneNumber',
        _phoneNumberController.text,
      );
      pref.setString(
        'userType',
        'employee',
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordCreation(userTypeValue: 'employee'),
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
          'Submit Application',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () {
          if (_nameController.text != '' &&
              _surnameController.text != '' &&
              (_dobText != 'Date of Birth *' && _dobText != '') &&
              _addressController.text != '' &&
              _idController.text != '' &&
              _genderVal != '') {
            _storePersonalDetails();
          } else {
            setState(() {
              _status = 'All fields marked with * are required!';
            });
          }
        },
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
        elevation: 1,
      ),
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
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
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
                'Apply to Nanny Academy Training',
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
            GenericTextField(
                Icons.confirmation_number,
                _idController,
                'ID Number *',
                TextInputType.number,
                Color.fromRGBO(233, 166, 184, 1),
                11),
            _selectDate(context),
            _radio(),
            GenericTextField(
                Icons.location_on, _addressController, 'Physical Address *'),
            GenericTextField(
                Icons.phone,
                _phoneNumberController,
                'Phone Number *',
                TextInputType.number,
                Color.fromRGBO(233, 166, 184, 1),
                12),
            _proceedButton()
          ],
        ),
      ),
    );
  }
}
