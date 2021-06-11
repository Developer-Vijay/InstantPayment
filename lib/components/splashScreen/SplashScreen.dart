import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netly/Components/Auth/login.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/onBoarding/boardingScreen.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/SetPassword/set_passsword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

int initScreen;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

  var retrieveLogin;
  var sessionToken;
  var refreshToken;
  var loginId;
  var logindata;
  var responseData;
  var walletAmount;
  var logindate;
  var otpValidate;
  var getDate = DateTime.now();
  var currentDate;
  getSession() async {
    final prefs = await SharedPreferences.getInstance();
    var passcode = prefs.getString('passcode');
    initScreen = prefs.getInt('initScreen');

    setState(() {
      currentDate = DateFormat("dd/MM/yyyy").format(getDate);
      logindate = prefs.getString('LoginDate');
      otpValidate = prefs.getInt('otp');
    });
    var auth = prefs.getBool('isAuthenticated');
    logindate = prefs.getString('LoginDate');
    if (initScreen == null) {
      prefs.setInt('initScreen', 1);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      });
    } else if (auth == true && passcode != null) {
      Future.delayed(Duration(seconds: 2), () {
        prefs.setBool("walletStatus", true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      walletAmount: walletAmount,
                    )));
      });
    } else if (otpValidate != 1 && passcode == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else if (otpValidate == 1 || passcode == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SetPasscode()));
      });
    } else if (auth == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
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
