import 'package:flutter/material.dart';
import 'package:nannyacademy/admin/employer_management/activeEmployers.dart';
import 'package:nannyacademy/admin/employer_management/employerRegistrations.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class ManagerEmployers extends StatefulWidget {
  @override
  _ManagerEmployersState createState() => _ManagerEmployersState();
}

class _ManagerEmployersState extends State<ManagerEmployers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: <Widget>[],
          elevation: 0.0,
          title: Text(
            'Manage Clients',
            style: TextStyle(
              // fontSize: 20,
              fontFamily: 'Quicksand',
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(34, 167, 240,1),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              elevation: 1,
              margin: EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Registrations',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text("Pending KYC verification"),
                onTap: () => Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => EmployerRegistrations(),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Active Clients',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text("Has active employments"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivatedEmployers(activeEmployment:true),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              color: Colors.white,
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Inactive Clients',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text("No active employments"),
                onTap: () => Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (context) => ActivatedEmployers(activeEmployment:false),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomSheetAdmin());
  }
}
