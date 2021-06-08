import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netly/Components/Auth/otp_validate.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/strings.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isValidate = false;
  bool show = true;
  var isNameValidate;
  var isPasswordValidate;
  @override
  void dispose() {
    super.dispose();
    _usernameController.clear();
    _passwordController.clear();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: SafeArea(
        child: Scaffold(
            body: ListView(
          children: [
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier,
            ),
            Center(
              child: Container(
                  height: 40 * SizeConfig.imageSizeMultiplier,
                  child: Image.asset(Images.loginImage)),
            ),
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                Strings.loginpageheadingtitile,
                style: TextStyle(
                    fontFamily: 'Orelega One',
                    fontWeight: FontWeight.w400,
                    fontSize: 2.571 * SizeConfig.textMultiplier),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                Strings.loginPageTitle,
                style: Apptheme.loginPageTitle,
              ),
            ),
            SizedBox(
              height: 8 * SizeConfig.heightMultiplier,
            ),
            // Username
            Container(
                margin: EdgeInsets.only(
                    left: 5 * SizeConfig.widthMultiplier,
                    right: 5 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(1, 1),
                          color: Apptheme.whitetextcolor)
                    ]),
                child: TextField(
                  controller: _usernameController,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorText: isNameValidate,
                      labelStyle:  GoogleFonts.oregano(),
                        // fontSize: 2.2 * SizeConfig.textMultiplier,
                        // color: Apptheme.whitetextcolor),
                      contentPadding: EdgeInsets.all(5),
                      suffixIcon: Icon(
                        Icons.person,
                        size: 2.6 * SizeConfig.heightMultiplier,
                      ),
                      labelText: "Username"),
                )),
            SizedBox(
              height: 6 * SizeConfig.heightMultiplier,
            ),
            // Password Validation
            Container(
                margin: EdgeInsets.only(
                    left: 5 * SizeConfig.widthMultiplier,
                    right: 5 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(1, 1),
                          color: Apptheme.whitetextcolor)
                    ]),
                child: TextField(
                  controller: _passwordController,
                  autocorrect: false,
                  obscureText: show,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorText: isPasswordValidate,
                      labelStyle:  GoogleFonts.oregano(),
                        // fontSize: 2.2 * SizeConfig.textMultiplier,
                        // color: Apptheme.whitetextcolor),
                      contentPadding: EdgeInsets.all(6),
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
                      labelText: "Password"),
                )),
            SizedBox(
              height: 7 * SizeConfig.heightMultiplier,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 5 * SizeConfig.widthMultiplier,
                  right: 5 * SizeConfig.widthMultiplier),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 6.2 * SizeConfig.heightMultiplier,
                color: Apptheme.PrimaryColor,
                onPressed: () {
                  login();
                },
                child: Text("LOGIN",
                    style: GoogleFonts.oregano(
                        fontSize: 2.2 * SizeConfig.textMultiplier,
                        color: Apptheme.whitetextcolor)),
              ),
            ),

            SizedBox(
              height: 2.5 * SizeConfig.heightMultiplier,
            ),
            Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password ?",
                    style:  GoogleFonts.oregano(
                        fontSize: 2.2 * SizeConfig.textMultiplier,
                        color: Apptheme.whitetextcolor)
                  ),
                ))
          ],
        )),
      ),
    );
  }

  Future login() async {
    // name Validation
    final prefs = await SharedPreferences.getInstance();
    if (_usernameController.text.isEmpty) {
      setState(() {
        isNameValidate = "username cannot be empty";
        isValidate = true;
      });
    } else {
      setState(() {
        isNameValidate = null;
        isValidate = false;
      });
    }

    // password Validation
    if (_passwordController.text.isEmpty) {
      setState(() {
        isPasswordValidate = "password cannot be empty";
        isValidate = true;
      });
    } else {
      setState(() {
        isPasswordValidate = null;
        isValidate = false;
      });
    }
    if (isValidate == false) {
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
      var response = await http.post(Uri.parse(AUTH_API + '/login'), body: {
        "userName": _usernameController.text,
        "password": _passwordController.text
      });
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['errorExist'] == true) {
          Fluttertoast.showToast(msg: responseData['message']);
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              msg: "${responseData['otp']}", toastLength: Toast.LENGTH_LONG);

          prefs.setBool('Authenticated', true);

          prefs.setString('userName', _usernameController.text);
          prefs.setString('password', _passwordController.text);
          prefs.setInt('otp', responseData['otp']);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OtpValidate()));
        }
      } else {
        Navigator.pop(context);
        print(response.statusCode);
        Fluttertoast.showToast(msg: responseData['message']);
      }
    }
  }
}
