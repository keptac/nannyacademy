import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:nannyacademy/passwordCreation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nannyacademy/services/rest_api.dart';

class UploadKyc extends StatefulWidget {
  @override
  _UploadKycState createState() => _UploadKycState();
}

class _UploadKycState extends State<UploadKyc> {
  File idFile;
  File pofFile;
  var data;
  String _errorMsg = '';
  String idText = 'Click to upload picture of ID *';
  String pofText = 'Click to capture proof of residence *';
  String userTypeValue;
  String idNumber;

  @override
  void initState(){

    super.initState();
    setPrefs();
  }

  void setPrefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      idNumber = prefs.getString('idNumber');
      userTypeValue = prefs.getString('userType');
    });
  }

  void _choose(fileDes) async {
    if(fileDes == 'pof'){
      pofFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        pofText = pofFile.path.split("/").last;
      });
    }else{
      idFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        idText = idFile.path.split("/").last;
      });
    }
  }

  //TODO: Upload the documents to a server
  void _upload() async{
    if ((idNumber == '' &&
        idNumber == null) ||
        pofFile == null ||
        idFile == null) {
      setState(() {
        _errorMsg = 'Please provide all required fields';
      });
    } else {
      String pofBase64Image = base64Encode(pofFile.readAsBytesSync());
      String pofFileName = pofFile.path.split("/").last;

      String idBase64Image = base64Encode(idFile.readAsBytesSync());
      String idFileName = idFile.path.split("/").last;

      Map data = {
        "idNumber": idNumber,
        "pof": {
          "image": pofBase64Image,
          "name": pofFileName,
          "description": "Proof of Residence File upload"
        },
        "id": {
          "image": idBase64Image,
          "name": idFileName,
          "description": "ID File upload"
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
          setState(() {
            _errorMsg ='Failed to upload KYC data please contact Nanny Academy';
          });

        }
      }).catchError((err) {
        setState(() {
          _errorMsg ='Failed to update Nanny Academy please contact Nanny Academy';
        });
        print(err);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordCreation(userTypeValue: userTypeValue),
        ),
      );
    }
  }

  Widget _uploadButton(String label, String fileType) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
      child: InkWell(
        child: Card(
          color: Colors.grey[200],
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: userTypeValue=='employee'?Color.fromRGBO(233, 166, 184, 1):Color.fromRGBO(255, 200, 124, 1)),
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
                      padding: EdgeInsets.only(left: 280),
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
        backgroundColor: userTypeValue=='employee'?Color.fromRGBO(233, 166, 184, 1):Color.fromRGBO(255, 200, 124, 1),
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
        backgroundColor: userTypeValue=='employee'?Color.fromRGBO(233, 166, 184, 1):Color.fromRGBO(255, 200, 124, 1),
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
                  'Upload KYC Documents',
                  style: TextStyle(fontSize: 17, fontFamily: 'Quicksand'),
                  textAlign: TextAlign.center,
                ),
                height: 60),
            Center(
              child: Text(
                _errorMsg,
                style: TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _uploadButton(idText, 'id'),
            _uploadButton(pofText, 'pof'),
            SizedBox(
              height: 20,
            ),
            _proceedButton(),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
