import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDthOperator extends StatefulWidget {
  @override
  _SelectDthOperatorState createState() => _SelectDthOperatorState();
}

class _SelectDthOperatorState extends State<SelectDthOperator> {
  TextEditingController operatorController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool _isValidate = false;
  var operatorValidate;
  var numberValidate;
  var amountValidate;
  String dropdownValue = 'Operator';
  String operatorName;
  String operatorId;

  @override
  void initState() {
    super.initState();
  }

// variable inializer
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
// Dth Operator Api

  getDthOperatorList() async {
    return dthMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshtoken = logindata['refreshToken'];
      loginId = logindata['user']['_id'];
      print(refreshtoken);
      try {
        var response = await http.get(
            Uri.parse(ADMIN_API +
                '/getOperatorList' +
                '?operatorType=DTH&subdomain=instantpay'),
            headers: {
              'Content-type': 'application/json',
              'authorization': sessionToken,
              'refreshToken': refreshtoken
            });
        responseData = jsonDecode(response.body);
        jsonResponse = response.body;
        if (response.statusCode == 200) {
          return responseData;
        } else {
          print("error in dth");
        }
      } catch (e) {
        print(e);
      }
    });
  }

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
        print("fetched");
      } else {
        print("not Fetched");
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
          title: Text("DTH"),
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
                  child: FutureBuilder(
                      future: this.getDthOperatorList(),
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
                              decoration:
                                  InputDecoration(errorText: operatorValidate),
                              isDense: false,
                              isExpanded: true,
                              hint: Text("Select an Operator"),
                              value: selected,
                              items: [],
                              onChanged: (value) {});
                        }
                      })),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: numberController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: numberValidate,
                        counterText: "",
                        labelText: "Registered Mobile Number"),
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: amountValidate, labelText: "Amounts"),
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
                    dthrecharge();
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

  show() {
    Map data = {
      "performedBy": loginId,
      "operatorName": operatorName,
      "serviceName": "Recharge",
      "billPay": true
    };
    var firstJson = responsed;
    var secondJson = data;

    var dthJson = {...firstJson, ...secondJson};

    (dthJson['requiredParams'] as List<dynamic>).forEach((item) {
      item['value'] = numberController.text;
    });
    dthJson['transactionAmount'] = int.parse(amountController.text);
    print(jsonEncode(dthJson));
  }

  Future dthrecharge() async {
    if (selected == null) {
      setState(() {
        operatorValidate = "it cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        operatorValidate = null;
        _isValidate = false;
      });
    }
    if (numberController.text.isEmpty) {
      setState(() {
        numberValidate = "it cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
        _isValidate = false;
      });
    }
    if (amountController.text.isEmpty) {
      setState(() {
        amountValidate = "it cannot be empty";
        _isValidate = true;
      });
    } else {
      setState(() {
        amountValidate = null;
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

      var dthJson = {...firstJson, ...secondJson};

      (dthJson['requiredParams'] as List<dynamic>).forEach((item) {
        item['value'] = numberController.text;
      });
      dthJson['transactionAmount'] = int.parse(amountController.text);
      print(dthJson);

      var dthJsonBody = jsonEncode(dthJson);
      try {
        var response = await http.post(Uri.parse(SERVICE_API + '/getRecharge'),
            body: dthJsonBody,
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken,
              "refreshToken": refreshtoken
            });
        var responsedData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "${responsedData['message']}",
              textColor: Apptheme.whitetextcolor,
              backgroundColor: Colors.green);
          Navigator.pop(context);
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
