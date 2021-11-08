import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:nannyacademy/termsAndConditions.dart' as fullDialog;

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final _cityController = TextEditingController();
  final _salaryController = TextEditingController();
  final _startAgeController = TextEditingController();
  final _endAgeController = TextEditingController();
  String _genderVal = 'Male';
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

  String serviceSelected = 'Nanny Services';
  var items = [
    'Nanny Services',
    'Laundry Services',
  ];

  List serviceSearchResults = [
    {
      "firstName": "Kelvin",
      "gender": "MALE",
      "age": "27",
      "services": "Nany, Gardener",
      "location": "Lagos",
      "phoneNumber": "263785302628",
      "photoUrl": "users/pic.png",
      "employeeId": "58-293952-Q-86"
    },
    {
      "firstName": "Charlotte",
      "gender": "FEMALE",
      "age": "23",
      "services": "Nany",
      "location": "Abuja",
      "phoneNumber": "263785302628",
      "photoUrl": "users/pic.png",
      "employeeId": "58-293952-Q-86"
    },
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
          'Search Results',
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
        child: ListView.builder(
          // padding: const EdgeInsets.all(8),
          itemCount: serviceSearchResults.length,
          itemBuilder: (BuildContext context, int index) {
            var serviceRequest = serviceSearchResults[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ExpansionTileCard(
                borderRadius: const BorderRadius.all(Radius.circular(7.0)),
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
                title: Text(serviceRequest['firstName'] == null
                    ? ''
                    : serviceRequest['firstName']),
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
                        serviceDisplay("Services", serviceRequest['services']),
                        serviceDisplay("Gender", serviceRequest['gender']),
                        serviceDisplay("Age", serviceRequest['age']),
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
                          style: TextStyle(color: Colors.white, fontSize: 17),
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
