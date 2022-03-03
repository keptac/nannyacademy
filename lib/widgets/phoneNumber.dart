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
    return SizedBox(
      height: 70,
      child: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, bottom: 15),
        child:
        InternationalPhoneNumberInput(
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
          inputBorder: OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ),
    );
  }
}
