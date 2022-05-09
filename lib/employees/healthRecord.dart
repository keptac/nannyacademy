import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// import 'package:image_picker/image_picker.dart';
import 'package:nannyacademy/employees/dashboard.dart';

import 'package:nannyacademy/services/rest_api.dart';

class HealthRecord extends StatefulWidget {
  @override
  _HealthRecordState createState() => _HealthRecordState();
}

class _HealthRecordState extends State<HealthRecord> {
  File idFile;
  File pofFile;
  var data;
  String _errorMsg = '';
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _choose(fileDes) async {
    // pofFile = (await ImagePicker.platform.pickImage(source: ImageSource.camera)) as File;
  }

  void _upload() {
    if (_addressController.text == '' &&
        _addressController.text == null &&
        pofFile == null) {
      setState(() {
        _errorMsg = 'Please provide all required fields';
      });
      return;
    } else {
      String pofBase64Image = base64Encode(pofFile.readAsBytesSync());
      String pofFileName = pofFile.path.split("/").last;

      Map data = {
        "address": _addressController.text,
        "pof": {
          "image": pofBase64Image,
          "name": pofFileName,
          "description": "Proof of Residence File update"
        }
      };

      var body = json.encode(data);
      ApiService.registerUser(body).then((res) {
        print(res);
        if (res['message'] == 'success') {
        } else if (res['message'] == 'failse') {
          setState(() {
            _errorMsg = res['message']['reason'];
          });
        } else {
          _errorMsg =
              'Failed to update nannyacademy please contact nannyacademyHAIN';
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  Widget _uploadButton(String label, String fileType) {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
      child: InkWell(
        child: Card(
          color: Colors.grey[200],
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(34, 167, 240, 1)),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          elevation: 0,
          child: SizedBox(
            height: 60,
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        label,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 260),
                      child: Icon(
                        Icons.image,
                        color: Colors.lightGreen[300],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () => _choose(fileType),
      ),
    );
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
            Center(
              child: Image.asset(
                'assets/images/upload.png',
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
                child: Text(
                  'Recently changed your address?\nUpdate record',
                  style: TextStyle(fontSize: 20, fontFamily: 'Quicksand'),
                  textAlign: TextAlign.center,
                ),
                height: 60),
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
                  controller: _addressController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(34, 167, 240, 1),
                      size: 20,
                    ),
                    labelText: 'New Address *',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  ),
                ),
              ),
            ),
            _uploadButton('Capture proof of residence *', 'pof'),
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
