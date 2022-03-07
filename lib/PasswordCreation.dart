import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
// import 'package:nannyacademy/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final _passwordController = TextEditingController();
  final _confirmPassowordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String _errorMsg = '';
  String requestNo = '';

  String statusResponse = "Profile creation in progress, please wait.";
  bool loading = false;

  void _getRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      requestNo = prefs.getString('requestNumber');
    });
  }

  void _register() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    final String firstName = prefs.getString('firstName');
    final String surname = prefs.getString('surname');
    final String gender = prefs.getString('gender');
    final String dob = prefs.getString('dob');
    final String address = prefs.getString('address');
    final String city = prefs.getString('city');
    final String country = prefs.getString('country');
    final String state = prefs.getString('state');
    final String phoneNumber = prefs.getString('phoneNumber');
    final String userType = prefs.getString('userType');
    final String requestNumber = prefs.getString('requestNumber');
    final String employeeClass = prefs.getString('employeeClass');
    final String serviceType = prefs.getString('serviceType');
    final String emailAddress = prefs.getString('emailAddress');

    if (surname != null) {
      try {
        final result = await _auth.createUserWithEmailAndPassword(
            email: emailAddress, password: _passwordController.text);

        final userid = result;

        final usertypeMapping = {
          "profileid": userid.user.uid,
          "userType": userType,
          "activated": true
        };

        await FirebaseFirestore.instance
            .collection('Account Type')
            .add(usertypeMapping);

        if (userType == 'employee') {
          final random = new Random();
          int randomNumber = random.nextInt(1000000);
          String applicationNumber = "APP" + randomNumber.toString();

          final applicationBody = {
            "profileid": userid.user.uid,
            "idNumber": '',
            "applicationStatus": "Pending",
            "channel": "MOBILE",
            "firstName": firstName,
            "surname": surname,
            "gender": gender,
            "dob": dob,
            "phoneNumber": phoneNumber,
            "address": address,
            "country": country,
            "city": city,
            "state": state,
            "userType": userType,
            "emailAddress": emailAddress,
            "applicationNumber": applicationNumber,
            "photoUrl": "",
            "employmentStatus": "Pending",
            "employer": ""
          };

          await FirebaseFirestore.instance
              .collection('Employee Accounts')
              .add(applicationBody);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blueGrey,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sucessfully Register.You may login now'),
              ),
              duration: Duration(seconds: 5),
            ),
          );

          setState(() {
            statusResponse = "Profile Created.";
          });

          //delay then route
          Future.delayed(
            const Duration(milliseconds: 3000),
            () {
              prefs.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          );
        } else {
          final body = {
            "profileid": userid.user.uid,
            "firstName": firstName,
            "surname": surname,
            "idNumber": '',
            "gender": gender,
            "dob": dob,
            "phoneNumber": phoneNumber,
            "address": address,
            "country": country,
            "city": city,
            "state": state,
            "userType": userType,
            "emailAddress": emailAddress,
            "channel": "MOBILE",
            "verificationStatus": "Pending",
            "photoUrl": "",
            "services": employeeClass+' '+serviceType,
            "employeeCount": 0,
            "activeEmployment": false,
            "employeeId": "",
            "employeeName": ""
          };

          var requestBody = {
            "serviceName": employeeClass,
            "serviceType": serviceType,
            "startAge": '',
            "endAge": '',
            "gender": '',
            "userId": userid.user.uid,
            "requestNumber": requestNumber,
            "paymentStatus": "Pending",
            "requestStatus": "Pending"
          };

          await FirebaseFirestore.instance
              .collection('Employer Accounts')
              .add(body);

          await FirebaseFirestore.instance
              .collection('Service Requests')
              .add(requestBody);

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     backgroundColor: Colors.blueGrey,
          //     content: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child:Text('Congratulations for registering with Nanny academy.  Please log on with details you created now, select the services you require and make the initial deposit to this account and upload the evidence of payment while we get in touch in few hours.')
          //               ),
          //     duration: Duration(seconds: 5),
          //   ),
          // );

          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Registration Success'),
              content: Text(
                  'Congratulations for registering with Nanny academy. Please log on with details you created now, select the services you require and make the initial deposit of N7000 and upload the evidence of payment while we get in touch in few hours.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Ok, Login'),
                )
              ],
            ),
          );

          setState(() {
            statusResponse = "Profile Created.";
          });

          // //delay then route
          // Future.delayed(
          //   const Duration(milliseconds: 3000),
          //   () {
          //     prefs.clear();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //       ),
          //     );
          //   },
          // );
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
          _errorMsg = "An error occured while processing your request";
        });
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(' Ops! Registration Failed'),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              )
            ],
          ),
        );
      }
    } else {
      setState(() {
        loading = false;
        _errorMsg = "Failed to retrieve your details. Contact NANY ACADEMY";
      });
    }
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
                  ? Color.fromRGBO(34, 167, 240, 1)
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
                  ? Color.fromRGBO(34, 167, 240, 1)
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
          if (_passwordController.text != '' &&
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
            ? Color.fromRGBO(34, 167, 240, 1)
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
    _getRequest();
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
              ),
            ),
            SizedBox(height: 20),
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
