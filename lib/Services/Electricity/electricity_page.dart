import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ElectricityPage extends StatefulWidget {
  @override
  _ElectricityPageState createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  @override
  void initState() {
    super.initState();
    show = true;
  }

  TextEditingController operatorController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  var operatorValidate;
  var accountValidate;
  var numberValidate;
  var nameValidate;
  var amountValidate;
  bool isValidate = false;

  String dropdownValue = "Select an Operator";

  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electricity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: operatorController,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: dropdownValue,
                    errorText: numberValidate,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    suffixIcon: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 0) {
                          setState(() {
                            operatorController.text = "Tata Sky";
                          });
                        } else if (value == 1) {
                          setState(() {
                            operatorController.text = "Airtel Digital Tv";
                          });
                        } else if (value == 2) {
                          setState(() {
                            operatorController.text = "Dish Tv";
                          });
                        } else if (value == 3) {
                          setState(() {
                            operatorController.text = "D2H";
                          });
                        } else if (value == 4) {
                          setState(() {
                            operatorController.text = "Sun Direct";
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("TPDL"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("BSES"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Dish Tv"),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("D2H"),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text("Sun Direct"),
                          value: 4,
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: accountNumberController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorText: accountValidate,
                      counterText: "",
                      labelText: "Account Number"),
                ),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: mobileNumberController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorText: numberValidate,
                      counterText: "",
                      labelText: "Mobile Number"),
                ),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorText: nameValidate,
                      counterText: "",
                      labelText: "Customer Name"),
                ),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorText: amountValidate, labelText: "Amount"),
                ),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: show == true
                        ? MaterialButton(
                            height: 7 * SizeConfig.heightMultiplier,
                            textColor: Apptheme.whitetextcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Apptheme.PrimaryColor,
                            onPressed: () {
                              fetchbill();
                            },
                            child: Text(
                              "fetch bill",
                              style: TextStyle(
                                  fontSize: 2.2 * SizeConfig.textMultiplier),
                            ),
                          )
                        : MaterialButton(
                            height: 7 * SizeConfig.heightMultiplier,
                            textColor: Apptheme.whitetextcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Apptheme.PrimaryColor,
                            onPressed: () {},
                            child: Text(
                              "Pay bill",
                              style: TextStyle(
                                  fontSize: 2.2 * SizeConfig.textMultiplier),
                            ),
                          )))
          ],
        ),
      ),
    );
  }

  Future fetchbill() async {
    if (operatorController.text.isEmpty) {
      setState(() {
        operatorValidate = "please select an operator";
        isValidate = true;
      });
    } else {
      setState(() {
        operatorValidate = null;
        isValidate = false;
      });
    }
// Account Number
    if (accountNumberController.text.isEmpty) {
      setState(() {
        accountValidate = "please select an operator";
        isValidate = true;
      });
    } else {
      setState(() {
        accountValidate = null;
        isValidate = false;
      });
    }

    if (mobileNumberController.text.isEmpty) {
      setState(() {
        numberValidate = "please select an operator";
        isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
        isValidate = false;
      });
    }
    // Name Validate
    // if (nameController.text.isEmpty) {
    //   setState(() {
    //     nameValidate = "please select an operator";
    //     isValidate = true;
    //   });
    // } else {
    //   setState(() {
    //     nameValidate = null;
    //     isValidate = false;
    //   });
    // }
    // amount
    // if (amountController.text.isEmpty) {
    //   setState(() {
    //     amountValidate = "please select an operator";
    //     isValidate = true;
    //   });
    // } else {
    //   setState(() {
    //     amountValidate = null;
    //     isValidate = false;
    //   });
    // }

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
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ));
      setState(() {
        show = false;
        nameController.text = "Carl";
        amountController.text = "400";
        // Navigator.pop(context);
      });

      Fluttertoast.showToast(msg: "fetching");
    } else {
      Fluttertoast.showToast(msg: "error");
    }
  }
}
