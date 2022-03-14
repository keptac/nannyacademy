import 'package:flutter/material.dart';
import 'package:nannyacademy/employees/serviceRequests.dart';
import 'package:nannyacademy/employees/settings.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/CustomBoxDecoration.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CustomBoxDecoration customBoxDecoration = CustomBoxDecoration();

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
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
        leading: Icon(Icons.info_outline),
        actions: <Widget>[],
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
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Welcome to Nanny Academy',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 25, right: 15),
            height: MediaQuery.of(context).size.height * 0.715,
            child: Center(
              child: GridView.count(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: [
                  menuCard('Service Requests', ServiceRequests()),
                  menuCard('Account Settings', Settings()),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Log Out',
        elevation: 0.8,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
        child: const Icon(Icons.lock),
        onPressed: () => signOut(),
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
