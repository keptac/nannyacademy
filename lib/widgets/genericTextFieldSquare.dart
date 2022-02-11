import 'package:flutter/material.dart';

class GenericTextFieldSquare extends StatelessWidget {
  final IconData icon;
  final TextEditingController contolller;
  final String label;
  final TextInputType keyboard;
  final Color color;

  GenericTextFieldSquare(this.icon, this.contolller, this.label,
      [this.keyboard, this.color = const Color.fromRGBO(34, 167, 240, 1)]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
        child: TextField(
          controller: contolller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: color,
              size: 20,
            ),
            labelText: label,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
          ),
        ),
      ),
    );
  }
}
