import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_beneficiary.dart';

// ignore: must_be_immutable
class LoginUser extends StatefulWidget {
  TabController controller;
  int selectedindex;
  LoginUser({this.controller, this.selectedindex});
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  @override
  void initState() {
    super.initState();
    getuserData();
  }

  TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var firstNameValidate;
  var lastNameValidate;
  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;
  var otpValidate;
  var responseData;
  var serverResponse;
  bool show = false;
  var numberValidate;
  bool isValidate = false;
  var currentDate = DateTime.now();
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

  bool isOtp = false;
  otpVerified() async {
    if (otpController.text.isEmpty) {
      setState(() {
        otpValidate = "enter the otp first before submitting";
        isOtp = true;
      });
    } else {
      setState(() {
        otpValidate = null;
        isOtp = false;
      });
    }
    if (isOtp == false) {
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
      Map otpData = {
        "otp": otpController.text,
        "mobileNumber": numberController.text,
        "beneId": loginId,
      };
      var encodedData = jsonEncode(otpData);
      var response =
          await http.post(SERVICE_API + '/remitterVerificationWithOTP',
              headers: {
                "Content-type": "application/json",
                "authorization": sessionToken,
                "refreshToken": refreshToken
              },
              body: encodedData);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['errorExist'] == true) {
          Fluttertoast.showToast(msg: responseData['message']);
          Navigator.pop(context);
        } else {
          setState(() {
            Fluttertoast.showToast(msg: responseData['message']);
            show = false;
          });
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Money Transfer"),
        ),
        body: ListView(
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
                onChanged: (value) {
                  getBeneList(context);
                },
                decoration: InputDecoration(
                    errorText: numberValidate,
                    counterText: "",
                    labelText: "Please enter registered mobile number"),
              ),
            ),
            SizedBox(
              height: 4 * SizeConfig.heightMultiplier,
            ),

