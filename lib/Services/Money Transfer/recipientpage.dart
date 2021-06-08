import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Money%20Transfer/transfer_money.dart';
import 'package:netly/Services/serviceslist.dart';
import 'package:netly/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RecipientPage extends StatefulWidget {
  final data;
  final apiData;

  TabController controller;
  int selectedIndex;

  RecipientPage({this.controller, this.selectedIndex, this.data, this.apiData});

  @override
  _RecipientPageState createState() => _RecipientPageState();
}

class _RecipientPageState extends State<RecipientPage> {
  var number;
  bool show = false;
  TextEditingController searhed = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var otpValidate;
  @override
  void initState() {
    super.initState();
    getUserData();
    setState(() {
      number = widget.data;
      responseData = widget.apiData;
      filter = searhed.text;
    });
    print(widget.data);
  }

  @override
  void dispose() {
    super.dispose();
    searhed.dispose();
  }

  var responseData;
  var filter;

  Widget condition() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        if (searhed.text == null || searhed.text == "") {
          return data();
        } else if (searhed.text ==
            responseData['beneficiaryList'][index]['name']) {
          setState(() {});
          print("workibng");
          return _buildRow(index);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildRow(data1) {
    return ListTile(
      title: responseData['beneficiaryList'][data1]['name'],
    );
  }

  Widget data() {
    return ListView.builder(
      itemCount: responseData['beneficiaryList'].length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransferMoney(
                    bankname: responseData['beneficiaryList'][index]
                        ['bank_name'],
                    name: responseData['beneficiaryList'][index]['name'],
                    number: responseData['beneficiaryList'][index]
                        ['customer_number'],
                    accountNumber: responseData['beneficiaryList'][index]
                        ['account_number'],
                    ifscCode: responseData['beneficiaryList'][index]['ifsc'],
                    beneId: responseData['beneficiaryList'][index]['beneId'],
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        child: responseData['beneficiaryList'] == null
                            ? Text("Name in the Bank Account",
                                style: TextStyle(fontWeight: FontWeight.w500))
                            : Text(
                                "${responseData['beneficiaryList'][index]['name']}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        child: responseData['beneficiaryList'] == null
                            ? Text("Bank Name",
                                style: TextStyle(fontWeight: FontWeight.w500))
                            : Text(
                                "${responseData['beneficiaryList'][index]['bank_name']}"),
                      ),
                      Spacer(),
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete_outline,
                            color: Apptheme.textColo1r,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        child: responseData['beneficiaryList'] == null
                            ? Text("Bank Account Number",
                                style: TextStyle(fontWeight: FontWeight.w500))
                            : Text(
                                "${responseData['beneficiaryList'][index]['account_number']}"),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshToken = logindata['refreshToken'];
      loginId = logindata['user']['_id'];
    });
  }

  deleteBeneficiary(var id, var numbers) async {
    Map deletefields = {
      "otp": otpController.text,
      "beneficiaryId": "$id",
      "mobileNumber": "$numbers"
    };
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
    var data = jsonEncode(deletefields);
    print(data);
    var response = await http.post(SERVICE_API + '/requestToDeleteBeneficiary',
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        },
        body: data);
    var delete = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: delete['message']);
      print(delete);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: delete['message']);
    }
  }

  deleteRequest(var id, var numberss) async {
    Map deletefields = {"beneficiaryId": "$id", "mobileNumber": "$numberss"};
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
    var data = jsonEncode(deletefields);
    print(data);
    var response = await http.post(SERVICE_API + '/deleteBeneficiary',
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        },
        body: data);
    var requestDelete = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (requestDelete['needOTPverification'] == true) {
        Navigator.pop(context);
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
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
                      deleteBeneficiary(id, numberss);
                      print(id);
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
        );
      } else {}
      print(requestDelete);
      Fluttertoast.showToast(msg: requestDelete['message']);
      Navigator.pop(context);
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(msg: requestDelete['message']);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 3 * SizeConfig.heightMultiplier,
          ),
          InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: Searchbar(hintText: "Search"),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: SizeConfig.heightMultiplier * 7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all()),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: Apptheme.PrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.textMultiplier * 2.5),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.clear,
                          color: Apptheme.PrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier,
          ),
          Container(
            child: responseData == null
                ? Center(child: Text("Loading....."))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Name name = named[index];
                      return InkWell(
                        onTap: () {
                          print("hi");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransferMoney(
                                    bankname: name.bankname,
                                    name: name.name,
                                    number: name.mobileNumber,
                                    accountNumber: name.accountnumber,
                                    ifscCode: name.ifscCode,
                                    beneId: name.beneId),
                              ));
                        },
                        child: Column(
                          children: [
                            Divider(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      name.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(name.bankname),
                                  ),
                                  Spacer(),
                                 
                                  IconButton(
                                    onPressed: () {
                                      deleteRequest(named[index].beneId,
                                          named[index].mobileNumber);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    child:
                                        // responseData['beneficiaryList'] == null
                                        //     ? Text("Bank Account Number",
                                        //         style: TextStyle(fontWeight: FontWeight.w500))
                                        Text("${name.accountnumber}"),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1 * SizeConfig.heightMultiplier,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: named.length,
                  ),
          )
        ],
      ),
    );
  }
}

class Searchbar extends SearchDelegate<String> {
  Searchbar({
    String hintText,
  }) : super(
          keyboardType: TextInputType.name,
          searchFieldLabel: hintText,
        );
  List username = List.generate(named.length, (index) => named[index].name);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    print(username);
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = " ";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return Card(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final mylist = query.isEmpty
        ? named
        : named
            .where((p) => p.name.toString().toLowerCase().startsWith(query))
            .toList();

    return Container(
      child: mylist.isEmpty
          ? Center(
              child: Text(
              "No results Found",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                final Name name = mylist[index];
                return InkWell(
                  onTap: () {
                    print("hi");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferMoney(
                              bankname: name.bankname,
                              name: name.name,
                              number: name.mobileNumber,
                              accountNumber: name.accountnumber,
                              ifscCode: name.ifscCode,
                              beneId: name.beneId),
                        ));
                  },
                  child: Column(
                    children: [
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                name.name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check,
                              color: Colors.green[600],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Text(name.bankname),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TransferMoney(
                                            bankname: name.bankname,
                                            name: name.name,
                                            number: name.mobileNumber,
                                            accountNumber: name.accountnumber,
                                            ifscCode: name.ifscCode,
                                            beneId: name.beneId),
                                      ));
                                },
                                child: Icon(
                                  Icons.send_outlined,
                                  color: Apptheme.PrimaryColor,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child:
                                  // responseData['beneficiaryList'] == null
                                  //     ? Text("Bank Account Number",
                                  //         style: TextStyle(fontWeight: FontWeight.w500))
                                  Text("${name.accountnumber}"),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  banklist.remove(banklist[index]);
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Apptheme.textColo1r,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                    ],
                  ),
                );
              },
              itemCount: mylist.length,
            ),
    );
  }
}
