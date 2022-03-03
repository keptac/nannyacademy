import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controlller;

  PhoneNumberField(
    this.controlller,
);

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(left:40, right: 40, top:5, bottom:20),
      padding: EdgeInsets.only(left:20),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),),

        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Colors.black),
          initialValue: number,
          textFieldController: controlller,
          formatInput: true,
          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder:  InputBorder.none,
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
    );
  }
}
