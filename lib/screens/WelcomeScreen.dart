import 'package:denden_mushi/components/CustomButton.dart';
import 'package:denden_mushi/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    );

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: kLogoTag,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60 * animation.value + 3,
                  ),
                ),
                Text(
                  'Den Den Mushi',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Hero(
              tag: kLoginTag,
              child: CustomButton(
                color: kPrimaryColor,
                function: () {
                  Navigator.pushNamed(context, kLoginScreenId);
                },
                text: 'Log In',
              ),
            ),
            Hero(
              tag: kRegisterTag,
              child: CustomButton(
                color: kSecondaryColor,
                function: () {
                  Navigator.pushNamed(context, kRegistrationScreenId);
                },
                text: 'Register',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
