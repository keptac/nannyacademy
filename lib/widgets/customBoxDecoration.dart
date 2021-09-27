import 'package:flutter/material.dart';

class CustomBoxDecoration {
  BoxDecoration value = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.2, 0.7, 1.0],
      colors: [
        Color.fromRGBO(166, 233, 215, 1),
        Color.fromRGBO(255, 200, 124, 1),
        Color.fromRGBO(233, 166, 184, 1)
      ],
    ),
  );

  BoxDecoration box() {
    return value;
  }
}
