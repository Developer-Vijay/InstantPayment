import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/serviceslist.dart';

// ignore: must_be_immutable
class AddUser extends StatefulWidget {
  TabController controller;
  int selectedindex;
  AddUser({this.controller, this.selectedindex});
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  var numberValidate;
  var firstNameValidate;
  var lastNameValidate;

  bool _isValidate = false;

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
            controller: numberController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: numberValidate,
                counterText: "",
                labelText: "Phone Number"),
          ),
        ),
        SizedBox(
          height: 4 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: firstNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                errorText: firstNameValidate,
                counterText: "",
                labelText: "First Name"),
          ),
        ),
        SizedBox(
          height: 4 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: lastNameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                errorText: lastNameValidate,
                counterText: "",
                labelText: "Last Name"),
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
              addUser();
            },
            child: Text(
              "Enroll",
              style: TextStyle(fontSize: 2.1 * SizeConfig.textMultiplier),
            ),
          ),
        )
      ],
    );
  }

  Future addUser() async {
    if (numberController.text.isEmpty) {
      setState(() {
        numberValidate = "Phone number cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
        _isValidate = false;
      });
    }

    if (firstNameController.text.isEmpty) {
      setState(() {
        firstNameValidate = "First name cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        firstNameValidate = null;
        _isValidate = false;
      });
    }

    if (lastNameController.text.isEmpty) {
      setState(() {
        lastNameValidate = "last name cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        lastNameValidate = null;
        _isValidate = false;
      });
    }

    if (_isValidate == false) {
      Fluttertoast.showToast(msg: "user is added");

      add.add(Transfer(
        bulktransfer: true,
        limit: "500000",
        spent: "20",
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        imps: true,
        mode: "Active",
        bankName: "SBI",
        accountNumber: "10234564679864",
        neft: "false",
        verification: true,
        number: numberController.text,
      ));
     
      widget.controller.animateTo(widget.selectedindex += 1);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
