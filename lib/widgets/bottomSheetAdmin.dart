import 'package:flutter/material.dart';

class BottomSheetAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 65,
      decoration: BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          image: AssetImage('assets/images/back.jpeg'),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.2, 0.7, 1.0],
          colors: [
            Color.fromRGBO(166, 233, 215, 1),
            Color.fromRGBO(255, 200, 124, 1),
            Color.fromRGBO(34, 167, 240, 1)
          ],
        ),
      ),
      child: Center(
        child: Text(
          'NANNY ADMIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 5,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
    );
  }
}
