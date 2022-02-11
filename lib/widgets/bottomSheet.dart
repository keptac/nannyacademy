import 'package:flutter/material.dart';

class KyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
          stops: [0.1, 0.2, 1.0],
          colors: [
            Color.fromRGBO(34, 167, 240, 0.8),
            Color.fromRGBO(166, 233, 215, 1),
            Color.fromRGBO(255, 200, 124, 1)
          ],
        ),
      ),
      child: Center(
        child: Text(
          'NANY ACADEMY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            letterSpacing: 5,
            fontFamily: 'Quicksand',
          ),
        ),
      ),
    );
  }
}
