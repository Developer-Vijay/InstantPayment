import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Money%20Transfer/verificationpage.dart';
import 'package:netly/Services/serviceslist.dart';

class BenificaryPage extends StatefulWidget {
  TabController controller;
  var data;
  int selectedIndex;
  BenificaryPage({this.controller, this.selectedIndex, this.data});
  @override
  _BenificaryPageState createState() => _BenificaryPageState();
}

class _BenificaryPageState extends State<BenificaryPage> {
  TextEditingController banknameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String dropdownValue = 'select Bank Name';

  var bankValidate;
  var acccountValidate;
  var nameValidate;
  var codeValidate;

  bool isValidate = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 0 * SizeConfig.widthMultiplier,
        ),
        Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 8),
                color: Apptheme.PrimaryColor,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Apptheme.whitetextcolor
                            // border: Border.all()
                            ),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "MonthlyLimit:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 2.1 * SizeConfig.widthMultiplier,
                                      ),
                                      Text(add[index].limit,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                      // Spacer(),
                                      // SizedBox(
                                      //   width: 6 * SizeConfig.widthMultiplier,
                                      // ),
                                      // Text("",
                                      //     style: TextStyle(
                                      //         color: Colors.white,
                                      //         fontWeight: FontWeight.w600)),

                                      // SizedBox(
                                      //   width: 5 * SizeConfig.widthMultiplier,
                                      // ),
                                      Spacer(),
                                      Text("Spent:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 2.1 * SizeConfig.widthMultiplier,
                                      ),
                                      Text(add[index].spent,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1 * SizeConfig.heightMultiplier,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        // height: 24 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            // color: Apptheme.whitetextcolor
                            // border: Border.all()
                            ),
                        child: ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.all(8),
                                // decoration: BoxDecoration(border: Border.all()),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Mode",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Text("${add[index].mode}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("IMPS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Text("${add[index].imps}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("NEFT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Text("${add[index].neft}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Verification",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Text("${add[index].verification}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      children: [
                                        Text("Bulk-transfer",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                        Spacer(),
                                        Text("${add[index].bulktransfer}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: MaterialButton(
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(10)),
                                    //     height: 6 * SizeConfig.heightMultiplier,
                                    //     textColor: Apptheme.whitetextcolor,
                                    //     color: Apptheme.PrimaryColor,
                                    //     onPressed: () {
                                    //       Navigator.push(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) => AddBeneficiary()));
                                    //     },
                                    //     child: Text(
                                    //       "Add Benificiary",
                                    //       style: TextStyle(
                                    //           fontSize: 2.1 * SizeConfig.textMultiplier),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                )),

            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: banknameController,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: "Benefiiciary Bank Name",
                    hintText: dropdownValue,
                    errorText: bankValidate,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    suffixIcon: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 0) {
                          setState(() {
                            banknameController.text = "State Bank of India";
                          });
                        } else if (value == 1) {
                          setState(() {
                            banknameController.text = "Punjab National Bank";
                          });
                        } else if (value == 2) {
                          setState(() {
                            banknameController.text = "Axis Bank";
                          });
                        } else if (value == 3) {
                          setState(() {
                            banknameController.text = "HDFC Bank";
                          });
                        } else if (value == 4) {
                          setState(() {
                            banknameController.text = "ICICI Bank";
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("State Bank of India"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Punjab National Bank"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Axis Bank"),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("HDFC Bank"),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text("ICICI Bank"),
                          value: 4,
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            // Phone Number
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                enableSuggestions: true,
                controller: accountController,
                maxLength: 16,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    errorText: acccountValidate,
                    counterText: "",
                    labelText: "Account Number"),
              ),
            ),

            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            // Beneficiary Name
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                enableSuggestions: true,
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    errorText: nameValidate,
                    counterText: "",
                    labelText: "Beneficiary Name"),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                enableSuggestions: true,
                controller: codeController,
                maxLength: 10,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    errorText: codeValidate,
                    counterText: "",
                    labelText: "IFSC Code"),
              ),
            ),

            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 46 * SizeConfig.widthMultiplier,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Apptheme.PrimaryColor,
                      textColor: Apptheme.whitetextcolor,
                      onPressed: () {
                        verifyBene();
                      },
                      child: Text("Verify Bene"),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 46 * SizeConfig.widthMultiplier,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Apptheme.PrimaryColor,
                      textColor: Apptheme.whitetextcolor,
                      onPressed: () {
                        addBene();
                      },
                      child: Text("Add Bene"),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 2.1 * SizeConfig.heightMultiplier,
            ),
          ],
        ),
      ],
    );
  }

  Future addBene() async {
    if (banknameController.text.isEmpty) {
      setState(() {
        bankValidate = 'It cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        bankValidate = null;
        isValidate = false;
      });
    }

    if (accountController.text.isEmpty) {
      setState(() {
        acccountValidate = 'account number cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        acccountValidate = null;
        isValidate = false;
      });
    }

    if (nameController.text.isEmpty) {
      setState(() {
        nameValidate = 'Name cannot be Empty';
        isValidate = true;
      });
    } else {
      setState(() {
        nameValidate = null;
        isValidate = false;
      });
    }

    if (codeController.text.isEmpty) {
      setState(() {
        codeValidate = 'IFSC code cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        codeValidate = null;
        isValidate = false;
      });
    }
    if (isValidate == false) {
      banklist.add(BankDetails(
          accountNumber: accountController.text,
          bankName: banknameController.text,
          name: nameController.text));
      Fluttertoast.showToast(msg: "Data Added");
      widget.controller.animateTo(widget.selectedIndex = 1);
    } else {
      Fluttertoast.showToast(msg: "error in adding");
    }
  }

// verify bene
  Future verifyBene() async {
    if (banknameController.text.isEmpty) {
      setState(() {
        bankValidate = 'It cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        bankValidate = null;
        isValidate = false;
      });
    }

    if (accountController.text.isEmpty) {
      setState(() {
        acccountValidate = 'account number cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        acccountValidate = null;
        isValidate = false;
      });
    }

    if (nameController.text.isEmpty) {
      setState(() {
        nameValidate = 'Name cannot be Empty';
        isValidate = true;
      });
    } else {
      setState(() {
        nameValidate = null;
        isValidate = false;
      });
    }

    if (codeController.text.isEmpty) {
      setState(() {
        codeValidate = 'IFSC code cannot be empty';
        isValidate = true;
      });
    } else {
      setState(() {
        codeValidate = null;
        isValidate = false;
      });
    }
    if (isValidate == false &&
        nameController.text.contains(
          add[0].firstName,
        )) {
      Fluttertoast.showToast(msg: "Verified api integration will work here");
      // showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   builder: (context) => Container(
      //       height: 50 * SizeConfig.heightMultiplier, child: VerifiedData()),
      // );
    } else {
      Fluttertoast.showToast(msg: "Not Verified");
    }
  }
}
