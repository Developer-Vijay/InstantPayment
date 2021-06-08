import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/serviceslist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../rechargesuccesspage.dart';

class MobileRecharge extends StatefulWidget {
  @override
  _MobileRechargeState createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool _isValidate = false;
  var mobileNumberValidate;
  var operatorValidate;
  var amountValidate;

  int selectedradiotile;

  @override
  void initState() {
    super.initState();
    selectedradiotile = 0;
   
  }

  int selected;
  setSelectedradioTile(int value) {
    setState(() {
      selectedradiotile = value;
    });
  }

  String sessionToken;
  var logindata;
  var retrieveLogin;
  int k;
  var responsed;
  var jsonresponse;
  var operatorId;
  var operatorName;
  var responseData;
  var totalData;
  var data;
  var postPaidResponseData;
  bool showPostpaid = false;
  bool checker = false;
  bool checker2 = false;

// postpaid
  getPostpaidList() async {
    return postpaidMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();
      var retrieveLogin = prefs.getString('loginInfo');
      var loginData = jsonDecode(retrieveLogin);
      String session = loginData['sessionToken'];
      try {
        var response = await http.get(
            Uri.parse(ADMIN_API +
                '/getOperatorList' +
                '?operatorType=Postpaid&subdomain=instantpay'),
            headers: {
              "Content-type": "application/json",
              "authorization": session
            });
        postPaidResponseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          print(postPaidResponseData);
          setState(() {
            showPostpaid = true;
          });
          return postPaidResponseData;
        } else {
          Fluttertoast.showToast(msg: "Erroer");
        }
      } catch (e) {
        print(e);
      }
    });
  }

// prepaid
  getPrepaidList() async {
    return prepaidMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();

      retrieveLogin = prefs.getString('loginInfo');

      logindata = jsonDecode(retrieveLogin);

      sessionToken = logindata['sessionToken'];
      try {
        var response = await http.get(
            Uri.parse(ADMIN_API +
                '/getOperatorList' +
                '?operatorType=Prepaid&subdomain=instantpay'),
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken
            });
        responseData = jsonDecode(response.body);
        print("loading...");
        if (response.statusCode == 200) {
          print(responseData);
          return responseData;
        } else {
          print(response.statusCode);
          print("not fetched");
        }
      } catch (e) {
        print(e);
      }
    });
  }

  var operatorsId;
