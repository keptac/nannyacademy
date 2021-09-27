import 'package:flutter/material.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  List serviceOffers = [
    {"serviceName": "Nanny Services", "userId": "1000"}
  ];

  _deletePaymentOption(var paymentOption) {
    print(paymentOption['userId']);
    setState(() {
      serviceOffers.remove(paymentOption);
    });
  }

  String serviceSelected = 'Nanny Services';
  var items = [
    'Nanny Services',
    'Laundry Services',
  ];
  _addPaymentOption(var serviceSelected) {
    var requestBody = {
      "serviceName": serviceSelected,
      "userId": "1000" //Get from user session
    };

    setState(() {
      serviceOffers.add(requestBody);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'My Services',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(233, 166, 184, 1),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              height: 150,
              child: Card(
                child: ListView(
                  padding: EdgeInsets.only(top: 10),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.0) //
                            ),
                        border: Border.all(color: Colors.grey),
                      ),
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: DropdownButton(
                        underline: Text(""),
                        value: serviceSelected,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(items),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            serviceSelected = newValue;
                          });
                        },
                      ),
                    ),
                    ActionChip(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      label: Text(
                        'Add Service',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        _addPaymentOption(serviceSelected);
                      },
                      backgroundColor: Color.fromRGBO(233, 166, 184, 1),
                      elevation: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Card(
                elevation: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: serviceOffers.length,
                  itemBuilder: (BuildContext context, int index) {
                    var serviceRequest = serviceOffers[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListTile(
                        leading: Icon(
                          Icons.payments_rounded,
                          color: Color.fromRGBO(233, 166, 184, 1),
                        ),
                        title: Text(
                          serviceRequest['serviceName'],
                          style:
                              TextStyle(fontSize: 17, fontFamily: 'Quicksand'),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[900],
                          ),
                          onPressed: () => _deletePaymentOption(serviceRequest),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
