import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class Requests {
  final employer;
  final endAge;
  final gender;
  final paymentStatus;
  final requestNumber;
  final requestStatus;
  final serviceName;
  final serviceType;
  final startAge;
  final userId;
  final documentId;

  const Requests(this.employer, this.endAge, this.gender, this.paymentStatus, this.requestNumber, this.requestStatus, this.serviceName, this.serviceType, this.startAge, this.userId, this.documentId);
}

class ClientRequests extends StatefulWidget {

  @override
  _ClientRequestsState createState() => _ClientRequestsState();
}

class _ClientRequestsState extends State<ClientRequests> {
  int index = 0;

  Stream<List<Requests>> getData() async* {
    var requestsStream = FirebaseFirestore.instance.collection("Service Requests").where("paymentStatus", isNotEqualTo: 'Approved').snapshots();

    var messages = <Requests>[];

    await for (var requestsSnapshot in requestsStream) {

      for (var requestDoc in requestsSnapshot.docs) {
        var message;
        if (requestDoc["userId"] != null) {
          var userSnapshot = await FirebaseFirestore.instance.collection("Employer Accounts").where('profileid', isEqualTo:requestDoc["userId"]).get();
          message = Requests(
            userSnapshot.docs[0]["firstName"].toString()+' '+userSnapshot.docs[0]["surname"].toString(),
            requestDoc["endAge"],
            requestDoc["gender"],
            requestDoc["paymentStatus"],
            requestDoc["requestNumber"],
            requestDoc["requestStatus"],
            requestDoc["serviceName"],
            requestDoc["serviceType"],
            requestDoc["startAge"],
            requestDoc["userId"],
              requestDoc.id
          );
        }
        else {
          message = Requests(
            "",
            requestDoc["endAge"],
            requestDoc["gender"],
            requestDoc["paymentStatus"],
            requestDoc["requestNumber"],
            requestDoc["requestStatus"],
            requestDoc["serviceName"],
            requestDoc["serviceType"],
            requestDoc["startAge"],
            requestDoc["userId"],
              requestDoc.id
          );
        }
        messages.add(message);
      }
      yield messages;
    }
  }

  void _approval(var id, var decision) async {
    try {

        await FirebaseFirestore.instance
            .collection('Service Requests')
            .doc(id)
            .update({'paymentStatus':decision, 'requestStatus':decision});

      //TODO: send email to all parties

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Success'),
          content: Text('Request has been '+ decision),
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
          'Client Requests',
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(34, 167, 240,1),
      ),
      body:
      StreamBuilder<List<Requests>>(
          stream: getData(),
          builder: (BuildContext context, AsyncSnapshot<List<Requests>> requestsSnapshot) {
            if (!requestsSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (requestsSnapshot.hasError)
              return new Text('Error: ${requestsSnapshot.error}');
            switch (requestsSnapshot.connectionState) {
              case ConnectionState.waiting: return new Text("Loading...");
              default:

                return ListView(
                  children: requestsSnapshot.data.map((Requests serviceRequest) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: ExpansionTileCard(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        initialElevation: 1,
                        baseColor: Colors.white,
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(serviceRequest.employer),
                        subtitle: Text(serviceRequest.requestStatus),
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
                                serviceDisplay(
                                    "Request Number", serviceRequest.requestNumber),

                                serviceDisplay("Services Type", serviceRequest.serviceType),
                                serviceDisplay("Service Name", serviceRequest.serviceName),
                                serviceDisplay("Age Rage", serviceRequest.startAge.toString()
                                    + ' years  - '+serviceRequest.endAge.toString()+' years'),
                                serviceDisplay("Payment Status", serviceRequest.paymentStatus),
                                serviceDisplay("Request Status", serviceRequest.requestStatus),

                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1.0,
                            height: 1.0,
                          ),


                          serviceRequest.paymentStatus=="Pending"?
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
                                      'Decline Application',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    onPressed: () {
                                      _approval(serviceRequest.documentId, "Declined");
                                    },
                                    backgroundColor: Colors.red.shade900,
                                    elevation: 1,
                                  ),
                                  SizedBox(width: 50),
                                  ActionChip(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10, bottom: 10),
                                    label: Text(
                                      'Approve ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                    onPressed: () {
                                      _approval(serviceRequest.documentId, "Approved");
                                    },
                                    backgroundColor: Colors.green,
                                    elevation: 1,
                                  ),
                                ],
                              ),
                            ],
                          )
:
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceAround,
                            buttonHeight: 52.0,
                            buttonMinWidth: 90.0,
                            children: <Widget>[
                              ActionChip(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                label: Text(
                                  'Payment '+ serviceRequest.paymentStatus,
                                  style: TextStyle(color: Colors.white, fontSize: 13),
                                ),
                                onPressed: () {},
                                backgroundColor: serviceRequest.paymentStatus=='Approved'?Colors.green:Colors.red,
                                elevation: 1,
                              )
                            ],
                          )

                          // ButtonBar(
                          //   alignment: MainAxisAlignment.spaceAround,
                          //   buttonHeight: 52.0,
                          //   buttonMinWidth: 90.0,
                          //   children: <Widget>[
                          //     ActionChip(
                          //       padding: EdgeInsets.only(
                          //           left: 10, right: 10, top: 10, bottom: 10),
                          //       label: Text(
                          //         serviceRequest.requestStatus,
                          //         style: TextStyle(color: Colors.white, fontSize: 13),
                          //       ),
                          //       onPressed: () {},
                          //       backgroundColor: Colors.green,
                          //       elevation: 1,
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    );
                  },
                  ).toList(),
                );
            }
          }
      ),
      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
