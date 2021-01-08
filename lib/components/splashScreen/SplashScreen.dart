import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netly/components/onBoarding/boardingScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

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
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: OnboardingScreen(),
      splash: Image.asset(
        "assets/images/netpayments.png",
        width: 450,
      ),
      duration: 4000,
      backgroundColor: Colors.blue,
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
