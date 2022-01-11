import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/admin/ADMINDASHBOARD.dart';
import 'package:nannyacademy/employees/dashboard.dart';
import 'package:nannyacademy/employers/employerDashboard.dart';
import 'package:nannyacademy/registrationOption.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _emailIsValid = true;
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _falsePassword = false;
  String _errorMessage;
  final _auth = FirebaseAuth.instance;

  void _login() async {

    //TODO: Remove this forced route
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EmployerDashboard(),
    //   ),
    // );

    setState(() {
      _falsePassword = false;
    });

    if (_emailController.text != '' &&
        _passwordController.text != '' &&
        _emailController.text != null &&
        _passwordController.text != null) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);

        final User user = _auth.currentUser;
        final uid = user.uid;

        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('Account Type')
            .where('profileid', isEqualTo: uid)
            .get();


        final List<DocumentSnapshot> documents = result.docs;

        final userTypeObject = documents[0].data();

        if (documents.length > 0) {
          //exists
          if (userTypeObject.toString().contains('true')) {
            if (userTypeObject.toString().contains('employee')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            } else if (userTypeObject.toString().contains('employer')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployerDashboard(),
                ),
              );
            } else if (userTypeObject.toString().contains('admin')) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminDashboard(),
                ),
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Pending Activation"),
                content: Text(
                    'Thank you for registering. Your profile is being verified. We will send you an email once your account is activated.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Ok'),
                  )
                ],
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Oops"),
              content: Text(
                  'Account details not found. Please contact Nanny Academy team.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Dismiss'),
                )
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Ops! Login Failed"),
            content: Text('${e.message}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Close'),
              )
            ],
          ),
        );
        print(e);
        setState(() {
          _errorMessage = e.message;
          _falsePassword = true;
        });
      }

      // TEST ROUTE MUST BE REMOVED

      // End of test route

    } else {
      setState(() {
        _errorMessage = "All fields marked with (*) are required";
        _falsePassword = true;
      });
    }
  }

  Widget _emailAddressTextField() {
    return SizedBox(
      height: 70,
      child: TextField(
        onTap: () => setState(() {
          _falsePassword = false;
          _errorMessage = '';
        }),
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
            size: 20,
          ),
          labelText: 'Email Address *',
          labelStyle: TextStyle(color: Colors.white),
          errorText:
              _emailIsValid ? null : 'Please enter a valid email address',
          enabledBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(35.0),
            ),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(35.0),
            ),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        onChanged: (String val) {
          if (val == null) {
            setState(() {
              _emailIsValid = false;
            });
          } else {
            setState(() {
              _emailIsValid = true;
            });
          }
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return SizedBox(
      height: 70,
      child: TextField(
        onTap: () => setState(() {
          _falsePassword = false;
          _errorMessage = '';
        }),
        controller: _passwordController,
        obscureText: !this._showPassword,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye,
                  size: 20,
                  color: this._showPassword ? Colors.yellow : Colors.white),
              onPressed: () {
                setState(() {
                  this._showPassword = !this._showPassword;
                });
              }),
          prefixIcon: Icon(Icons.lock, color: Colors.white, size: 20),
          labelText: 'Password *',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(35.0),
            ),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(35.0),
            ),
            borderSide: new BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        onChanged: (String val) {
          if (val == null) {
            setState(() {
              _emailIsValid = false;
            });
          } else {
            setState(() {
              _emailIsValid = true;
            });
          }
        },
      ),
    );
  }

  Widget _signInButton() {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
        label: Text(
          'Sign In',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: _login,
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
        elevation: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: AssetImage('assets/images/back.jpeg'),
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.8, 1.0],
              colors: [
                Color.fromRGBO(166, 233, 215, 1),
                Color.fromRGBO(255, 200, 124, 1),
                Color.fromRGBO(233, 166, 184, 1)
              ],
            ),
          ),
          child: Center(
            child: ListView(
              padding: EdgeInsets.only(left: 40.0, right: 40.0),
              children: <Widget>[
                SizedBox(
                  height: 130.0,
                ),
                Center(
                  child: Text(
                    'NANNY ACADEMY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                        fontSize: 40.0,
                        letterSpacing: 5.0),
                  ),
                ),
                SizedBox(
                  height: 90.0,
                ),
                _falsePassword
                    ? Center(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                              fontSize: 14),
                        ),
                      )
                    : Text(''),
                SizedBox(
                  height: 30.0,
                ),
                _emailAddressTextField(),
                SizedBox(height: 20),
                _passwordTextField(),
                SizedBox(
                  height: 45,
                ),
                _signInButton(),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: InkWell(
                    child: Text(
                      "Don't Have an account? Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationOptions())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
