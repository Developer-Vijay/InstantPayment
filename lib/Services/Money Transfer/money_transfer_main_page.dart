import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Money%20Transfer/add_beneficiary.dart';

import '../serviceslist.dart';

class MoneyTransferMainPage extends StatefulWidget {
  @override
  _MoneyTransferMainPageState createState() => _MoneyTransferMainPageState();
}

class _MoneyTransferMainPageState extends State<MoneyTransferMainPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  var numberValidate;
  var firstNameValidate;
  var lastNameValidate;

  bool _isValidate = false;
  bool firstname = false;
  bool lastname = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Transfer"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 2.5 * SizeConfig.heightMultiplier),
          Center(child: Text("Service Charges from effect from 02.05.2021")),
          SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    "Transaction Amount",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(
                    "Charges",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("0-58975")),
                    DataCell(Text("5.0%"))
                  ])
                ],
              ),
            ),
          ),
          SizedBox(height: 2.5 * SizeConfig.heightMultiplier),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Minimum Transaction Fee is INR 50 & Maximum Transaction Fee is INR 2000",
              style: TextStyle(fontSize: 1.2* SizeConfig.textMultiplier),
            ),
          ),
          FlatButton(
            onPressed: () {},
            textColor: Apptheme.PrimaryColor,
            child: Text(
              "Click here to view charges in other languages",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline),
            ),
          ),
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
            child: Container(
                child: firstname == true
                    ? TextField(
                        controller: firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            errorText: firstNameValidate,
                            counterText: "",
                            labelText: "First Name"),
                      )
                    : SizedBox()),
          ),
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
                child: lastname == true
                    ? TextField(
                        controller: lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            errorText: lastNameValidate,
                            counterText: "",
                            labelText: "Last Name"),
                      )
                    : SizedBox()),
          ),
          SizedBox(
            height: 4 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 6 * SizeConfig.heightMultiplier,
                textColor: Apptheme.whitetextcolor,
                color: Apptheme.PrimaryColor,
                onPressed: () {
                  firstname == false ? validateUser() : addUser();
                },
                child: firstname == true
                    ? Text(
                        "Enroll",
                        style: TextStyle(
                            fontSize: 2.1 * SizeConfig.textMultiplier),
                      )
                    : Text(
                        "Pay",
                        style: TextStyle(
                            fontSize: 2.1 * SizeConfig.textMultiplier),
                      )),
          ),
        ],
      ),
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
      Fluttertoast.showToast(msg: "User Added Succesfully");
      add.add(
        Transfer(
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
        ),
      );
      setState(() {
        firstname = false;
        lastname = false;
      });
    }
  }

// Another Function
  Future validateUser() async {
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

    if (_isValidate == false && numberController.text.contains(add[0].number)) {
      Fluttertoast.showToast(msg: "Authenticated");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddBeneficiary(
                    data: add,
                  )));

      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     content: Container(
      //       height: 25 * SizeConfig.heightMultiplier,
      //       child: Column(
      //         children: [
      //           InkWell(
      //             onTap: () {
      //               Navigator.pop(context);
      //             },
      //             child: Container(
      //               alignment: Alignment.topRight,
      //               child: Icon(Icons.clear),
      //             ),
      //           ),
      //           SizedBox(
      //             height: 2.4 * SizeConfig.heightMultiplier,
      //           ),
      //           Text("Please Enter The Otp"),
      //           SizedBox(
      //             height: 2.4 * SizeConfig.heightMultiplier,
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(left: 12, right: 12),
      //             child: TextField(
      //               controller: numberController,
      //               maxLength: 6,
      //               keyboardType: TextInputType.phone,
      //               decoration: InputDecoration(
      //                   errorText: numberValidate,
      //                   counterText: "",
      //                   labelText: "OTP"),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      // widget.controller.animateTo(widget.selectedindex += 1);
    } else if (_isValidate == false &&
        !numberController.text.contains(add[0].number)) {
      Fluttertoast.showToast(msg: "No account Find Please Enroll First ");
      setState(() {
        firstname = true;
        lastname = true;
      });
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
