import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/termsAndConditions.dart' as fullDialog;

class RequestForService extends StatefulWidget {
  @override
  _RequestForServiceState createState() => _RequestForServiceState();
}

class _RequestForServiceState extends State<RequestForService> {
  final _cityController = TextEditingController();
  final _salaryController = TextEditingController();
  final _startAgeController = TextEditingController();
  final _endAgeController = TextEditingController();
  String _genderVal = 'Male';
  int group = 1;
  bool searchResults = false;

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

  String serviceSelected = 'Nanny Services';
  var items = [
    'Nanny Services',
    'Laundry Services',
  ];

  List serviceSearchResults = [
    {
      "requestType": "Kelvin",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested": "watering the garden ",
      "requestStatus": "apprved",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000"
    },
    {
      "requestType": "Tadiwanashe",
      "requestNum": "REQ67889997",
      "nanyId": "58-293952-Q-86",
      "requestorId": "789008H78",
      "periodOfRequest": '6',
      "requestDate": "2021-09-27T22:00:00.000Z",
      "serviceRequested": "watering the garden ",
      "requestStatus": "approved",
      "serviceRating": "",
      "comments": "",
      "location": "123 Main way",
      "active": "1",
      "salary": "1000"
    }
  ];

  _searchService(var serviceChoice) {
    var requestBody = {
      "serviceName": serviceChoice,
      "startSalary": _salaryController.text,
      "startAge": _startAgeController.text,
      "endAge": _endAgeController.text,
      "gender": _genderVal,
      "userId": "1000" //Get from user session
    };

    //Save Preferences

    setState(() {
      searchResults = true;

      //search for results that match profile
      serviceSearchResults.add(requestBody);
    });
  }

  Future _openAgreeDialog(context) async {
    String result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return fullDialog.CreateAgreement();
        },
        //true to display with a dismiss button rather than a return navigation arrow
        fullscreenDialog: true));
    if (result != null) {
      letsDoSomething(result, context);
    } else {
      print('you could do another action here if they cancel');
    }
  }

  letsDoSomething(String result, context) {
    print(result);
  }

  Widget serviceDisplay(var title, var value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          textAlign: TextAlign.center,
        ),
        Text(
          value == null ? '' : value,
          style: TextStyle(fontSize: 16),
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
          !searchResults ? 'Request for Service' : 'Search Results',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        height: MediaQuery.of(context).size.height * 0.8,
        child: !searchResults
            ? Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Card(
                      child: ListView(
                        padding: EdgeInsets.only(top: 30),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0) //
                                      ),
                              border: Border.all(color: Colors.grey),
                            ),
                            margin: EdgeInsets.only(
                                left: 37, right: 37, bottom: 20),
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
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 15),
                              child: TextField(
                                controller: _cityController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: Color.fromRGBO(255, 200, 124, 1),
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
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 15),
                              child: TextField(
                                controller: _salaryController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.monetization_on,
                                    color: Color.fromRGBO(255, 200, 124, 1),
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
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 15),
                              child: TextField(
                                controller: _startAgeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_add_alt,
                                    color: Color.fromRGBO(255, 200, 124, 1),
                                    size: 20,
                                  ),
                                  labelText: 'Start Age *',
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
                              padding: EdgeInsets.only(
                                  left: 40, right: 40, bottom: 15),
                              child: TextField(
                                controller: _endAgeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_add_alt,
                                    color: Color.fromRGBO(255, 200, 124, 1),
                                    size: 20,
                                  ),
                                  labelText: 'Ending Age *',
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
                              'Search Service',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              _searchService(serviceSelected);
                            },
                            backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                            elevation: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                // padding: const EdgeInsets.all(8),

                itemCount: serviceSearchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  var serviceRequest = serviceSearchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: ExpansionTileCard(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
                      initialElevation: 3,
                      baseColor: Colors.white,
                      expandedColor: Colors.orange[50],
                      leading: CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(serviceRequest['requestType'] == null
                          ? ''
                          : serviceRequest['requestType']),
                      subtitle: Text(serviceRequest['location'] == null
                          ? ''
                          : serviceRequest['location']),
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
                              serviceDisplay("Description",
                                  serviceRequest['serviceRequested']),
                              serviceDisplay("Work Duration",
                                  serviceRequest['periodOfRequest']),
                              serviceDisplay("Service Requested By",
                                  serviceRequest['requestorId']),
                              serviceDisplay(
                                  "Phone Number", serviceRequest['salary']),
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
                            ActionChip(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              label: Text(
                                'Proceed with request',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              onPressed: () {
                                _openAgreeDialog(context);
                              },
                              backgroundColor: Color.fromRGBO(255, 200, 124, 1),
                              elevation: 1,
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
