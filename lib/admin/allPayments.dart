import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllPayments extends StatefulWidget {
  @override
  _AllPaymentsState createState() => _AllPaymentsState();
}

class _AllPaymentsState extends State<AllPayments> {
  void _approval(var id, var decision, var requestNumber) async {
    try {
      var results = await FirebaseFirestore.instance
          .collection('Service Requests')
          .where('requestNumber', isEqualTo: requestNumber)
          .get();

      if (decision == 'Approved') {
        await FirebaseFirestore.instance
            .collection('Service Requests')
            .doc(results.docs[0].id)
            .update({'paymentStatus': decision, "requestStatus": decision});
      }

      await FirebaseFirestore.instance
          .collection('Payments')
          .doc(id)
          .update({'confirmationStatus': decision});

      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Application Response submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Ok'),
            )
          ],
        ),
      );
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(' Ops! Failed to submit response. Try again later.'),
          content: Text('${e.message}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Dismiss'),
            )
          ],
        ),
      );
    }
  }

  Widget serviceDisplay(var title, var value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Nanny Payments',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(34, 167, 240, 1),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Payments')
              .where('confirmationStatus', isEqualTo: 'Pending')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((document) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: ExpansionTileCard(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    initialElevation: 1,
                    baseColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        (1).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text("Request Number"),
                    subtitle: Text(document['requestNumber']),
                    children: <Widget>[
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            serviceDisplay(
                                "Request Number", document['requestNumber']),
                            // serviceDisplay("Services", document['services']),
                            serviceDisplay("Amount", document['amount']),
                            serviceDisplay(
                                "Receipt Number", document['receiptNumber']),
                            serviceDisplay("Payment Confirmation",
                                document['confirmationStatus']),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          Row(
                            children: [
                              ActionChip(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                label: Text(
                                  'Approve ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                onPressed: () {
                                  _approval(document.id, "Approved",
                                      document['requestNumber']);
                                },
                                backgroundColor: Colors.green,
                                elevation: 1,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
