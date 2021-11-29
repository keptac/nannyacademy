import 'package:flutter/material.dart';

import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:nannyacademy/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const spinkit = SpinKitChasingDots(
  color: Colors.green,
  size: 30.0,
);

class PasswordCreation extends StatefulWidget {
  final userTypeValue;
  PasswordCreation({Key key, @required this.userTypeValue}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordCreationState();
}

class _PasswordCreationState extends State<PasswordCreation> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassowordController = TextEditingController();
  String _errorMsg = '';

  String statusResponse = "Profile Created. KYC verification in progress.";
  bool loading = false;

  void _register() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    final String firstName = prefs.getString('firstName');
    final String surname = prefs.getString('surname');
    final String idNumber = prefs.getString('idNumber');
    final String gender = prefs.getString('gender');
    final String dob = prefs.getString('dob');
    final String address = prefs.getString('address');
    final String phoneNumber = prefs.getString('phoneNumber');
    final String userType = prefs.getString('userType');

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
            loading = false;
            _errorMsg = "An error occured while processing your request";
          });
          return;
        }
      });
    } else {
      setState(() {
        loading = false;
        _errorMsg = "Failed to retrieve your details. Contact NANY ACADEMY";
      });
    }
  }

  void _authReg(var body, String userType) async {
    if (userType == 'nanny') {
      final applicationBody = {
        "idNumber": body.idNumber,
        "registrationStatus": "pending",
        "channel": "MOBILE"
      };

      // Invoking Application Registration function if user is a nanny
      _applicationReg(applicationBody);
    } else {
      // Making an API Call for auth Service
      ApiService.authReg(body).then((success) {
        if (success) {
          setState(() {
            statusResponse = "Profile Created. KYC verification in progress.";
          });
          //delay then route
          Future.delayed(
            const Duration(milliseconds: 3000),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          );
        } else {
          loading = false;
          setState(() {
            _errorMsg = "An error occured while processing your request";
          });
          return;
        }
      });
    }
  }

  void _applicationReg(var body) async {
    ApiService.applicationReg(body).then((success) {
      if (success) {
        setState(() {
          statusResponse = "Application submitted successfully.";
        });

        Future.delayed(
          const Duration(milliseconds: 3000),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        );
      } else {
        loading = false;
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
              color: widget.userTypeValue == 'employee'
                  ? Color.fromRGBO(233, 166, 184, 1)
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
              color: widget.userTypeValue == 'employee'
                  ? Color.fromRGBO(233, 166, 184, 1)
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
          'Register',
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
        backgroundColor: widget.userTypeValue == 'employee'
            ? Color.fromRGBO(233, 166, 184, 1)
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
            !loading
                ? _proceedButton()
                : Column(
                    children: [
                      SizedBox(height: 20),
                      spinkit,
                      SizedBox(height: 15),
                      Text(statusResponse)
                    ],
                  ),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
