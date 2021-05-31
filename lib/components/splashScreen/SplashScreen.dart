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

  DateTime _currentDate;
  String getdate;
  var current;
  checkDate() async {
    SharedPreferences date = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentDate = DateTime.now();
    getdate = DateFormat("dd-MM-yyyy").format(_currentDate);
    current = date.getString('date');
    print(getdate);
    print("////");
    print(current);
    print("/////");
    if (current == getdate) {
      current = date.setString('date', getdate);
    } else {
      current = date.setString('date', getdate);
      prefs.setInt('counter', 1);

      setState(() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ));
        prefs.setBool('isAuthenticated', false);
      });
    }
  }

  var retrieveLogin;
  var sessionToken;
  var refreshToken;
  var loginId;
  var logindata;
  var responseData;
  var walletAmount;

  getSession() async {
    //Local Session
    final prefs = await SharedPreferences.getInstance();
    var passcode = prefs.getString('passcode');
    initScreen = prefs.getInt('initScreen');
    var auth = prefs.getBool('isAuthenticated');
    print(initScreen);
    if (initScreen == null) {
      prefs.setInt('initScreen', 1);
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
      });
    } else if (auth == true && passcode != null) {
      Future.delayed(Duration(seconds: 2), () {
        prefs.setBool("walletStatus",true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      walletAmount: walletAmount,
                    )));
      });
    } else if (passcode == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SetPasscode()));
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
