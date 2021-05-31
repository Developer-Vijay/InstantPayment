import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnedayOtp extends StatefulWidget {
  @override
  _OnedayOtpState createState() => _OnedayOtpState();
}

class _OnedayOtpState extends State<OnedayOtp> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  var otp;
  void getdata() async {
    final prefs = await SharedPreferences.getInstance();
    otp = prefs.getInt('otp');
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

  TextEditingController otpController = TextEditingController();
  var otpValidate;
  bool _isValidate = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 16.1 * SizeConfig.heightMultiplier,
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                elevation: 14,
                child: Image.asset(
                  Images.loginImage,
                  height: 40 * SizeConfig.imageSizeMultiplier,
                ),
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Center(
              child: Text(
                "Enter OTP",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 2.4 * SizeConfig.textMultiplier),
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  maxLength: 6,
                  maxLines: 1,
                  enabled: true,
                  obscureText: true,
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none,
                    errorText: otpValidate,
                    suffixIcon: Icon(
                      Icons.lock,
                      size: 2.4 * SizeConfig.heightMultiplier,
                    ),
                    labelText: "Please enter the Otp",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.4 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                height: 6 * SizeConfig.heightMultiplier,
                textColor: Colors.white,
                color: Apptheme.PrimaryColor,
                onPressed: () {
                  validatePassowrd();
                },
                child: Text("Confirm Otp"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future validatePassowrd() async {
    if (otpController.text.isEmpty) {
      setState(() {
        otpValidate = 'Please Enter the Otp password ';
        _isValidate = true;
      });
    } else {
      setState(() {
        otpValidate = null;
        _isValidate = false;
      });
    }
    if (_isValidate == false && otpController.text == otp.toString()) {
      Fluttertoast.showToast(msg: "Validate Successfully");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Invalid otp code");
    }
  }
}
