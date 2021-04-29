import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/menulist.dart';

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

  bool isValidate = false;
  DateTime selectedDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String dropdownValue = "Select Transfer Type";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            height: 2 * SizeConfig.heightMultiplier,
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
                        // } else if (value == 1) {
                        //   setState(() {
                        //     transferController.text = "Airtel Digital Tv";
                        //   });
                        // } else if (value == 2) {
                        //   setState(() {
                        //     transferController.text = "Dish Tv";
                        //   });
                        // } else if (value == 3) {
                        //   setState(() {
                        //     transferController.text = "D2H";
                        //   });
                        // } else if (value == 4) {
                        //   setState(() {
                        //     transferController.text = "Sun Direct";
                        //   });
                      }
                    },
                    icon: Icon(Icons.arrow_drop_down),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("IMPS"),
                        value: 0,
                      ),
                      // PopupMenuItem(
                      //   child: Text("BSES"),
                      //   value: 1,
                      // ),
                      // PopupMenuItem(
                      //   child: Text("Dish Tv"),
                      //   value: 2,
                      // ),
                      // PopupMenuItem(
                      //   child: Text("D2H"),
                      //   value: 3,
                      // ),
                      // PopupMenuItem(
                      //   child: Text("Sun Direct"),
                      //   value: 4,
                      // )
                    ],
                  )),
            ),
          ),
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
                  labelText: "Select Bank",
                  // hintText: dropdownValue,
                  errorText: banknameValidate,
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
            height: 2 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 12 * SizeConfig.heightMultiplier,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: InkWell(
                onTap: () {},
                child: Row(
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
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
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
                    request();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: Text("Request"),
                  textColor: Apptheme.whitetextcolor,
                  color: Apptheme.PrimaryColor,
                )
              ],
            ),
          ),
        ],
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

    if (bankReferenceIdController.text.isEmpty) {
      setState(() {
        bankIdValidate = "Bank refrence Id is needed";
        isValidate = true;
      });
    } else {
      setState(() {
        bankIdValidate = null;
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
    // if (amountController.text.isEmpty) {
    //   setState(() {
    //     amountValidate = "amount is needed";
    //     isValidate = true;
    //   });
    // } else {
    //   setState(() {
    //     amountValidate = null;
    //     isValidate = false;
    //   });
    // }

    if (transferController.text.isEmpty) {
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

    if (banknameController.text.isEmpty) {
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

    if (isValidate == false) {
      Fluttertoast.showToast(msg: "Requested Successfully");
      addbalance.add(AddBalance(
          amount: amountController.text,
          bank: banknameController.text,
          date: dateController.text,
          id: bankReferenceIdController.text,
          transfer: transferController.text));
      cancel();
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2030),
        helpText: "Select  Date",
        confirmText: "Confirm");
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
