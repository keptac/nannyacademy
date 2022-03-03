import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final IconData icon;
  final TextEditingController contolller;
  final String label;
  final TextInputType keyboard;
  final int length;
  final Color color;

  GenericTextField(
    this.icon,
    this.contolller,
    this.label, [
    this.keyboard,
    this.color = const Color.fromRGBO(34, 167, 240, 1),
    this.length,
  ]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
        child: TextField(
          maxLength: length,
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
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
          ),
        ),
      ),
    );
  }
}
