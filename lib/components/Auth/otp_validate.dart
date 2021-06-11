import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/SetPassword/set_passsword.dart';
import 'package:netly/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class OtpValidate extends StatefulWidget {
  @override
  _OtpValidateState createState() => _OtpValidateState();
}

class _OtpValidateState extends State<OtpValidate> {
  TextEditingController otpController = TextEditingController();
  var otpValidate;
  var valued;
  bool _isValidate = false;
  //   int time = 59;
  // Timer placeTimer;
  //  int _counter = 0;
  // void startTimer() {
  //   time = 59;
  //   placeTimer = Timer.periodic(Duration(seconds: 1), (_) {
  //     if (time == 0) {
  //       setState(() {
  //         placeTimer.cancel();
  //         print("timer close");

  //         _counter = 1;
  //       });
  //     } else {
  //       setState(() {
  //         time--;
  //         print(time);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(shrinkWrap: true, children: [
        SizedBox(
          height: 12 * SizeConfig.heightMultiplier,
        ),
        Center(
          child: Image.asset(
            Images.loginImage,
            height: 40 * SizeConfig.imageSizeMultiplier,
          ),
        ),
        SizedBox(height: 4 * SizeConfig.heightMultiplier),
        Center(
          child: Text(
            "OTP Verification",
            style: TextStyle(
                decorationStyle: TextDecorationStyle.wavy,
                fontWeight: FontWeight.w600,
                fontSize: 3 * SizeConfig.textMultiplier),
          ),
        ),
        SizedBox(height: 2 * SizeConfig.heightMultiplier),
        Center(
          child: Text(
            "Enter the otp recieved in your  mobile number",
            style: TextStyle(
                decorationStyle: TextDecorationStyle.wavy,
                fontWeight: FontWeight.w500,
                fontSize: 2 * SizeConfig.textMultiplier),
          ),
        ),
        SizedBox(height: 5 * SizeConfig.heightMultiplier),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: PinCodeTextField(
            appContext: context,
            controller: otpController,
            length: 6,
            onChanged: (String value) {
              print(value);
            },
            animationType: AnimationType.fade,
            enablePinAutofill: true,
            autoDismissKeyboard: true,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline, inactiveColor: Colors.grey),
          ),
        ),
        SizedBox(
          height: 5 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            height: 6 * SizeConfig.heightMultiplier,
            textColor: Colors.white,
            color: Apptheme.PrimaryColor,
            onPressed: () {
              otpconfirm();
            },
            child: Text("Verify and Proceed"),
          ),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't recieve the Otp ?"),
            SizedBox(
              width: 1.2 * SizeConfig.heightMultiplier,
            ),
            InkWell(
                onTap: () {
                  resendotp();
                },
                child: Text(
                  "Resend the Otp",
                  style: TextStyle(
                      color: Apptheme.textColo1r, fontWeight: FontWeight.w600),
                ))
          ],
        )
      ])),
    );
  }

  Future resendotp() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
                content: Row(
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text("Loading"),
                ),
              ],
            )));
    final prefs = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse(AUTH_API + '/resendMobileOTP'),
        body: {
          "userName": prefs.getString("userName"),
          "password": prefs.getString("password")
        });
    var responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "${responseData['otp']}", toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
      var currenDate = DateTime.now();
      var saveDate = DateFormat("dd/MM/yyyy").format(currenDate);
      prefs.setString('LoginDate', saveDate);
      print(responseData['otp']);
      print(responseData['data']);
      prefs.setBool('Authenticated', true);
      prefs.setInt('otp', responseData['otp']);
    }
  }

  Future otpconfirm() async {
    final prefs = await SharedPreferences.getInstance();
    if (otpController.text.isEmpty) {
      setState(() {
        Fluttertoast.showToast(msg: "Please Enter the Otp before proceed");
        otpValidate = "enter the otp to continue";
        _isValidate = true;
      });
    } else {
      setState(() {
        otpValidate = null;
        _isValidate = false;
      });
    }
    if (_isValidate == false) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => new AlertDialog(
                  content: Row(
                children: [
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Loading"),
                  ),
                ],
              )));
      var response = await http.post(Uri.parse(AUTH_API + '/verifyOTP'), body: {
        "userName": prefs.getString("userName"),
        "password": prefs.getString("password")
      });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: responseData['message']);

        final clientData = responseData['clientInfo'];

        final loginData = responseData['loginResponse'];
        var currenDate = DateTime.now();
        var saveDate = DateFormat("dd/MM/yyyy").format(currenDate);
        bool clientInfo =
            await prefs.setString('clientInfo', jsonEncode(clientData));

        bool loginInfo =
            await prefs.setString('loginInfo', jsonEncode(loginData));
        final login = prefs.getString('loginInfo');
        final retrieveClient = prefs.getString('clientInfo');
        final passcode = prefs.getString('passcode');
        final showClient = jsonDecode(retrieveClient);
        prefs.setString('LoginDate', saveDate);
        final retrieve2 = jsonDecode(login);
        prefs.setBool('isAuthenticated', true);
        prefs.setInt('otp',1);
        print("////");
        print(clientInfo);
        print(retrieve2['sessionToken']);
        print(retrieve2['refreshToken']);
        print(showClient['_id']);
        print(loginInfo);
        print("/////");
        if (passcode == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SetPasscode()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "User Invalid");
      }
    }
  }
}
