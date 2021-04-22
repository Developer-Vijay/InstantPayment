import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/strings.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isValidate = false;

  var isNameValidate;
  var isPasswordValidate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  labelStyle: TextStyle(fontFamily: 'Orelega One'),
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  errorText: isPasswordValidate,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w100, fontFamily: 'Orelega One'),
                  contentPadding: EdgeInsets.all(6),
                  suffixIcon: Icon(
                    Icons.lock,
                    size: 2.6 * SizeConfig.heightMultiplier,
                  ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 6.2 * SizeConfig.heightMultiplier,
            color: Apptheme.PrimaryColor,
            onPressed: () {
              login();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text(
              "LOGIN",
              style: TextStyle(
                  fontFamily: 'Orelega One',
                  fontSize: 2.2 * SizeConfig.textMultiplier,
                  color: Apptheme.whitetextcolor),
            ),
          ),
        ),
        SizedBox(
          height: 2.5 * SizeConfig.heightMultiplier,
        ),
        Container(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                "Forgot Password ?",
                style: TextStyle(
                    fontFamily: 'Orelega One',
                    color: Apptheme.blacktextColor,
                    fontWeight: FontWeight.w400),
              ),
            ))
      ],
    ));
  }

  Future login() async {
    // name Validation

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
  }
}
