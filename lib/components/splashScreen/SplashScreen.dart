import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:netly/Components/Auth/login.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/onBoarding/boardingScreen.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/SetPassword/change_password.dart';
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

  var passcode;
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

  Future screenlock(context) async {
    await screenLock(
        context: context,
        title: Text('Enter the password to Go in'),
        confirmTitle: Text('Confirm'),
        correctString: passcode,
        confirmation: false,
        didMaxRetries: (retries) {},
        canCancel: false,
        screenLockConfig: ScreenLockConfig(
          backgroundColor: Colors.black.withOpacity(0.1),
        ),
        secretsConfig: SecretsConfig(
          spacing: 15, // or spacingRatio
          padding: const EdgeInsets.all(40),
          secretConfig: SecretConfig(
            borderColor: Colors.white,
            borderSize: 2.0,
            disabledColor: Colors.black,
            enabledColor: Colors.white,
            height: 20,
            width: 20,
            build: (context, {config, enabled}) {
              return WillPopScope(
                onWillPop: _onbackPressed,
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey,
                            spreadRadius: 2,
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color:
                          enabled ? config.enabledColor : config.disabledColor,
                      border: Border.all(
                        width: config.borderSize,
                        color: config.borderColor,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    width: config.width,
                    height: config.height,
                  ),
                  width: config.width,
                  height: config.height,
                ),
              );
            },
          ),
        ),
        inputButtonConfig: InputButtonConfig(
          textStyle: InputButtonConfig.getDefaultTextStyle(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          buttonStyle: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: Colors.blue.withOpacity(0.9),
          ),
        ),
        cancelButton: const Icon(Icons.close),
        deleteButton: const Icon(Icons.close),
        footer: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasscode(),
                    ));
              },
              child: Text("Reset Passcode")),
        ));
  }

  Future<bool> _onbackPressed() async {
    return showDialog(
        context: context,
        builder: (contex) => AlertDialog(
              title: Text("Do you Really want to exit"),
              actions: [
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }

  getSession() async {
    final prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt('initScreen');
    passcode = prefs.getString('passcode');

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
        Future.delayed(Duration.zero, () {
          this.screenlock(context);
        });
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
    } 
    else if(otpValidate ==null &&  passcode == null)
    {
       Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
    else if (otpValidate == 1 || passcode == null) {
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
          height: 25 * SizeConfig.heightMultiplier,
        ),
        Column(
          children: [
            Center(
              child: Image.asset("assets/images/splashpageimage.png",
                  height: 25 * SizeConfig.imageSizeMultiplier),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Text(
              "InstantPayment",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 5 * SizeConfig.textMultiplier),
            ),
            SizedBox(height: 40 * SizeConfig.heightMultiplier),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Developed by ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " WebPhisher",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}
