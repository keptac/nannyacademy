import 'package:flutter/material.dart';
import 'package:nannyacademy/PasswordCreation.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class EmployerRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployerRegistrationState();
}

class _EmployerRegistrationState extends State<EmployerRegistration> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _idController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _genderVal = 'Male';
  String _status = '';
  int group = 1;

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
        '',
      );
      pref.setString(
        'address',
        _addressController.text,
      );
      pref.setString(
        'phoneNumber',
        _addressController.text,
      );
      pref.setString(
        'userType',
        'nany',
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordCreation(),
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
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomSheet: KyBottomSheet(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 60),
          children: <Widget>[
            SizedBox(height: 60),
            Center(
              child: Text(
                'Let us know who you are 😊',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 10,
              height: 35,
              child: Text(
                _status,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            GenericTextField(
              Icons.person,
              _nameController,
              'First Name *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            GenericTextField(
              Icons.perm_identity,
              _surnameController,
              'Surname *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            GenericTextField(
              Icons.confirmation_number,
              _idController,
              'ID Number *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            _radio(),
            GenericTextField(
              Icons.location_on,
              _addressController,
              'Physical Address *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            GenericTextField(
              Icons.phone,
              _phoneNumberController,
              'Phone Number *',
              TextInputType.number,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            _proceedButton()
          ],
        ),
      ),
    );
  }
}