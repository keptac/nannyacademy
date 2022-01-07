import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employeerProfile.dart';
import 'package:nannyacademy/employers/myRequests.dart';
import 'package:nannyacademy/employers/requestForService.dart';
import 'package:nannyacademy/employers/searcResults.dart';
import 'package:nannyacademy/login.dart';
import 'package:nannyacademy/widgets/CustomBoxDecoration.dart';

class EmployerDashboard extends StatefulWidget {
  @override
  _EmployerDashboardState createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {
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
  
  menuCard(var item, var requestRoute, var icon) {
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
          child: Padding(padding: EdgeInsets.only(top: 25),
              child:Column(children: [
            Icon(icon, color: Colors.green,size: 30,),
            SizedBox(height: 10,),
            Center(
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
          ],)),

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: Icon(
          
          Icons.menu,
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  signOut();
                },
                child: Icon(
                  Icons.lock,
                  size: 26.0,
                ),
              )),
        ],
        elevation: 0.0,
        title: Text(
          'Nanny Academy',
          style: TextStyle(
              fontSize: 16, fontFamily: 'Quicksand', color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Welcome to Nanny Academy\nClient App',
                textAlign: TextAlign.center,
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
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: [
                  menuCard('Request results', SearchResults(),Icons.find_replace_outlined,),
                  menuCard('Find care givers', RequestForService(),Icons.search,),
                  menuCard('Scheduled Meetings', MyRequests(jobStatus:'Pending'), Icons.calendar_today_outlined,),

                ],
              ),
            ),
          ),


        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Profile Details',
        elevation: 0.8,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
        child: const Icon(Icons.person),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => EmployerSettings())),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Container(
            height: 60,
          ),),
    );
  }
}
