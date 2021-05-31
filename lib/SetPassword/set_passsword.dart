import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasscode extends StatefulWidget {
  @override
  _SetPasscodeState createState() => _SetPasscodeState();
}

class _SetPasscodeState extends State<SetPasscode> {
  TextEditingController controller = TextEditingController();
  var pinValidate;
  bool isValidate = false;
  var passcode;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 20 * SizeConfig.heightMultiplier,
              ),
              Center(
                child: Image.asset(
                  Images.passwordImage,
                  height: 40 * SizeConfig.imageSizeMultiplier,
                ),
              ),
              SizedBox(height: 5 * SizeConfig.heightMultiplier),
              Center(
                child: Text(
                  "Set Your Passcode",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 2.4 * SizeConfig.textMultiplier),
                ),
              ),
              SizedBox(height: 5 * SizeConfig.heightMultiplier),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 8, bottom: 8),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: PinCodeTextField(
                      autoFocus: true,
                      obscureText: true,
                      appContext: context,
                      length: 4,
                      onChanged: (value) {
                        print(value);
                      },
                      enablePinAutofill: false,
                      controller: controller,
                      pinTheme: PinTheme(
                        activeColor: Apptheme.PrimaryColor,
                          shape: PinCodeFieldShape.underline,
                          inactiveColor: Colors.grey),
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      autoDismissKeyboard: true,
                      autoDisposeControllers: false,
                    )),
              ),
              SizedBox(height: 4 * SizeConfig.heightMultiplier),
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
                    setPin();
                  },
                  child: Text(
                    "Set Passcode",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future setPin() async {
    final prefs = await SharedPreferences.getInstance();
    if (controller.text.isEmpty) {
      setState(() {
        Fluttertoast.showToast(msg: "Please Enter the Passcode");
        // pinValidate = "Please Enter The Pin";
        isValidate = true;
      });
    } else if (controller.text.length < 4) {
      setState(() {
        Fluttertoast.showToast(msg: "Passcode must be of 4 digits ");
        // pinValidate = "Pin should be of 4 Characters";
        isValidate = true;
      });
    } else {
      setState(() {
        pinValidate = null;
        isValidate = false;
      });
    }
    if (isValidate == false) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (_) => Container(
                // height: 40,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 120),
                      child: Image.asset(
                        "assets/images/nplogo.png",
                        height: 25 * SizeConfig.imageSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ));
      prefs.setString('passcode', controller.text.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    }
  }
}
