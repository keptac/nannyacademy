import 'package:flutter/material.dart';
import 'package:nannyacademy/uploadKyc.dart';
import 'package:nannyacademy/widgets/genericTextField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:nannyacademy/widgets/bottomSheet.dart';

class EmployerAdditionalInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployerAdditionalInfoState();
}

class _EmployerAdditionalInfoState extends State<EmployerAdditionalInfo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _activeEmployments = 'Yes';
  String _pets = 'Yes';
  String _pastEngagements = 'Yes';
  String _personalDevelopment = 'Yes';
  String _status = '';
  int group = 1;
  int petsGroup = 1;
  int engagementsGroup = 1;
  int developmentGroup = 1;
  final _languageCotnroller = TextEditingController();

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'gender',
        _activeEmployments,
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadKyc(),
      ),
    );
  }

  Widget _radio(var variablerGroup, var storage) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: variablerGroup,
            onChanged: (T) {
              setState(() {
                variablerGroup = T;
                storage = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: variablerGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                variablerGroup = T;
                storage = 'No';
              });
            },
          ),
          Text('No'),
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
          if (_activeEmployments != '') {
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
            SizedBox(height: 20),
            Center(
              child: Text(
                'Employment Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            SizedBox(
              width: 10,
              height: 35,
              child: Text(
                _status,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 15),
              child: Text('Do you employ any other domestic staff? * '),
            ),
            _radio(group, _activeEmployments),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 15),
              child: Text('Do you have any pets? * '),
            ),
            _radio(petsGroup, _pets),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 15),
              child: Text('Have you engaged a Nanny before? * '),
            ),
            _radio(engagementsGroup, _pastEngagements),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 15),
              child: Text(
                  'Will you be willing to allow your Nanny do part time studies or acquire any other skill in her sparetime? * '),
            ),
            _radio(developmentGroup, _personalDevelopment),
            GenericTextField(
              Icons.person,
              _languageCotnroller,
              'Language Preference *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            SizedBox(
              height: 10,
            ),
            _proceedButton()
          ],
        ),
      ),
    );
  }
}
