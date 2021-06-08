import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:http/http.dart' as http;
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddBalancePage extends StatefulWidget {
  @override
  _AddBalancePageState createState() => _AddBalancePageState();
}

class _AddBalancePageState extends State<AddBalancePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController transferController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController bankReferenceIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var amountValidate;
  var transferValidate;
  var banknameValidate;
  var remarksValidate;
  var bankIdValidate;
  var dateValidate;
  var bankData;
  var bankName;
  var bankId;
  int selected;
  bool checker = false;
  bool checker2 = false;
  var data;

  bool isValidate = false;
  DateTime selectedDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String dropdownValue = "Select Transfer Type";

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No Image is Selected");
    }
    Navigator.pop(context);
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No Image is Selected");
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getbankDetails();
    });
  }

  List transfer = ["Cash Deposit", "NEFT", "RTGS", "IMPS", "Fund Transfer"];

  getbankDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var retrieveLogin = prefs.getString('loginInfo');
    var logindata = jsonDecode(retrieveLogin);
    var sessionToken = logindata['sessionToken'];
    var refreshToken = logindata['refreshToken'];

    var response = await http
        .get(Uri.parse(ADMIN_API + '/getBankList' + '?active=true'), headers: {
      "Content-type": "application/json",
      "authorization": sessionToken,
      "refreshToken": refreshToken
    });
    bankData = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {}
  }

  int selected1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Request"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: amountValidate,
                    labelText: "Enter Requested Amount"),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: bankReferenceIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: bankIdValidate, labelText: "Bank RefernceId"),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onTap: () {
                  _selectDate(context);
                  dateController.text = selectedDate.toString();
                },
                controller: dateController,
                keyboardType: null,
                decoration: InputDecoration(
                    errorText: dateValidate, labelText: "Payment Date"),
              ),
            ),
            SizedBox(
              height: 3.5 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(errorText: transferValidate),
                  isDense: false,
                  isExpanded: true,
                  hint: Text("Select Transfer Type"),
                  value: selected1,
                  items: List.generate(
                    transfer.length,
                    (index) => DropdownMenuItem(
                        value: index, child: Text(transfer[index])),
                  ),
                  onChanged: (value) {
                    int index = value;
                    setState(() {
                      selected1 = index;
                    });
                  }),
            ),
            SizedBox(
              height: 4 * SizeConfig.heightMultiplier,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: bankData != null
                    ? DropdownButtonFormField(
                        decoration:
                            InputDecoration(errorText: banknameValidate),
                        isDense: false,
                        isExpanded: true,
                        hint: Text("Select an Bank"),
                        value: selected,
                        items: List.generate(
                          bankData.length,
                          (index) => DropdownMenuItem(
                              value: index,
                              child: Text(bankData['bankList'][index]['name'])),
                        ),
                        onChanged: (value) {
                          int index = value;
                          setState(() {
                            selected = index;
                            bankId = bankData['bankList'][index]['_id'];
                            bankName = bankData['bankList'][index]['name'];
                          });
                        })
                    : DropdownButtonFormField(
                        items: [],
                        onChanged: (value) {},
                        isDense: false,
                        hint: Text("Select an Bank"),
                        isExpanded: true,
                      )),
            SizedBox(
              height: 3.2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: remarksController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: remarksValidate, labelText: "Remarks"),
              ),
            ),
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 12 * SizeConfig.heightMultiplier,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 19 * SizeConfig.heightMultiplier,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    getImage();
                                  },
                                  child: Icon(Icons.camera),
                                ),
                                Divider(),
                                MaterialButton(
                                    onPressed: () {
                                      getImageFromGallery();
                                    },
                                    child: Icon(Icons.photo_album)),
                                Divider()
                              ],
                            ),
                          );
                        },
                      );
                      // getImage();
                    },
                    child: _image == null
                        ? Row(
                            children: [
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Icon(
                                Icons.add,
                                color: Apptheme.textColo1r,
                              ),
                              SizedBox(
                                width: 2 * SizeConfig.widthMultiplier,
                              ),
                              Text("Add Bank Statement by Tapping on it")
                            ],
                          )
                        : Container(
                            child: Center(
                                child: Text(
                              "Bank Statement  is addeed",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )),
                          )),
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      cancel();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    color: Apptheme.textColo1r,
                    textColor: Apptheme.whitetextcolor,
                    child: Text("Cancel"),
                  ),
                  SizedBox(
                    width: 4 * SizeConfig.widthMultiplier,
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    onPressed: () {
                      // show();
                      request();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("Request"),
                    textColor: Apptheme.whitetextcolor,
                    color: Apptheme.PrimaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future cancel() async {
    setState(() {
      amountController.clear();
      bankReferenceIdController.clear();
      dateController.clear();
      transferController.clear();
      banknameController.clear();
      remarksController.clear();
    });
  }

  Future request() async {
    if (amountController.text.isEmpty) {
      setState(() {
        amountValidate = "amount is needed";
        isValidate = true;
      });
    } else {
      setState(() {
        amountValidate = null;
        isValidate = false;
      });
    }

    if (dateController.text.isEmpty) {
      setState(() {
        dateValidate = "Payment date is needed";
        isValidate = true;
      });
    } else {
      setState(() {
        dateValidate = null;
        isValidate = false;
      });
    }
//upload

    if (_image == null) {
      Fluttertoast.showToast(msg: "Please select profile photo");
      setState(() {
        isValidate = true;
      });
    } else {
      setState(() {
        isValidate = false;
      });
    }

    if (selected1 == null) {
      setState(() {
        transferValidate = "Transfer type is needed";
        isValidate = true;
      });
    } else {
      setState(() {
        transferValidate = null;
        isValidate = false;
      });
    }

    if (selected == null) {
      setState(() {
        banknameValidate = "Bank need to be Select";
        isValidate = true;
      });
    } else {
      setState(() {
        banknameValidate = null;
        isValidate = false;
      });
    }

    if (isValidate == false && _image != null && selected1 != null) {
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

      final prefs = await SharedPreferences.getInstance();
      var retrieveLogin = prefs.getString('loginInfo');
      var logindata = jsonDecode(retrieveLogin);
      var sessionToken = logindata['sessionToken'];
      var refreshToken = logindata['refreshToken'];
      var loginId = logindata['user']['_id'];
      Map<String, String> headers = {
        "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
        "authorization": sessionToken,
        "refreshToken": refreshToken
      };
      Map jsonData = {
        "amount": int.parse(amountController.text),
        "requestedBy": loginId,
        "requestedReason": remarksController.text,
        "subdomain": "instantpay",
        "bankId": bankId,
        "bankReceipt": {"path": null, "originalName": null},
        "transferType": transferController.text,
        "bankReferenceId": bankReferenceIdController.text,
        "depositedDate": dateController.text,
        "isClient": false,
        "requestedTo": "5f51290ecc7cf4ca51f0617f"
      };

      // FormData formData =FormData();
      try {
        var encodedBody = jsonEncode(jsonData);

        var uri = Uri.parse(PORTAL_API + '/paymentRequest');
        var request = http.MultipartRequest(
          'POST',
          uri,
        );
        request.headers.addAll(headers);
        request.headers['authorization'] = sessionToken;
        // request.headers['Content-type'] = 'application/json';

        request.files.add(await http.MultipartFile.fromPath(
          'file',
          _image.path,
        ));
        request.fields['jsonData'] = encodedBody;

        var response = await request.send();
        final res = await http.Response.fromStream(response);
        var decodedData = jsonDecode(res.body);
        if (response.statusCode == 200) {
          setState(() {
            _image = null;
            data = decodedData['data'];
          });
          Fluttertoast.showToast(msg: "${decodedData['message']}");
          Navigator.pop(context);
          cancel();
        } else if (response.statusCode == 413) {
          // setState(() {
          //   _image = null;
          // });
          Fluttertoast.showToast(msg: "File size is too Large");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "${decodedData['message']}");
          Navigator.pop(context);
        }
      } catch (e) {}
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        helpText: "Select  Date",
        confirmText: "Confirm");
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
