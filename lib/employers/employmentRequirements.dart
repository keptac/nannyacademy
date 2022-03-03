import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmploymentRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServicesOfferedState();
}

class _ServicesOfferedState extends State<EmploymentRequirements> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _employmentRequirement = 'Level 1';

  int employmentRequirementGroup = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomSheet: KyBottomSheet(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 80),
          children: <Widget>[
            Center(
              child: Text(
                'Nanny Academy Services',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                'Choose Qualification',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 1,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Level 1';
                    });
                  },
                ),
                Text('Nanny Level 1: N30, 000 to N35,000',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ],
            ),
            Container(
              margin: EdgeInsets.only(left:60, right:30),
              child: Text('Is an oriented personnel with 6 months or less experience. Background checks done', style: TextStyle(fontStyle: FontStyle.italic))
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 2,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Level 2';
                    });
                  },
                ),
                Text('Nanny Level 2:  N45, 000 to N65, 000 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left:60, right:30),
                child: Text('Is a trained professional with more than 6 months to 2 years of experience. Background checks done.',
                    style: TextStyle(fontStyle: FontStyle.italic))
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 3,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Level 3';
                    });
                  },
                ),
                Text('Nanny Level 3: N75, 000',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left:60,right:20),
                child: Text('Is a professional with 3 or more years of experience. Full background checks done.',

                style: TextStyle(fontStyle: FontStyle.italic))
            ),

            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 4,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Cook';
                    });
                  },
                ),
                Text('Cooks: N60,000 monthly salary',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: ActionChip(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                label: Text(
                  'Proceed to register',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () async {
                  final random = new Random();
                  int randomNumber = random.nextInt(10000000);
                  String requestNumber = "REQ" + randomNumber.toString();
                  final SharedPreferences pref = await _prefs;

                  pref.setString(
                    'employeeClass',
                    _employmentRequirement,
                  );

                  pref.setString(
                    'requestNumber',
                    requestNumber,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordCreation(userTypeValue: 'employer'),
                    ),
                  );
                },
                backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                elevation: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
