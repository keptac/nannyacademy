import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employmentRequirements.dart';
import 'package:nannyacademy/passwordCreation.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesOffered extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServicesOfferedState();
}

class _ServicesOfferedState extends State<ServicesOffered> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _serviceOption = 'Live-in (2 off days)';
  int group = 1;

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
                'Choose a service to proceed',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  value: 1,
                  groupValue: group,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Care giver';
                    });
                  },
                ),
                Text('Care Giver: Live-in / Live-out',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left:60, right:30),
                child: Text('Live-out (works Mon to Sat only) positions are subject to availability and should be confirmed before commitment is made.', style: TextStyle(fontStyle: FontStyle.italic))
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: group,
                  value: 3,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Nanny';
                    });
                  },
                ),
                Text('Nanny',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: group,
                  value: 4,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'House Keeper';
                    });
                  },
                ),
                Text('House Keeper',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: group,
                  value: 5,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Cook';
                    });
                  },
                ),
                Text('Cook',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ],
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 20, right: 30),
              child: Text(
                'Please note: Nanny Academy requires a commitment fee of N7000 to proceed with finding you professionals that suit your requirements.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: ActionChip(
                padding:
                EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                label: Text(
                  'Agree and proceed',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () async {
                  final SharedPreferences pref = await _prefs;
                  pref.setString(
                    'serviceType',
                    _serviceOption,
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
