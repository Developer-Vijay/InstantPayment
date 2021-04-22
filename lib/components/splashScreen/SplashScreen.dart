import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netly/Components/Auth/login.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/onBoarding/boardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Animation(),
    );
  }
}

class Animation extends StatefulWidget {
  @override
  _AnimationState createState() => _AnimationState();
}

class _AnimationState extends State<Animation> {
  @override
  void initState() {
    super.initState();
    getSession();
  }

  getSession() async {
    //Local Session
    final prefs = await SharedPreferences.getInstance();

    initScreen = prefs.getInt('initScreen');
    print(initScreen);
    if (initScreen == null) {
      prefs.setInt('initScreen', 1);
      Future.delayed(Duration(seconds: 5), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 50 * SizeConfig.heightMultiplier,
        ),
        Center(
          child: Image.asset("assets/images/instantpay.png"),
        )
      ],
    ));
  }
}
