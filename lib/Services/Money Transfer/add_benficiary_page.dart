import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Services/Money%20Transfer/add_beneficiary.dart';
import 'package:netly/components/Resources/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

// ignore: must_be_immutable
class BenificaryPage extends StatefulWidget {
  TabController controller;
  var data;
  int selectedIndex;
  var limit;
  var spent;
  final bankData;
  BenificaryPage(
      {this.controller,
      this.selectedIndex,
      this.data,
      this.bankData,
      this.limit,
      this.spent});
  @override
  _BenificaryPageState createState() => _BenificaryPageState();
}

bool checker = false;
int counter = 0;

class _BenificaryPageState extends State<BenificaryPage> {
  @override
  void initState() {
    super.initState();
    getUserData();
    // WidgetsBinding.instance.addPostFrameCallback((_) => );
    Future.delayed(Duration.zero, () {
      getBankList();
    });

    print("**********");

    setState(() {
      number = widget.data;
    });
  }

  String bankdata = "";
  var serverResponse;
  var done;
  var responseData;
  var bankValidate;
  var number;
  var acccountValidate;
  var nameValidate;
  var codeValidate;
  int selected;
  int bankId;
  String bankName;
  String ifscCode = "";
  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;
  int j;
  String bankNamed;

  getUserData() async {
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

  var data;
  final List<DropdownMenuItem> items = [];
  List data1 = [];
  getBankList() async {
    var response = await http.get(SERVICE_API + '/getBankList', headers: {
      "Content-type": "application/json",
      "authorization": sessionToken,
      "refreshToken": refreshToken
    });
    responseData = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        print("////////");
        setState(() {
          j = responseData['bankList'].length;

          // data = responseData['bankList'];
        });
        print(responseData);
        bankIfscList = [];
        print(ifscCode);
        for (int i = 0; i <= j - 1; i++) {
          bankIfscList.add(BankList(
              bankName: " ${responseData['bankList'][i]['bankName']}",
              ifscCode: responseData['bankList'][i]['ifscCode'],
              index: i));
          bankdata = "$bankdata-${responseData['bankList'][i]['bankName']}-";
          isfcData = "$isfcData-${responseData['bankList'][i]['ifscCode']}-";
        }
        print(bankdata);
        print(isfcData);
        String wordPair = "";
        bankdata.split("-").forEach((word) {
          if (wordPair.isEmpty) {
            wordPair = word + " ";
          } else {
            wordPair += word;
            if (items.indexWhere((item) {
                  return (item.value == wordPair);
                }) ==
                -1) {
              items.add(DropdownMenuItem(
                child: Text(wordPair),
                value: wordPair,
              ));
            }
            wordPair = "";
          }
        });
        print("//////////");
      } else {
        print(response.statusCode);
        print("...............");
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController banknameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  String dropdownValue = 'select Bank Name';
  String isfcData = "";
  bool isValidate = false;

  List<String> searchedlist = ['s', 'b'];
  // search(index) {
  //   final list = responseData['bankList'][index]['bankName']
  //       .where((p) => p.startsWith(responseData['bankList']['name']))
  //       .toList();
  // }
  List<DropdownMenuItem> unis = [];
  List<BankList> bankIfscList = [];
  @override
  Widget build(BuildContext context) {
    // codeController.text = ifscCode;
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
                              height: 5 * SizeConfig.heightMultiplier,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.1 * SizeConfig.heightMultiplier,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Monthly Limit:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 2.1 * SizeConfig.widthMultiplier,
                                      ),
                                      Text("${widget.limit}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      Spacer(),
                                      Text("Spent:",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 2.1 * SizeConfig.widthMultiplier,
                                      ),
                                      Text("${widget.spent}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            );
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
                padding: const EdgeInsets.all(8),
                child: j == null
                    ? DropdownButtonFormField(
                        isDense: false,
                        isExpanded: true,
                        hint: Text("Select an Bank"),
                        items: [],
                        onChanged: (value) {},
                      )
                    : SearchableDropdown.single(
                        isExpanded: true,

                        // label: Text("Bank Name"),
                        hint: Text("Select a bank"),
                        onChanged: (value) {
                          setState(() {
                            data = value;
                            print(bankIfscList[5].bankName);

                            print("???????");
                          });
                          int k = bankIfscList.length;
                          for (int i = 0; i <= k - 1; i++) {
                            print(i);
                            print(bankIfscList[i].bankName);
                            print("***************");
                            // print(data.replaceAll(' ', ''));
                            if (data == null) {
                              print("Null");
                            } else if (bankIfscList[i]
                                    .bankName
                                    .replaceAll(' ', '') ==
                                data.replaceAll(' ', '')) {
                              print("matched");
                              setState(() {
                                bankNamed = bankIfscList[i].bankName;
                                ifscCode = bankIfscList[i].ifscCode;
                                codeController.text = bankIfscList[i].ifscCode;
                                print(codeController.text);
                              });
                            } else {
                              print(" not matched");
                            }
                          }
                        },
                        items: items)),

            SizedBox(
              height: 0 * SizeConfig.heightMultiplier,
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
                enableSuggestions: false,
                // readOnly: true,
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
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 40 * SizeConfig.widthMultiplier,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                    width: 40 * SizeConfig.widthMultiplier,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Apptheme.PrimaryColor,
                      textColor: Apptheme.whitetextcolor,
                      onPressed: () {
                        addBene();

                        // await getBeneList(context);
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

  addBene() async {
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

    if (data == null) {
      setState(() {
        // bankValidate = 'It cannot be empty';
        Fluttertoast.showToast(msg: "Please Select a bank First");
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

    if (isValidate == false && data != null) {
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
      Map addData = {
        "bankName": bankNamed,
        "IFSCCode": codeController.text,
        "accountNumber": accountController.text,
        "beneficiaryName": nameController.text,
        "mobileNumber": number,
        "selectRecipientCall": false,
        "performedBy": loginId
      };
      var encodedDetail = jsonEncode(addData);
      print(encodedDetail);
      var response = await http.post(SERVICE_API + '/addBeneficiary',
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          },
          body: encodedDetail);
      var responsedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: responsedData['message']);
        // setState(() {
        //   done = responsedData;
        // });
        getBeneList(context);
        // if ( serverResponse != null) {
        //   // setState(() {
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //       builder: (context) => AddBeneficiary(
        //     //         data: number,
        //     //         limit: widget.limit,
        //     //         responseData: serverResponse,
        //     //         spent: widget.spent,
        //     //       ),
        //     //     ));
        //   // });
        // }
        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
        Navigator.pop(context);
      }
    }
  }

  // Login Api

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
        SERVICE_API + '/getBeneficiary' + '?mobileNumber=$number',
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        });
    responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("/////");
      print(responseData);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBeneficiary(
              data: number,
              limit: widget.limit,
              responseData: responseData,
              spent: widget.spent,
            ),
          ));

      named.clear();

      for (int i = 0; i <= responseData['beneficiaryList'].length - 1; i++) {
        named.add(
          Name(
              name: responseData['beneficiaryList'][i]['name'],
              accountnumber: responseData['beneficiaryList'][i]
                  ['account_number'],
              bankname: responseData['beneficiaryList'][i]['bank_name'],
              beneId: responseData['beneficiaryList'][i]['beneId'],
              ifscCodes: responseData['beneficiaryList'][i]['ifsc'],
              mobileNumber: responseData['beneficiaryList'][i]
                  ['customer_number']),
        );
      }
      setState(() {
        checker = true;
      });
    } else {
      setState(() {
        // allowNavigation = false;
        Navigator.pop(context);
      });
      print(response.statusCode);
    }
  }

