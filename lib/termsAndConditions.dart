import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nannyacademy/employers/myRequests.dart';

const spinkit = SpinKitChasingDots(
  color: Colors.black,
  size: 50.0,
);

class CreateAgreement extends StatefulWidget {
  @override
  _CreateAgreementState createState() => _CreateAgreementState();
}

class _CreateAgreementState extends State<CreateAgreement> {
  bool loadPayment = false;

  final String pdfText = """

  REQUEST NUMBER: REQ678899


  PAYMENT
    Use the above request number to make
    payment into the nany account. 
    Once the payment is confirmed you will have
    the ability to book an appointment
    

  MEMBERSHIP RULES
    Lorem Ispum dolor dummy text by Kelvin Chelenje.Represents where text will go. i.e terms for use and code of conduct
  """;

  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: Text(
            'Agreement',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Quicksand',
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(255, 200, 124, 1),
          actions: [
            new TextButton(
              onPressed: () {
                setState(() {
                  loadPayment = true;
                });

                //Submit to Database request with status pending.
                //Pending Verification

                Future.delayed(const Duration(milliseconds: 2000), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyRequests(),
                    ),
                  );
                });
              },
              child: Text(
                'Agree',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: loadPayment
                ? spinkit
                : Text(
                    pdfText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
          ),
        ),
      ),
    );
  }
}
