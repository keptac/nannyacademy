import 'package:flutter/material.dart';
import 'dart:io';
import 'package:nannyacademy/employees/dashboard.dart';

class PersonalDetails extends StatefulWidget {
  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  File idFile;
  File pofFile;
  var data;
  String _errorMsg = '';
  final _marriageController = TextEditingController();
  final _friendDescribeController = TextEditingController();
  final _childBenefitController = TextEditingController();
  final _whyNannyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _upload() {
    if (_childBenefitController.text == null &&
        _whyNannyController.text == null &&
        _friendDescribeController.text == null &&
        pofFile == null) {
      setState(() {
        _errorMsg = 'Please provide all required fields';
      });
      return;
    } else {}
  }

  Widget _proceedButton() {
    return Center(
      child: ActionChip(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
        label: Text(
          'Save',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () => _upload(),
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        elevation: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // leading: InkWell(
        //   child: Icon(
        //     Icons.notifications_active,
        //     color: Colors.yellow,
        //   ),
        //   onTap: () => print('You have no new messages'),
        // ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  size: 26.0,
                ),
              )),
        ],
        elevation: 0.0,
        title: Text(
          'Nanny Academy',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 20),
          children: <Widget>[
            SizedBox(
                child: Text(
                  'Update your Personal Information',
                  style: TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
                  textAlign: TextAlign.center,
                ),
                height: 40),
            Center(
              child: Text(
                _errorMsg,
                style: TextStyle(
                    color: Colors.orange, fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 50, bottom: 10, right: 40, top: 20),
              child: Text(
                  "Please describe your family. Were you married before? Do you have any child out of wedlock? *"),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _marriageController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.question_answer,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Family Describe *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 50, bottom: 10, right: 40, top: 20),
              child: Text(
                  "Please tell us how do your friends might describe you *"),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _friendDescribeController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.question_answer,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Describe *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 50, bottom: 10, right: 40, top: 20),
              child: Text(
                  "Please tell us how the child you care for will benefit from having you as their Nanny and any hobby or ideas you will bring to the job"),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _childBenefitController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lightbulb,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Describe *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 50, bottom: 10, right: 40, top: 20),
              child: Text(
                  "Please tell us again why you would like to be employed as a Nanny*"),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _whyNannyController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.question_answer,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Why *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _proceedButton(),
            SizedBox(height: 60),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go Back to Home',
        elevation: 0.8,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        child: const Icon(Icons.home),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard())),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            height: 60,
          )),
    );
  }
}
