import 'package:denden_mushi/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function function;
  final String hintText;
  final Icon icon;
  final bool isPassword;

  CustomTextField({this.hintText, this.function, this.icon, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword ?? false,
      cursorColor: kPrimaryColor,
      onChanged: function ??
          (value) {
            //Do something with the user input.
          },
      style: TextStyle(color: Color(0xFF001823)),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        icon: icon ??
            Icon(
              Icons.circle,
              color: kPrimaryColor,
            ),
        hintText: hintText ?? '',
        hintStyle: TextStyle(color: kTernaryColor),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kTernaryColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
