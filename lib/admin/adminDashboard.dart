import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/employeerProfile.dart';
import 'package:nannyacademy/employers/requestForService.dart';
import 'package:nannyacademy/employers/searcResults.dart';
import 'package:nannyacademy/widgets/CustomBoxDecoration.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  CustomBoxDecoration customBoxDecoration = CustomBoxDecoration();

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
        actions: <Widget>[],
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
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: [
                  menuCard('Manage Nannies', RequestForService()),
                  menuCard('Manage Employers', RequestForService()),
                  menuCard('Payments', RequestForService()),
                  menuCard('View Requests', SearchResults()),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: AssetImage('assets/images/back.jpeg'),
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.2, 0.7, 1.0],
            colors: [
              Color.fromRGBO(166, 233, 215, 1),
              Color.fromRGBO(255, 200, 124, 1),
              Color.fromRGBO(233, 166, 184, 1)
            ],
          ),
        ),
        child: Center(
          child: Text(
            'NANNY ADMIN',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              letterSpacing: 5,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.white,
      //     shape: CircularNotchedRectangle(),
      //     notchMargin: 8.0,
      //     child: Container(
      //       height: 60,
      //       decoration: customBoxDecoration.box(),
      //     )),
    );
  }
}
