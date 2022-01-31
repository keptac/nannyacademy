import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employerRegistration.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmploymentRequirements extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServicesOfferedState();
}

class _ServicesOfferedState extends State<EmploymentRequirements> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String _employmentRequirement = 'Any';

  int employmentRequirementGroup = 1;

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
                SizedBox(width: 15.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 3,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Accredited';
                    });
                  },
                ),
                Text('Accredited (Level 1)'),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 1,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Qualified';
                    });
                  },
                ),
                Text('Qualified (Level 2)'),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: employmentRequirementGroup,
                  value: 2,
                  onChanged: (T) {
                    setState(() {
                      employmentRequirementGroup = T;
                      _employmentRequirement = 'Experienced';
                    });
                  },
                ),
                Text('Experienced (Level 3)'),
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
                  final SharedPreferences pref = await _prefs;
                  pref.setString(
                    'Employment Requirement',
                    _employmentRequirement,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployerRegistration()),
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
