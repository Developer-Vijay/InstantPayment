import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/rechargesuccesspage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class DataCardPage extends StatefulWidget {
  @override
  _DataCardPageState createState() => _DataCardPageState();
}

class _DataCardPageState extends State<DataCardPage> {
  String dropdownValue = 'Operator';

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController payController = TextEditingController();

  bool _isValidate = false;

  String operatorValidate;
  String accountNumberValidate;
  String payValidate;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getOperatorList();
    });
  }

  // variables decelartion
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

// getoperatorlist

  getOperatorList() async {
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
              '?operatorType=Broadband&subdomain=instantpay'),
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken
          });
      responseData = jsonDecode(response.body);
      jsonResponse = response.body;
      if (response.statusCode == 200) {
        setState(() {
          checker = true;
          checker2 = false;
        });
        print(responseData);
      } else {
        setState(() {
          checker = true;
          checker2 = true;
        });
        // Fluttertoast.showToast(
        //     msg: "Unable to get Details",
        //     textColor: Apptheme.whitetextcolor,
        //     backgroundColor: Apptheme.textColo1r);
        // Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

// operator details
  getOperatorDetails(var id) async {
    //  showDialog(
    //         barrierDismissible: false,
    //         context: context,
    //         builder: (_) => new AlertDialog(
    //                 content: Row(
    //               children: [
    //                 CircularProgressIndicator(),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 12),
    //                   child: Text("Loading"),
    //                 ),
    //               ],
    //             )));
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
        // Fluttertoast.showToast(
        //     msg: "Operator Details Fetched Successfuly",
        //     backgroundColor: Colors.green,
        //     textColor: Colors.white);
        // Navigator.pop(context);
      } else {
        // Navigator.pop(context);
        // Fluttertoast.showToast(
        //     msg: "Error in fetching Operator Details",
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Data Card"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 20, bottom: 10),
                child: Text(
                  "Select an Operator",
                  style: TextStyle(
                      fontSize: 2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: responseData == null
                      ? DropdownButtonFormField(
                          isDense: false,
                          isExpanded: true,
                          hint: Text("Select an Operator"),
                          items: [],
                          onChanged: (value) {},
                        )
                      : DropdownButtonFormField(
                          decoration:
                              InputDecoration(errorText: operatorValidate),
                          isDense: false,
                          isExpanded: true,
                          hint: Text("Select an Operator"),
                          value: selected,
                          items: List.generate(
                            responseData.length,
                            (index) => DropdownMenuItem(
                                value: index,
                                child: Text(responseData[index]['name'])),
                          ),
                          onChanged: (value) {
                            int index = value;
                            setState(() {
                              selected = index;
                              operatorId = responseData[index]
                                  ['activeAPIOperatorCodeId'];
                              print(operatorId);
                              operatorName = responseData[index]['name'];
                              getOperatorDetails(operatorId);
                            });
                          })),
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
                        errorText: accountNumberValidate,
                        counterText: "",
                        labelText: "Account No."),
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
                    controller: payController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: payValidate, labelText: "Pay"),
                  ),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  height: 7 * SizeConfig.heightMultiplier,
                  textColor: Apptheme.whitetextcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Apptheme.PrimaryColor,
                  onPressed: () {
                  //  Navigator.push(context,MaterialPageRoute(builder: (context) => RechargeSuccessPage()));
                    dataCardRecharge();
                  },
                  child: Text(
                    "Recharge",
                    style: TextStyle(fontSize: 2.2 * SizeConfig.textMultiplier),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future dataCardRecharge() async {
    if (selected == null) {
      setState(() {
        operatorValidate = "Please select the operator";
        _isValidate = true;
      });
    } else {
      setState(() {
        operatorValidate = null;
        _isValidate = false;
      });
    }

    if (accountNumberController.text.isEmpty) {
      setState(() {
        accountNumberValidate = "Please enter the id or number";
        _isValidate = true;
      });
    } else {
      setState(() {
        accountNumberValidate = null;
        _isValidate = false;
      });
    }

    if (payController.text.isEmpty) {
      setState(() {
        payValidate = "Please enter the amount";
        _isValidate = true;
      });
    } else {
      setState(() {
        payValidate = null;
        _isValidate = false;
      });
    }

    if (_isValidate == false) {
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
        "billPay": true
      };
      var firstJson = responsed;
      var secondJson = data;

      var dataCardJson = {...firstJson, ...secondJson};
      (dataCardJson['requiredParams'] as List<dynamic>).forEach((item) {
        item['value'] = accountNumberController.text;
      });
      dataCardJson['transactionAmount'] = int.parse(payController.text);
      print(dataCardJson);

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
          // if (responseData['errorExist'] == false) {

          // }
          // else {
          Fluttertoast.showToast(
              msg: "${responsedData['message']}",
              textColor: Apptheme.whitetextcolor,
              backgroundColor: Colors.green);
          print(responsedData);
          Navigator.pop(context);

          // }
        } else {
          print(response.statusCode);
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "${responsedData['message']}",
              textColor: Apptheme.whitetextcolor,
              backgroundColor: Apptheme.textColo1r);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