// operator details
  getOperartordetails(var id) async {
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    try {
      var response = await http.get(
          Uri.parse(SERVICE_API +
              '/getApiOperatorCode' +
              '?apiOperatorCodeId=$id&subdomain=instantpay'),
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken
          });
      responsed = jsonDecode(response.body);
      jsonresponse = (response.body);
      if (response.statusCode == 200) {
        setState(() {
          operatorsId = responsed['_id'];
        });

        print(jsonresponse);
      } else {
        Navigator.pop(context);
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
          title: Text("Mobile Recharge"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 2.6 * SizeConfig.heightMultiplier,
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 3),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: rechqarge.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: rechqarge[index].value,
                    groupValue: selectedradiotile,
                    onChanged: (value) {
                      if (value == 0) {
                        getPrepaidList();
                        setState(() {
                          showPostpaid = false;
                        });
                      } else if (value == 1) {
                        getPostpaidList();
                      } else {
                        Fluttertoast.showToast(msg: "Something went wrong");
                      }
                      setSelectedradioTile(value);
                    },
                    selected: true,
                    title: Text(
                      "${rechqarge[index].title}",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8)),
                    child: showPostpaid == false
                        ? FutureBuilder(
                            future: this.getPrepaidList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        errorText: operatorValidate),
                                    isDense: false,
                                    isExpanded: true,
                                    hint: Text("Select an Operator"),
                                    value: selected,
                                    items: List.generate(
                                      snapshot.data.length,
                                      (index) => DropdownMenuItem(
                                          value: index,
                                          child: Text(
                                              snapshot.data[index]['name'])),
                                    ),
                                    onChanged: (value) {
                                      int index = value;
                                      setState(() {
                                        selected = index;
                                        operatorId = snapshot.data[index]
                                            ['activeAPIOperatorCodeId'];
                                        print(operatorId);
                                        operatorName =
                                            snapshot.data[index]['name'];
                                        getOperartordetails(operatorId);
                                      });
                                    });
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonFormField(
                                    hint: Text("Select an Operator"),
                                    items: [],
                                    isDense: false,
                                    isExpanded: true,
                                    onChanged: (value) {},
                                  ),
                                );
                              }
                            })
                        : FutureBuilder(
                            future: this.getPostpaidList(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        errorText: operatorValidate),
                                    isDense: false,
                                    isExpanded: true,
                                    hint: Text("Select an Operator"),
                                    value: selected,
                                    items: List.generate(
                                      snapshot.data.length,
                                      (index) => DropdownMenuItem(
                                          value: index,
                                          child: Text(
                                              snapshot.data[index]['name'])),
                                    ),
                                    onChanged: (value) {
                                      int index = value;
                                      setState(() {
                                        selected = index;
                                        operatorId = snapshot.data[index]
                                            ['activeAPIOperatorCodeId'];
                                        print(operatorId);
                                        operatorName =
                                            snapshot.data[index]['name'];
                                        getOperartordetails(operatorId);
                                      });
                                    });
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButtonFormField(
                                    hint: Text("Select an Operator"),
                                    items: [],
                                    isDense: false,
                                    isExpanded: true,
                                    onChanged: (value) {},
                                  ),
                                );
                              }
                            })),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: mobilenumberController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: mobileNumberValidate,
                        contentPadding: EdgeInsets.only(left: 12),
                        counterText: "",
                        labelText: "Mobile Number"),
                  ),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: amountValidate,
                        contentPadding: EdgeInsets.only(left: 12),
                        labelText: "Amounts"),
                  ),
                ),
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  height: 7.5 * SizeConfig.heightMultiplier,
                  textColor: Apptheme.whitetextcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Apptheme.PrimaryColor,
                  onPressed: () {
                    recharge();
                  },
                  child: Text(
                    "Recharge",
                    style: TextStyle(
                        fontSize: 2.2 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  show() async {
    Map data = {
      "performed by": "1234528",
      "operatorName": operatorName,
      "ServiceName": "Recharge",
      "billPay": true
    };
    var firstJson = responsed;
    var secondJson = data;

    var json = {...firstJson, ...secondJson};
    (json['requiredParams'] as List<dynamic>).forEach((item) {
      item['value'] = mobilenumberController.text;
    });
    json['transactionAmount'] = int.parse(amountController.text);

    print(jsonEncode(json));
  }

  Future recharge() async {
    var loginid;
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    loginid = logindata['user']['_id'];
    if (selected == null) {
      setState(() {
        operatorValidate = "Please select the operator";
        _isValidate = true;
      });
    } else {
      operatorValidate = null;
      _isValidate = false;
    }

    if (mobilenumberController.text.isEmpty) {
      setState(() {
        mobileNumberValidate = "Please enter the mobilenumber";
        _isValidate = true;
      });
    } else {
      setState(() {
        mobileNumberValidate = null;
        _isValidate = false;
      });
    }

    if (amountController.text.isEmpty) {
      setState(() {
        amountValidate = "Please enter the amount";
        _isValidate = true;
      });
    } else {
      setState(() {
        amountValidate = null;
        _isValidate = false;
      });
    }
    Map data = {
      "performed by": loginid,
      "operatorName": operatorName,
      "ServiceName": "Recharge",
      "billPay": true
    };
    var firstJson = responsed;
    var secondJson = data;

    var jsonbody = {...firstJson, ...secondJson};

    (jsonbody['requiredParams'] as List<dynamic>).forEach((item) {
      item['value'] = mobilenumberController.text;
    });
    jsonbody['transactionAmount'] = int.parse(amountController.text);
    print("//////");
    print(jsonbody);
    print("//////");
    var responsebody = jsonEncode(jsonbody);
    print(responsebody);
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
      try {
        var response = await http.post(Uri.parse(SERVICE_API + '/getRecharge'),
            body: responsebody,
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken
            });
        var responsedData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          if (responsedData['errorExist'] == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RechargeSuccessPage(
                    responseData: responsedData,
                    amount: amountController.text,
                    number: mobilenumberController.text,
                    orderId: operatorsId,
                    date: DateTime.now(),
                  ),
                ));
            print(responsedData);
          } else {
            Fluttertoast.showToast(
                msg: "${responsedData['message']}",
                backgroundColor: Colors.green,
                toastLength: Toast.LENGTH_LONG,
                textColor: Apptheme.whitetextcolor);
            Navigator.pop(context);
          }
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "${responsedData['message']}",
              backgroundColor: Apptheme.textColo1r,
              toastLength: Toast.LENGTH_LONG,
              textColor: Apptheme.whitetextcolor);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
