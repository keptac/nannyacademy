import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employerRegistration.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class ServicesOffered extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ServicesOfferedState();
}

class _ServicesOfferedState extends State<ServicesOffered> {

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

            SizedBox(height: 60),

            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  value: 1,
                  groupValue: group,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Live-in (2 off days) ';
                    });
                  },
                ),
                Text('Live-in Care Giver (2 off days a Month)'),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: group,
                  value: 2,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Live-out (Mon to Sat)';
                    });
                  },
                ),
                Text('Live-out Care Giver (Mon to Sat)'),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 15.0),
                Radio(
                  groupValue: group,
                  value: 2,
                  onChanged: (T) {
                    setState(() {
                      group = T;
                      _serviceOption = 'Hourly (< 6 hours)';
                    });
                  },
                ),
                Text('Hourly Baby Sitter (< 6 hours)'),
              ],
            ),

            SizedBox(height: 40),

            Container(
              margin: EdgeInsets.only(left:20, right:30),
              child: Text(
                'Please note, before requesting for services Nanny Academy requests a commitment fee to proceed with finding care givers that suit your requirements',
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
              padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              label: Text(
                'Proceed to register',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed:  () {
                print(_serviceOption);
               Navigator.push(
               context, MaterialPageRoute(builder: (context) => EmployerRegistration()));
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
