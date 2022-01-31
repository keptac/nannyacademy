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
  String _activeEmployments = 'No';
  String _pets = 'No';
  String _pastEngagements = 'No';
  String _personalDevelopment = 'No';
  String _firstAid = 'No';
  String _status = '';
  int group = 2;
  int petsGroup = 2;
  int engagementsGroup = 2;
  int developmentGroup = 2;
  int firstAidGroup = 2;
  final _languageController = TextEditingController();

  void _storePersonalDetails() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      pref.setString(
        'activeEmployments',
        _activeEmployments,
      );
      pref.setString(
        'pets',
        _pets,
      );
      pref.setString(
        'engagements',
        _pastEngagements,
      );
      pref.setString(
        'personalDevelopment',
        _personalDevelopment,
      );
      pref.setString(
        'firstAid',
        _firstAid,
      );
      pref.setString(
        'language',
        _languageController.text,
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadKyc(),
      ),
    );
  }

  Widget _radioActiveEmp() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: group,
            onChanged: (T) {
              setState(() {
                group = T;
                _activeEmployments = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: group,
            value: 2,
            onChanged: (T) {
              setState(() {
                group = T;
                _activeEmployments = 'No';
              });
            },
          ),
          Text('No'),
        ],
      ),
    );
  }

  Widget _radioPets() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: petsGroup,
            onChanged: (T) {
              setState(() {
                petsGroup = T;
                _pets = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: petsGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                petsGroup = T;
                _pets = 'No';
              });
            },
          ),
          Text('No'),
        ],
      ),
    );
  }

  Widget _radioEngagements() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: engagementsGroup,
            onChanged: (T) {
              setState(() {
                engagementsGroup = T;
                _pastEngagements = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: engagementsGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                engagementsGroup = T;
                _pastEngagements = 'No';
              });
            },
          ),
          Text('No'),
        ],
      ),
    );
  }

  Widget _radioPersonalDevelopment() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: developmentGroup,
            onChanged: (T) {
              setState(() {
                developmentGroup = T;
                _personalDevelopment = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: developmentGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                developmentGroup = T;
                _personalDevelopment = 'No';
              });
            },
          ),
          Text('No'),
        ],
      ),
    );
  }

  Widget _radioFirstAid() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: firstAidGroup,
            onChanged: (T) {
              setState(() {
                firstAidGroup = T;
                _firstAid = 'Yes';
              });
            },
          ),
          Text('Yes'),
          SizedBox(width: 15.0),
          Radio(
            groupValue: firstAidGroup,
            value: 2,
            onChanged: (T) {
              setState(() {
                firstAidGroup = T;
                _firstAid = 'No';
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
              padding: EdgeInsets.only(left: 40, right: 40, top: 5),
              child: Text('Do you employ any other domestic staff? * '),
            ),
            _radioActiveEmp(),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 5),
              child: Text('Do you have any pets? * '),
            ),
            _radioPets(),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 5),
              child: Text('Have you engaged a Nanny before? * '),
            ),
            _radioEngagements(),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 5),
              child: Text(
                  'Will you be willing to allow your Nanny do part time studies or acquire any other skill in her sparetime? * '),
            ),
            _radioPersonalDevelopment(),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 5),
              child: Text(
                  'Do you want your Nanny to have an up to date First Aid qualification? * '),
            ),
            _radioFirstAid(),
            GenericTextField(
              Icons.settings_voice_rounded,
              _languageController,
              'Language Preference *',
              TextInputType.text,
              Color.fromRGBO(255, 200, 124, 1),
            ),
            SizedBox(
              height: 10,
            ),
            _proceedButton(),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
