import 'package:denden_mushi/components/CustomButton.dart';
import 'package:denden_mushi/components/customTextField.dart';
import 'package:denden_mushi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  User firebaseUser;

  String email;
  String password;
  bool _spinner = false;

  void loginUser() async {
    setState(() {
      _spinner = true;
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential != null) {
        Navigator.pushNamed(context, kChatScreenId);
      }
      print(userCredential);
    } on Exception catch (e) {
      print(e);
    } finally {
      setState(() {
        _spinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _spinner,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: kTernaryColor,
          strokeWidth: 2,
        ),
        color: kTernaryColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: kLogoTag,
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              CustomTextField(
                hintText: 'Enter your email',
                icon: Icon(
                  Icons.email,
                  color: kTernaryColor,
                ),
                function: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                hintText: 'Enter your password.',
                icon: Icon(
                  Icons.lock,
                  color: kTernaryColor,
                ),
                function: (value) {
                  password = value;
                },
                isPassword: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              Hero(
                tag: kLoginTag,
                child: CustomButton(
                  text: 'Log in',
                  function: () => loginUser(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