            Container(
              child: show == false
                  ? SizedBox()
                  : Padding(
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
            ),
            SizedBox(
              height: 4 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: show == false
                  ? SizedBox()
                  : TextField(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                height: 6 * SizeConfig.heightMultiplier,
                textColor: Apptheme.whitetextcolor,
                color: Apptheme.PrimaryColor,
                onPressed: () {
                  show == false
                      ? Future.delayed(
                          Duration(
                            milliseconds: 800,
                          ), () {
                          loginuser();
                        })
                      : addUser();
                },
                child: show == true
                    ? Text("Add",
                        style: TextStyle(
                            fontSize: 2.1 * SizeConfig.textMultiplier))
                    : Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 2.1 * SizeConfig.textMultiplier),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onbackPressed() async {
    return showDialog(
        context: context,
        builder: (contex) => AlertDialog(
              title: Text("Do you Really want to exit The Otp Screen"),
              actions: [
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }

  Future addUser() async {
    if (numberController.text.isEmpty) {
      setState(() {
        numberValidate = "Phone number cannot be empty";
        isValidate = true;
      });
    } else {
      setState(() {
        numberValidate = null;
        isValidate = false;
      });
    }

    if (firstNameController.text.isEmpty) {
      setState(() {
        firstNameValidate = "First name cannot be empty";
        isValidate = true;
      });
    } else {
      setState(() {
        firstNameValidate = null;
        isValidate = false;
      });
    }

    if (lastNameController.text.isEmpty) {
      setState(() {
        lastNameValidate = "last name cannot be empty";
        isValidate = true;
      });
    } else {
      setState(() {
        lastNameValidate = null;
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
      Map registerData = {
        "createdOn": currentDate.toString(),
        "updatedOn": currentDate.toString(),
        "mobileNumber": numberController.text,
        "createdBy": loginId,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text
      };
      var encodeData = jsonEncode(registerData);
      print(encodeData);
      var response = await http.post(SERVICE_API + '/remitterRegistration',
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          },
          body: encodeData);
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responseData['errorExist'] == true) {
          Fluttertoast.showToast(msg: responseData['message']);
          Navigator.pop(context);
        } else {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => WillPopScope(
              onWillPop: _onbackPressed,
              child: AlertDialog(
                content: Container(
                  height: 25 * SizeConfig.heightMultiplier,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.4 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "Please Enter The Otp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.4 * SizeConfig.heightMultiplier,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: TextField(
                          controller: otpController,
                          maxLength: 4,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              errorText: numberValidate,
                              counterText: "",
                              labelText: "OTP"),
                        ),
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Apptheme.PrimaryColor,
                        textColor: Apptheme.whitetextcolor,
                        onPressed: () {
                          otpVerified();
                        },
                        minWidth: 26 * SizeConfig.widthMultiplier,
                        child: Text(
                          "Submit",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          Fluttertoast.showToast(msg: responseData['message']);
          print(responseData);
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future loginuser() async {
    if (numberController.text.isEmpty) {
      setState(() {
        numberValidate = "please enter the phone number";
        isValidate = true;
      });
    } else if (numberController.text.length < 10) {
      setState(() {
        numberValidate = "please enter the 10 digit Mobile Number";
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
        "createdOn": currentDate.toString(),
        "updatedOn": currentDate.toString(),
        "mobileNumber": numberController.text,
        "createdBy": loginId
      };
      var encodeddata = jsonEncode(data);
      var response = await http.post(SERVICE_API + '/mobileVerification',
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          },
          body: encodeddata);
      var jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (jsonData['needOTPverification'] == true) {
          Navigator.pop(context);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => WillPopScope(
              onWillPop: _onbackPressed,
              child: AlertDialog(
                content: Container(
                  height: 25 * SizeConfig.heightMultiplier,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.4 * SizeConfig.heightMultiplier,
                      ),
                      Text(
                        "Please Enter The Otp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.4 * SizeConfig.heightMultiplier,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: TextField(
                          controller: otpController,
                          maxLength: 4,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              errorText: otpValidate,
                              counterText: "",
                              labelText: "OTP"),
                        ),
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Apptheme.PrimaryColor,
                        textColor: Apptheme.whitetextcolor,
                        onPressed: () {
                          otpVerified();
                        },
                        minWidth: 26 * SizeConfig.widthMultiplier,
                        child: Text(
                          "Submit",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          setState(() {
            show = true;
          });
          print("1");
          Fluttertoast.showToast(msg: jsonData['message']);
        } else if (jsonData['errorExist'] == true) {
          Fluttertoast.showToast(msg: jsonData['message']);
          setState(() {
            show = true;
          });
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: jsonData['message']);
          print("2");
          numberController.clear();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddBeneficiary(
                  data: numberController.text,
                  responseData: serverResponse,
                  limit: jsonData['availAPICapacity']['monthlyLimit'],
                  spent: jsonData['availAPICapacity']['spentMoney'],
                ),
              ));
        }
      } else {
        print(response.statusCode);
        Navigator.pop(context);
        print(jsonData['message']);
      }
    }
  }

  int k;
  getBeneList(context) async {
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    refreshToken = logindata['refreshToken'];
    loginId = logindata['user']['_id'];
    print("?????????");
    print(loginId);
    print("?????????");
    var response = await http.get(
        SERVICE_API +
            '/getBeneficiary' +
            '?mobileNumber=${numberController.text}',
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        });
    responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("/////");
      print(responseData);

      setState(() {
        k = responseData['beneficiaryList'].length;

        serverResponse = responseData;
      });

      if (named.isEmpty) {
        for (int i = 0; i <= k - 1; i++) {
          named.add(
            Name(
                name: responseData['beneficiaryList'][i]['name'],
                accountnumber: responseData['beneficiaryList'][i]
                    ['account_number'],
                bankname: responseData['beneficiaryList'][i]['bank_name'],
                beneId: responseData['beneficiaryList'][i]['beneId'],
                ifscCode: responseData['beneficiaryList'][i]['isfc'],
                mobileNumber: responseData['beneficiaryList'][i]
                    ['customer_number']),
          );
        }
      }
      else if(numberController.text == named[0].mobileNumber){
        print("Yey");
      }
       else if (numberController.text != named[0].mobileNumber) {
      
       named.clear();
        
        for (int i = 0; i <= k - 1; i++) {
          named.add(
            Name(
                name: responseData['beneficiaryList'][i]['name'],
                accountnumber: responseData['beneficiaryList'][i]
                    ['account_number'],
                bankname: responseData['beneficiaryList'][i]['bank_name'],
                beneId: responseData['beneficiaryList'][i]['beneId'],
                ifscCode: responseData['beneficiaryList'][i]['isfc'],
                mobileNumber: responseData['beneficiaryList'][i]
                    ['customer_number']),
          );
        }
      } else {
        print("No Need");
      }
    } else {
      setState(() {
        // allowNavigation = false;
        Navigator.pop(context);
      });
      print(response.statusCode);
    }
  }
}
