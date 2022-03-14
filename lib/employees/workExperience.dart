import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:nannyacademy/employees/dashboard.dart';

import 'package:nannyacademy/services/rest_api.dart';

class WorkExperience extends StatefulWidget {
  @override
  _WorkExperienceState createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  File idFile;
  File pofFile;
  var data;
  String _errorMsg = '';
  final _careName = TextEditingController();
  final _terminationReasonController = TextEditingController();
  final _durationController = TextEditingController();
  final _durationEndController = TextEditingController();
  final _fullAddressController = TextEditingController();
  final _tellNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _upload() {
    if (_durationController.text == null &&
        _fullAddressController.text == null &&
        _careName.text == null &&
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
          'Update',
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
                  'Update your Work Experience',
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
                  controller: _careName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.people,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Name of Family or Day-care *',
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
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Year/ Month started *',
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
                  controller: _durationEndController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.date_range,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Year/ Month ended *',
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
                  controller: _fullAddressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Full Address *',
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
                  controller: _tellNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Telephone Number *',
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
                  controller: _terminationReasonController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.people,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'Why did you stop? *',
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
