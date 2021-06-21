import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasscode extends StatefulWidget {
  @override
  _ChangePasscodeState createState() => _ChangePasscodeState();
}

class _ChangePasscodeState extends State<ChangePasscode> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  TextEditingController oldPasscodeController = TextEditingController();
  TextEditingController newPasscodeController = TextEditingController();
  bool show = false;
  var oldValidate;
  var newValidate;
  var passcode;
  bool isValidate = false;

  void getdata() async {
    final prefs = await SharedPreferences.getInstance();
    passcode = prefs.getString('passcode');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Change Passcode",
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
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: newPasscodeController,
                maxLength: 4,
                maxLines: 1,
                enabled: true,
                obscureText: show,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none,
                  errorText: newValidate,
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      child: show == true
                          ? Icon(
                              Icons.lock,
                              size: 2.6 * SizeConfig.heightMultiplier,
                            )
                          : Icon(
                              Icons.lock_open_sharp,
                              size: 2.6 * SizeConfig.heightMultiplier,
                            )),
                  labelText: "New Passcode",
                ),
              ),
            ),
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
                changePin();
              },
              child: Text("Change Passcode"),
            ),
          )
        ],
      ),
    );
  }

  Future changePin() async {
    final prefs = await SharedPreferences.getInstance();

    if (newPasscodeController.text.isEmpty) {
      setState(() {
        newValidate = "please enter the new passcode";
        isValidate = true;
      });
    } else if (newPasscodeController.text.length < 4) {
      setState(() {
        newValidate = "passcode should be of 4 digits";
        isValidate = true;
      });
    } else {
      setState(() {
        newValidate = null;
        isValidate = false;
      });
    }

    if (isValidate == false) {
      prefs.setString('passcode', newPasscodeController.text.toString());
      Fluttertoast.showToast(msg: "Password Changed Sucessfully");

      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Password not Changed");
    }
  }
}
