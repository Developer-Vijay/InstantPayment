import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/rechargesuccesspage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class ElectricityPage extends StatefulWidget {
  @override
  _ElectricityPageState createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  @override
  void initState() {
    super.initState();
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

  bool show = false;
  String sessionToken;
  String refreshtoken;
  var logindata;
  var retrieveLogin;
  var responseData;
  var jsonResponse;
  int selected;
  bool checker = false;
  bool checker2 = false;
  var responsed;
  String loginId;
  var jsonresponse;
  String operatorId;
  String operatorName;
  var amount;
  var name;
// getoperatorlist

  getOperatorList() async {
    return electricityMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshtoken = logindata['refreshToken'];
      loginId = logindata['user']['_id'];
      try {
        var response = await http.get(
            Uri.parse(ADMIN_API +
                '/getOperatorList' +
                '?operatorType=Utility&subdomain=instantpay'),
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken
            });
        responseData = jsonDecode(response.body);
        jsonResponse = response.body;
        if (response.statusCode == 200) {
          return responseData;
        } else {
          return response.statusCode;
        }
      } catch (e) {
        print(e);
      }
    });
  }

  // operator details
  getOperatorDetails(var id) async {
    try {
      var response = await http.get(
          Uri.parse(SERVICE_API +
              '/getApiOperatorCode' +
              '?apiOperatorCodeId=$id&subdomain=instantpay'),
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshtoken
          });
      jsonResponse = response.body;
      responsed = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // print(responsed);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

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
                child: FutureBuilder(
                    future: getOperatorList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                            decoration:
                                InputDecoration(errorText: operatorValidate),
                            isDense: false,
                            isExpanded: true,
                            hint: Text("Select an Operator"),
                            value: selected,
                            items: List.generate(
                              snapshot.data.length,
                              (index) => DropdownMenuItem(
                                  value: index,
                                  child: Text(snapshot.data[index]['name'])),
                            ),
                            onChanged: (value) {
                              int index = value;
                              setState(() {
                                selected = index;
                                operatorId = snapshot.data[index]
                                    ['activeAPIOperatorCodeId'];
                                print(operatorId);
                                operatorName = snapshot.data[index]['name'];
                                getOperatorDetails(operatorId);
                              });
                            });
                      } else {
                        return DropdownButtonFormField(
                          isDense: false,
                          isExpanded: true,
                          hint: Text("Select an Operator"),
                          items: [],
                          onChanged: (value) {},
                        );
                      }
                    })),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: accountNumberController,
                  maxLength: 12,
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
                    child: show == false
                        ? MaterialButton(
                            height: 7 * SizeConfig.heightMultiplier,
                            textColor: Apptheme.whitetextcolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Apptheme.PrimaryColor,
                            onPressed: () {
                              fetchbillAndPayBill();
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
                            onPressed: () {
                              fetchbillAndPayBill();

                              amountController.clear();
                              mobileNumberController.clear();
                              nameController.clear();
                              accountNumberController.clear();
                            },
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

  Future fetchbillAndPayBill() async {
    if (selected == null) {
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
    if (accountNumberController.text.length < 10) {
      setState(() {
        accountValidate = "account Number must be of 10 digit or 12 ";
        isValidate = true;
      });
    } else if (accountNumberController.text.isEmpty) {
      setState(() {
        accountValidate = "please enter the account Number";
        isValidate = true;
      });
    } else {
      setState(() {
        accountValidate = null;
        isValidate = false;
      });
    }

    if (mobileNumberController.text.length < 10) {
      setState(() {
        numberValidate = "mobile number should be of 10 digits";
        isValidate = true;
      });
    } else if (mobileNumberController.text.isEmpty) {
      setState(() {
        numberValidate = "please  enter the mobile number";
        isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
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

      Map data = {
        "performedBy": loginId,
        "operatorName": operatorName,
        "serviceName": "Recharge",
        "billPay": show
      };

      var firstJson = responsed;
      var secondJson = data;
      var dataCardJson = {...firstJson, ...secondJson};
      dataCardJson['requiredParams'][0]['value'] = accountNumberController.text;
      dataCardJson['requiredParams'][1]['value'] = mobileNumberController.text;

      var dataCardJsonBody = jsonEncode(dataCardJson);
      print(dataCardJsonBody);

      try {
        var response = await http.post(Uri.parse(SERVICE_API + '/getRecharge'),
            body: dataCardJsonBody,
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken,
              "refreshToken": refreshtoken
            });

        var responsedData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          setState(() {
            show = !show;
            amount = responsedData['dueAmount'];
            name = responsedData['customerName'];

            if (show == true) {
              amountController.text = amount.toString();
              nameController.text = name;
            } else {
              print(name);
            }
          });

          if (show == true) {
            Fluttertoast.showToast(msg: "Fetched Successfully");
            Navigator.pop(context);
          } else if (responsedData['errorExist'] == true) {
            Fluttertoast.showToast(msg: responsedData['message']);
            Navigator.pop(context);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RechargeSuccessPage(
                        amount: amountController.text,
                        date: DateTime.now(),
                        number: mobileNumberController.text,
                        orderId: accountNumberController.text,
                        responseData: responsedData)));
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
