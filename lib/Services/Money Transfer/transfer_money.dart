import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../success_page.dart';

// ignore: must_be_immutable
class TransferMoney extends StatefulWidget {
  var bankname;
  var name;
  var number;
  var accountNumber;
  var ifscCode;
  var beneId;
  TransferMoney(
      {this.bankname,
      this.name,
      this.number,
      this.accountNumber,
      this.ifscCode,
      this.beneId});
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  @override
  void initState() {
    super.initState();
    getuserData();
  }

  TextEditingController transferController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String dropdownValue = "Mode of Transfer";
  final textstyle1 = TextStyle(fontSize: 1.6 * SizeConfig.textMultiplier);
  final textstyle2 = TextStyle(
      fontSize: 2 * SizeConfig.textMultiplier, fontWeight: FontWeight.w600);
  var amountValidate;
  var transferValidate;
  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;
  bool isValidate = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Transfer Money"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 4.2 * SizeConfig.heightMultiplier,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Selected Bank",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 2 * SizeConfig.textMultiplier),
                  ),
                  Spacer(),
                  Text("${widget.bankname}"),
                ],
              ),
            ),
            SizedBox(
              height: 7 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: amountValidate, labelText: "Enter Amount"),
              ),
            ),
            SizedBox(
              height: 7 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: transferController,
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: dropdownValue,
                    errorText: transferValidate,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    suffixIcon: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 0) {
                          setState(() {
                            transferController.text = "IMPS";
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("IMPS"),
                          value: 0,
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 4.2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                height: 6.2 * SizeConfig.heightMultiplier,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Apptheme.PrimaryColor,
                textColor: Apptheme.whitetextcolor,
                onPressed: () {
                  pay();
                },
                child: Text(
                  "Pay",
                  style: TextStyle(fontSize: 2.2 * SizeConfig.textMultiplier),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getuserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshToken = logindata['refreshToken'];
      loginId = logindata['user']['_id'];
      print("?????????");
      print(loginId);
      print("?????????");
    });
  }

  transferMoney() async {
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
    Map data = {
      "mobileNumber": widget.number,
      "accountNumber": widget.accountNumber,
      "bankName": widget.bankname,
      "IFSCCode": widget.ifscCode,
      "beneficiaryName": widget.name,
      "beneficiaryId": widget.beneId,
      "transactionAmount": amountController.text,
      "transferMode": 2,
      "performedBy": loginId
    };
    var encodedData = jsonEncode(data);
    print(encodedData);
    var response = await http.post(SERVICE_API + '/getMoneyTransfer',
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        },
        body: encodedData);
    var responseData = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        print(responseData);
        if (responseData['errorExist'] == true) {
          Fluttertoast.showToast(msg: responseData['message']);
          Navigator.pop(context);
        } else {
          Navigator.push(context,MaterialPageRoute(builder:(context) => SuccessPage(
             title: "Money Transfer",
             responseData: responseData
             )));
        }
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomeScreen(),
        //     ));
      } else {
        print(response.statusCode);
        Fluttertoast.showToast(msg: responseData['message']);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> pay() async {
    if (transferController.text.isEmpty) {
      setState(() {
        transferValidate = "Please Select the Transfer Type";
        isValidate = true;
      });
    } else {
      setState(() {
        transferValidate = null;
        isValidate = false;
      });
    }
    if (amountController.text.isEmpty) {
      setState(() {
        amountValidate = "Please enter the amount";
        isValidate = true;
      });
    } else if (amountController.text == "1") {
      setState(() {
        amountValidate = "Minimum Amount Should be 5";
        isValidate = true;
      });
    } else if (amountController.text == "2") {
      setState(() {
        amountValidate = "Minimum Amount Should be 5";
        isValidate = true;
      });
    } else if (amountController.text == "3") {
      setState(() {
        amountValidate = "Minimum Account Should be 5";
        isValidate = true;
      });
    } else if (amountController.text == "4") {
      setState(() {
        amountValidate = "Minimum Amount Should be 5";
        isValidate = true;
      });
    } else {
      setState(() {
        amountValidate = null;
        isValidate = false;
      });
    }

    if (isValidate == false) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are You sure You want to Proceed"),
            content: Container(
              height: 29 * SizeConfig.heightMultiplier,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Bene Name",
                        style: textstyle2,
                      ),
                      Spacer(),
                      Text(
                        "${widget.name}",
                        style: textstyle1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text("Bene Mobile No.", style: textstyle2),
                      Spacer(),
                      Text("${widget.number}", style: textstyle1)
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text("Bene Account No.", style: textstyle2),
                      Spacer(),
                      Text("${widget.accountNumber}", style: textstyle1)
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text("Bank Name", style: textstyle2),
                      Spacer(),
                      Text("${widget.bankname}", style: textstyle1)
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text("Transaction Amount", style: textstyle2),
                      Spacer(),
                      Text("${amountController.text}", style: textstyle1)
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                color: Apptheme.textColo1r,
                textColor: Apptheme.whitetextcolor,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Apptheme.PrimaryColor,
                textColor: Apptheme.whitetextcolor,
                child: Text("Proceed"),
                onPressed: () {
                  transferMoney();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
