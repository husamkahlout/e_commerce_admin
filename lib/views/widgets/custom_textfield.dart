import 'package:e_commerce/router/router.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController textFieldController;
  Function textFieldValidator;
  String customHintText;
  TextInputType textInputType;
  Widget prefixIcon;
  bool isSecure;

  CustomTextField({
    required this.customHintText,
    required this.textFieldValidator,
    required this.textFieldController,
    required this.prefixIcon,
    required this.textInputType,
    required this.isSecure,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isSecure,
        controller: textFieldController,
        validator: (value) => textFieldValidator(value),
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            hintText: customHintText,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: prefixIcon,
            )));
  }
}
