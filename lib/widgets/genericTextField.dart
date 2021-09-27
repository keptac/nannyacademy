import 'package:flutter/material.dart';

class GenericTextField extends StatelessWidget {
  final IconData icon;
  final TextEditingController contolller;
  final String label;
  final TextInputType keyboard;
  final Color color;

  GenericTextField(this.icon, this.contolller, this.label,
      [this.keyboard, this.color = const Color.fromRGBO(233, 166, 184, 1)]);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
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
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
          ),
        ),
      ),
    );
  }
}
