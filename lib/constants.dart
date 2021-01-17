import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF50057);
const kSecondaryColor = Colors.pinkAccent;
const kTernaryColor = Colors.deepPurpleAccent;

const String kWelcomeScreenId = 'welcomeId';
const String kChatScreenId = 'chatScreenId';
const String kLoginScreenId = 'loginId';
const String kRegistrationScreenId = 'registrationScreenId';
const String kRegisterTag = 'registerTag';
const String kLoginTag = 'loginTag';
const String kLogoTag = 'logoTag';
const List<Color> colorsList = [
  Colors.red,
  Colors.deepOrange,
  Colors.green,
  Colors.blue,
  Colors.lightBlue,
  Colors.blueAccent,
  Colors.purpleAccent,
  Colors.indigoAccent,
  Colors.teal,
];

// const kSendButtonTextStyle = TextStyle(
//   color: kSecondaryColor,
//   fontWeight: FontWeight.bold,
//   fontSize: 18.0,
// );

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
