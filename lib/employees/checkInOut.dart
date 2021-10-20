import 'package:flutter/material.dart';
import 'package:nannyacademy/employees/settings.dart';
import 'package:nannyacademy/widgets/CustomBoxDecoration.dart';

class CheckInOut extends StatefulWidget {
  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  CustomBoxDecoration customBoxDecoration = CustomBoxDecoration();
  List<String> menuItems = [
    'Service Requests',
    'Checkin/Checkout',
    'My Payments',
    'Certificates'
  ];

  _checkout(var status) {
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Nanny Academy',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Last Checking was on \nMon, 27 Septemner 2021 14:09',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Quicksand',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 60,
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
                  InkWell(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      color: Color.fromRGBO(255, 200, 124, 1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Check In',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _checkout('checkin');
                    },
                  ),
                  InkWell(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      color: Color.fromRGBO(233, 166, 184, 1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Check Out',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      //Call Checkout Function
                      _checkout('checkout');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
