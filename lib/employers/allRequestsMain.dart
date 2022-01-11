import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/employers/searcResults.dart';

class AllRequestsMain extends StatefulWidget {
  @override
  _AllRequestsMainState createState() => _AllRequestsMainState();
}

class _AllRequestsMainState extends State<AllRequestsMain> {
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
          'My Requests',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body:
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Service Requests')
              .where('userId', isEqualTo:FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((request)
              {
                return  Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    subtitle: Text("Payment Status: "+request['paymentStatus']),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      request['requestNumber'],
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
                    ),
                    onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResults(requestNumber: request['requestNumber']),
                          ),
                        ),
                  ),
                );
              }).toList(),
            );
          }),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Home',
        elevation: 0.8,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
        child: const Icon(Icons.home),
        onPressed: (){
          Navigator.pop(context);
          // Navigator.push(
          //   context, MaterialPageRoute(builder: (context) => EmployerDashboard()));
        }
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
