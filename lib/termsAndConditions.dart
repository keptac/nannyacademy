import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:nannyacademy/employers/searcResults.dart';

const spinkit = SpinKitChasingDots(
  color: Colors.black,
  size: 50.0,
);

class CreateAgreement extends StatefulWidget {
  final requestBody;
  final requestNumber;

  CreateAgreement(
      {Key key, @required this.requestBody, @required this.requestNumber})
      : super(key: key);
  @override
  _CreateAgreementState createState() => _CreateAgreementState();
}

class _CreateAgreementState extends State<CreateAgreement> {
  bool load = false;

  Widget build(BuildContext context) {
    final String pdfText = """
  
REQUEST NUMBER: ${widget.requestNumber}


PAYMENT

Use the above request number to pay a commitment fee into the nanny account. The request will be deleted after 3 days of inactivity.


Nannies that match your request profile will appear in the SERVICE REQUESTS Menu.
""";

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
          actions: [],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: load
                ? Column(
                    children: [
                      SizedBox(height: 20),
                      spinkit,
                      SizedBox(height: 50),
                      Text(
                        "Thank you, we are saving your service preferences. \n\nYour results will appear on the Service Request Menu once the payment is received.",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        pdfText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.5),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Row(
                        children: [
                          ActionChip(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            label: Text(
                              'Cancel request',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            backgroundColor: Colors.red[900],
                            elevation: 1,
                          ),
                          SizedBox(width: 25),
                          ActionChip(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            label: Text(
                              'Proceed to payment',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  load = true;
                                },
                              );

                              Future.delayed(
                                const Duration(milliseconds: 5000),
                                () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchResults(),
                                    ),
                                  );
                                },
                              );
                            },
                            backgroundColor: Colors.green,
                            elevation: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
