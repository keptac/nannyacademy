import 'package:flutter/material.dart';
import 'package:nannyacademy/widgets/bottomSheetAdmin.dart';

class AllPayments extends StatefulWidget {
  @override
  _AllPaymentsState createState() => _AllPaymentsState();
}

class _AllPaymentsState extends State<AllPayments> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Nanny Academy Payments',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 200, 124, 1),
      ),
      body: Table(
          defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 2),

          children: [
            TableRow(
                children: [

                  Column(
                      children:[
                        Padding(
                        padding: EdgeInsets.all(5 ),
                          child:Text('Request No', style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ]
                  ),
                  Column(
                      children:[
                        Padding(
                          padding: EdgeInsets.all(5 ),
                          child:Text('Amount', style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ]
                  ),
                  Column(
                      children:[
                        Padding(
                          padding: EdgeInsets.all(5 ),
                          child:Text('Reference', style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ]
                  ),
                  Column(
                      children:[
                        Padding(
                          padding: EdgeInsets.all(5 ),
                          child:Text('Action', style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ]
                  ),


                ]
            ),
          ]
    ),

      bottomNavigationBar: BottomSheetAdmin(),
    );
  }
}