// verify bene
  verifyBene() async {
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

    if (data == null) {
      setState(() {
        // bankValidate = 'It cannot be empty';
        Fluttertoast.showToast(msg: "Please Select a bank First");
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
    if (isValidate == false && data != null) {
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
      Map addData = {
        "bankName": bankNamed,
        "IFSCCode": codeController.text,
        "accountNumber": accountController.text,
        "beneficiaryName": nameController.text,
        "mobileNumber": number,
        "selectRecipientCall": false,
        "performedBy": loginId
      };
      var encodedDetail = jsonEncode(addData);
      print(encodedDetail);
      var response = await http.post(SERVICE_API + '/verifyBeneficiary',
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          },
          body: encodedDetail);
      var responsedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (responsedData['errorExist'] == true) {
          Fluttertoast.showToast(
              msg: responsedData['message'],
              backgroundColor: Apptheme.textColo1r,
              textColor: Apptheme.whitetextcolor);
          print(responsedData);
        } else {
          Fluttertoast.showToast(
              msg: responsedData['message'],
              backgroundColor: Colors.green,
              textColor: Apptheme.whitetextcolor);
          setState(() {
            nameController.text = responsedData['beneficiaryName'];
          });
        }

        // widget.controller.animateTo(widget.selectedIndex = 0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: responseData['message']);
        print(responsedData);
        Navigator.pop(context);
      }
    }
  }
}
