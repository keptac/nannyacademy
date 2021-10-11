import 'package:flutter/material.dart';

class RequestForService extends StatefulWidget {
  @override
  _RequestForServiceState createState() => _RequestForServiceState();
}

class _RequestForServiceState extends State<RequestForService> {
  List serviceOffers = [];
  final _endSalaryController = TextEditingController();
  final _cityController = TextEditingController();
  final _salaryController = TextEditingController();
  final _endController = TextEditingController();
  String _genderVal = 'Male';
  String _status = '';
  int group = 1;

  Widget _radio() {
    return Padding(
      padding: EdgeInsets.only(left: 40, right: 10, bottom: 15, top: 15),
      child: Row(
        children: <Widget>[
          Text('Gender: * '),
          Radio(
            value: 1,
            groupValue: group,
            onChanged: (T) {
              setState(() {
                group = T;
                _genderVal = 'Male';
              });
            },
          ),
          Text('Male'),
          // SizedBox(width: 15.0),
          Radio(
            groupValue: group,
            value: 2,
            onChanged: (T) {
              setState(() {
                group = T;
                _genderVal = 'Female';
              });
            },
          ),
          Text('Female'),
        ],
      ),
    );
  }

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
          'Request for Service',
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
              // height: 150,
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
                      margin: EdgeInsets.only(left: 37, right: 37, bottom: 20),
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
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 40, right: 40, bottom: 15),
                        child: TextField(
                          controller: _cityController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Color.fromRGBO(233, 166, 184, 1),
                              size: 20,
                            ),
                            labelText: 'City/Location *',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Row(children: [
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 40, right: 40, bottom: 15),
                        child: TextField(
                          controller: _salaryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.monetization_on,
                              color: Color.fromRGBO(233, 166, 184, 1),
                              size: 20,
                            ),
                            labelText: 'Starting Salary Amount *',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 40, right: 40, bottom: 15),
                        child: TextField(
                          controller: _endSalaryController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.monetization_on,
                              color: Color.fromRGBO(233, 166, 184, 1),
                              size: 20,
                            ),
                            labelText: 'Ending Salary amount *',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 40, right: 40, bottom: 15),
                        child: TextField(
                          controller: _endController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_add_alt,
                              color: Color.fromRGBO(233, 166, 184, 1),
                              size: 20,
                            ),
                            labelText: 'Preffered Age *',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                    ),

                    _radio(),
                    // ]),
                    ActionChip(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      label: Text(
                        'Find Employee Service',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        // _addPaymentOption(serviceSelected);
                      },
                      backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                      elevation: 1,
                    ),
                  ],
                ),
              ),
            ),
            //   Padding(
            //     padding: EdgeInsets.only(top: 200),
            //     child: Card(
            //       elevation: 5,
            //       child: ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: serviceOffers.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           var serviceRequest = serviceOffers[index];
            //           return Padding(
            //             padding: EdgeInsets.only(left: 10, right: 10),
            //             child: ListTile(
            //               leading: Icon(
            //                 Icons.payments_rounded,
            //                 color: Color.fromRGBO(255, 200, 124, 1),
            //               ),
            //               title: Text(
            //                 serviceRequest['serviceName'],
            //                 style:
            //                     TextStyle(fontSize: 17, fontFamily: 'Quicksand'),
            //               ),
            //               trailing: IconButton(
            //                 icon: Icon(
            //                   Icons.delete,
            //                   color: Colors.red[900],
            //                 ),
            //                 onPressed: () => _deletePaymentOption(serviceRequest),
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
