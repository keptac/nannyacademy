import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/admin/allPayments.dart';
import 'package:nannyacademy/admin/clientRequests.dart';
import 'package:nannyacademy/admin/employee_management/manageEmployees.dart';
import 'package:nannyacademy/admin/employer_management/manageEmployers.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/CustomBoxDecoration.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  CustomBoxDecoration customBoxDecoration = CustomBoxDecoration();
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
  }

  menuCard(var item, var requestRoute) {
    return Container(
      decoration: customBoxDecoration.box(),
      height: 20,
      margin: EdgeInsets.only(right: 5, top: 5),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // color: Colors.teal[200],
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                item,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: 'Quicksand'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => requestRoute,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          actions: <Widget>[
          ],
          elevation: 0.0,
          title: Text(
            'Nanny Academy',
            style: TextStyle(
                fontSize: 20, fontFamily: 'Quicksand', color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 200, 124, 1),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 15),
              height: MediaQuery.of(context).size.height * 0.715,
              child: Center(
                child: GridView.count(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10),
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children: [
                    menuCard('Manage Care givers', ManageEmployees()),
                    menuCard('Manage Clients', ManagerEmployers()),
                    menuCard('View Payments', AllPayments()),
                    menuCard('View Client Requests', ClientRequests()),
                  ],
                ),
              ),
            ),
          ],
        ),

    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      tooltip: 'Log Out',
      elevation: 0.1,
      backgroundColor: Colors.black, //Color.fromRGBO(255, 200, 124, 1),
      child: const Icon(Icons.lock),
      onPressed: () =>  signOut(),
    ),
        bottomNavigationBar: BottomSheetAdmin());
  }
}
