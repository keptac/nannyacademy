import 'package:flutter/material.dart';
import 'dart:io';
import 'package:nannyacademy/employees/dashboard.dart';

class EducationalBackground extends StatefulWidget {
  @override
  _EducationalBackgroundState createState() => _EducationalBackgroundState();
}

class _EducationalBackgroundState extends State<EducationalBackground> {
  File idFile;
  File pofFile;
  var data;
  String _errorMsg = '';
  final _schoolAttendedController = TextEditingController();
  final _durationController = TextEditingController();
  final _qualificationObtainedController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _upload() {
    if (_durationController.text == null &&
        _qualificationObtainedController.text == null &&
        _schoolAttendedController.text == null &&
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
                  'Save your Educational Backgorund',
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _schoolAttendedController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.school,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'School Attened *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _durationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.timelapse,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Duration of Attendance *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
                child: TextField(
                  controller: _qualificationObtainedController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.school_rounded,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Qualification obtained *',
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
