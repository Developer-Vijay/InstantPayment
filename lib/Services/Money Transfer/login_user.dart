import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Money%20Transfer/add_beneficiary.dart';
import 'package:netly/Services/serviceslist.dart';

class LoginUser extends StatefulWidget {
  TabController controller;
  int selectedindex;
  LoginUser({this.controller, this.selectedindex});
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController numberController = TextEditingController();
  bool show = false;
  var numberValidate;
  bool isValidate = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 2 * SizeConfig.heightMultiplier,
        ),
        // Phone Number
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            enableSuggestions: true,
            controller: numberController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: numberValidate,
                counterText: "",
                labelText: "Please enter registered mobile number"),
          ),
        ),
        SizedBox(
          height: 4 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 6 * SizeConfig.heightMultiplier,
            textColor: Apptheme.whitetextcolor,
            color: Apptheme.PrimaryColor,
            onPressed: () {
              loginuser();
            },
            child: Text(
              "Login",
              style: TextStyle(fontSize: 2.1 * SizeConfig.textMultiplier),
            ),
          ),
        ),
      ],
    );
  }

  Future loginuser() async {
    if (numberController.text.isEmpty) {
      setState(() {
        numberValidate = "please enter the phone number";
        isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
        isValidate = false;
      });
    }
    if (isValidate == false && numberController.text.contains(add[0].number)) {
      setState(() {
        show = true;
      });
      Fluttertoast.showToast(msg: "it is avaliable");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBeneficiary(
              data: add,
            ),
          ));
    } else if (isValidate == false &&
        !numberController.text.contains(add[0].number)) {
      Fluttertoast.showToast(msg: "Please add yourself before login");
      widget.controller.animateTo(widget.selectedindex = 0);
    } else if (isValidate == false && add.length == 0) {
      Fluttertoast.showToast(msg: "Please add yourself before login");
      widget.controller.animateTo(widget.selectedindex = 0);
    } else {
      Fluttertoast.showToast(msg: "error");
    }
  }
}
