import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employerRegistration.dart';
import 'package:nannyacademy/employees/employeeRegistration.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class RegistrationOptions extends StatelessWidget {
  Widget _optionButton(
      BuildContext context, String option, var page, Color color) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Text(
          option,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(55),
          primary: color, //
          onPrimary: Colors.red, //
        ),
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
          padding: EdgeInsets.only(top: 60),
          children: <Widget>[
            Center(
              child: Text(
                'Lets Get Started !',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'You would like to register As?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 10,
              height: 35,
              child: Text(
                "",
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Row(
                children: [
                  _optionButton(context, 'Care giver', EmployeeRegistration(),
                      Color.fromRGBO(233, 166, 184, 1)),
                  // SizedBox(width: 10),
                  _optionButton(context, 'Client', EmployerRegistration(),
                      Color.fromRGBO(255, 200, 124, 1)),
                ],
              ),
            ),
            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
