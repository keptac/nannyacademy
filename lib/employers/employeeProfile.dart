import 'package:flutter/material.dart';
import 'package:nannyacademy/employees/dashboard.dart';
import 'package:nannyacademy/employees/updateDetails.dart';

class EmployerSettings extends StatefulWidget {
  @override
  _EmployerSettingsState createState() => _EmployerSettingsState();
}

class _EmployerSettingsState extends State<EmployerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
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
          'Employer Profile',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.white,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              leading: CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Personal Details',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Updatenannyacademy(),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Home',
        elevation: 0.8,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
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
