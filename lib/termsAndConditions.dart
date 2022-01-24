import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:nannyacademy/employers/searcResults.dart';

const spinkit = SpinKitThreeBounce(
  color: Colors.orangeAccent,
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
  bool failedToSave = false;

  Widget build(BuildContext context) {
    final String pdfText = """
  
REQUEST NUMBER: ${widget.requestNumber}


PAYMENT

Copy and use the above request number to pay a commitment fee into the nanny account. The request will be deleted after 3 days of inactivity.


Nannies that match your request profile will appear in the REQUESTS RESULTS Menu.
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
                      Text(
                        widget.requestNumber,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      SizedBox(height: 20),
                      spinkit,
                      SizedBox(height: 50),


                      failedToSave ?Text(
                        "Ops, Failed to save your request. Check your internet connection. \n\nIf it persists contact Nanny Academy.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'Quicksand',
                        ),
                      ):
                      Text(
                        "Please wait, we are saving your service preferences. \n\nYour results will appear on the Service Request Menu once the payment is received.",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Quicksand',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        pdfText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.5, fontFamily: 'Quicksand'),
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
                            onPressed: () async {

                              try {
                                setState(
                                      () {
                                    load = true;
                                  },
                                );

                                await FirebaseFirestore.instance
                                    .collection('Service Requests')
                                    .add(widget.requestBody);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.blueGrey,
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                      Text('Request submitted successfully. Pending payment.'),
                                    ),
                                    duration: Duration(seconds: 5),
                                  ),
                                );

                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchResults(requestNumber:widget.requestNumber),
                                      ),
                                    );
                              }on FirebaseException catch (e) {
                                setState(
                                      () {
                                    load = false;
                                    failedToSave = true;
                                  },
                                );
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(' Ops! Failed to submit request. Try again later.'),
                                    content: Text('${e.message}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text('Okay'),
                                      )
                                    ],
                                  ),
                                );
                              }
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
