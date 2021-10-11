import 'package:flutter/material.dart';
import 'package:nannyacademy/nanies/dashboard.dart';
import 'package:nannyacademy/nanies/updateDetails.dart';
import 'package:nannyacademy/parents/clientPayments.dart';

class ClientSettings extends StatefulWidget {
  @override
  _ClientSettingsState createState() => _ClientSettingsState();
}

class _ClientSettingsState extends State<ClientSettings> {
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
          'Client Settings',
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
                  Icons.local_laundry_service_sharp,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Payment Methods',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientPayments(),
                ),
              ),
            ),
          ),
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
