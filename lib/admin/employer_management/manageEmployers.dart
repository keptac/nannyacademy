import 'package:flutter/material.dart';
import 'package:nannyacademy/admin/ADMINDASHBOARD.dart';
import 'package:nannyacademy/admin/employee_management/employeeApplications.dart';
import 'package:nannyacademy/admin/employee_management/trainedEmployees.dart';
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
            'Manage Nannies',
            style: TextStyle(
              // fontSize: 20,
              fontFamily: 'Quicksand',
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 200, 124, 1),
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
                  'Nanny Applications',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeApplications(),
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
                  'Trained Nannies',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainedEmployees(),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Home',
          elevation: 0.5,
          backgroundColor: Color.fromRGBO(255, 200, 124, 1),
          child: const Icon(Icons.home),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminDashboard())),
        ),
        bottomNavigationBar: BottomSheetAdmin());
  }
}
