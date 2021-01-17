import 'package:denden_mushi/constants.dart';
import 'package:denden_mushi/screens/ChatScreen.dart';
import 'package:denden_mushi/screens/LoginScreen.dart';
import 'package:denden_mushi/screens/RegistrationScreen.dart';
import 'package:denden_mushi/screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('completed'));
  runApp(DendenMushi());
}

class DendenMushi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: kWelcomeScreenId,
      routes: {
        kWelcomeScreenId: (context) => WelcomeScreen(),
        kLoginScreenId: (context) => LoginScreen(),
        kChatScreenId: (context) => ChatScreen(),
        kRegistrationScreenId: (context) => RegistrationScreen(),
      },
    );
  }
}
