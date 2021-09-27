import 'package:flutter/material.dart';

import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:nannyacademy/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordCreation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordCreationState();
}

class _PasswordCreationState extends State<PasswordCreation> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassowordController = TextEditingController();
  String _errorMsg = '';
  String userTypeValue;

  void _register() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String firstName = prefs.getString('firstName');
    final String surname = prefs.getString('surname');
    final String idNumber = prefs.getString('idNumber');
    final String gender = prefs.getString('gender');
    final String dob = prefs.getString('dob');
    final String address = prefs.getString('address');
    final String phoneNumber = prefs.getString('phoneNumber');
    final String userType = prefs.getString('userType');
    userTypeValue = userType;

    final body = {
      "firstname": firstName,
      "surname": surname,
      "idNumber": idNumber,
      "gender": gender,
      "dob": dob,
      "phoneNumber": phoneNumber,
      "address": address,
      "userType": userType,
      "emailAddress": _emailController.text,
      "password": _passwordController.text,
      "channel": "MOBILE"
    };

    final authBody = {
      "idNumber": idNumber,
      "emailAddress": _emailController.text,
      "password": _passwordController.text,
      "channel": "MOBILE"
    };
    

    if (idNumber != null) {
      ApiService.registerUser(body).then((success) {
        if (success) {
          prefs.clear();
          _authReg(authBody, userType);
        } else {
          setState(() {
            _errorMsg = "An error occured while processing your request";
          });
          return;
        }
      });
    } else {
      setState(() {
        _errorMsg = "Failed to retrieve your details. Contact NANY ACADEMY";
      });
    }
  }

  void _authReg(var body, String userType) async {
    if (userType == 'nany') {
      final applicationBody = {
        "idNumber": body.idNumber,
        "registrationStatus": "pending",
        "channel": "MOBILE"
      };

      // Invoking Application Registration function if user is a nany
      _applicationReg(applicationBody);
    } else {
      // Making an API Call for auth Service
      ApiService.authReg(body).then((success) {
        if (success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          setState(() {
            _errorMsg = "An error occured while processing your request";
          });
          return;
        }
      });
    }
  }

  void _applicationReg(var body) async {
    // Making an API Call for Application Service
    ApiService.applicationReg(body).then((success) {
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        setState(() {
          _errorMsg = "An error occured while processing your request";
        });
        return;
      }
    });
  }

  Widget _textField(
      IconData icon, TextEditingController contolller, String label) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
        child: TextField(
          controller: contolller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: userTypeValue == 'nany'
                  ? Color.fromRGBO(216, 90, 102, 1)
                  : Color.fromRGBO(255, 200, 124, 1),
              size: 20,
            ),
            labelText: label,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordField(
      IconData icon, TextEditingController contolller, String label) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
        child: TextField(
          obscureText: true,
          controller: contolller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: userTypeValue == 'nany'
                  ? Color.fromRGBO(216, 90, 102, 1)
                  : Color.fromRGBO(255, 200, 124, 1),
              size: 20,
            ),
            labelText: label,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
          ),
        ),
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
          if (_emailController.text != '' &&
              _passwordController.text != '' &&
              _emailController.text != null &&
              _passwordController.text != null) {
            if (_passwordController.text == _confirmPassowordController.text) {
              _register();
            } else {
              setState(() {
                _errorMsg = 'Passwords do not match.';
              });
            }
          } else {
            setState(() {
              _errorMsg = 'All fields marked with (*) are required';
            });
          }
        },
        backgroundColor: userTypeValue == 'nany'
            ? Color.fromRGBO(216, 90, 102, 1)
            : Color.fromRGBO(255, 200, 124, 1),
        elevation: 1,
      ),
    );
  }

  Future<DateTime> getDate() {
    return showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
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
            Center(
              child: Image.asset(
                'assets/images/auth.png',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            SizedBox(height: 30),
            Center(
                child: Text(
              _errorMsg,
              style: TextStyle(color: Colors.red),
            )),
            SizedBox(height: 20),
            _textField(Icons.email, _emailController, 'Email Address *'),
            _passwordField(
                Icons.lock, _passwordController, 'Desired Password *'),
            _passwordField(Icons.lock_outline, _confirmPassowordController,
                'Verify Password *'),
            _proceedButton(),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
