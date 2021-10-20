import 'package:flutter/material.dart';
import 'package:nannyacademy/widgets/genericTextFieldSquare.dart';

class ClientPayments extends StatefulWidget {
  @override
  _ClientPaymentsState createState() => _ClientPaymentsState();
}

class _ClientPaymentsState extends State<ClientPayments> {
  List paymentOptions = [
    {
      "paymentMethod": "Remita",
      "accountNumber": "7890080009",
      "userId": "1000"
    },
    {
      "paymentMethod": "PayStack",
      "accountNumber": "123900878",
      "userId": "1000"
    }
  ];

  _deletePaymentOption(var paymentOption) {
    setState(() {
      paymentOptions.remove(paymentOption);
    });
  }

  final _accountNumberController = TextEditingController();
  String dropdownvalue = 'Remita';
  var items = [
    'PayStack',
    'Remita',
    'Cash',
    'CashEnvoy',
    'VoguePay',
    'Flutterwave',
    'Interswitch Webpay'
  ];
  _addPaymentOption(var dropdownvalue) {
    if (_accountNumberController.text.isNotEmpty) {
      var requestBody = {
        "paymentMethod": dropdownvalue,
        "accountNumber": _accountNumberController.text,
        "userId": "1000" //Get from user session
      };

      setState(() {
        paymentOptions.add(requestBody);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Account Statement',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              height: 220,
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
                        value: dropdownvalue,
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
                            dropdownvalue = newValue;
                          });
                        },
                      ),
                    ),
                    GenericTextFieldSquare(
                      Icons.payment,
                      _accountNumberController,
                      'Account Number *',
                      TextInputType.number,
                      Color.fromRGBO(255, 200, 124, 1),
                    ),
                    ActionChip(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      label: Text(
                        'Add Payment Method',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        _addPaymentOption(dropdownvalue);
                      },
                      backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                      elevation: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 230),
              child: Card(
                elevation: 5,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: paymentOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    var serviceRequest = paymentOptions[index];
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListTile(
                        leading: Icon(
                          Icons.payments_rounded,
                          // color: Color,
                        ),
                        title: Text(
                          serviceRequest['paymentMethod'],
                          style:
                              TextStyle(fontSize: 17, fontFamily: 'Quicksand'),
                        ),
                        subtitle: Text(
                          serviceRequest['accountNumber'],
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
