import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/home_screen.dart';

class TransferMoney extends StatefulWidget {
  var bankname;
  var name;
  var number;
  TransferMoney({this.bankname, this.name, this.number});
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney> {
  TextEditingController transferController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String dropdownValue = "Mode of Transfer";
  final textstyle1 = TextStyle(fontSize: 1.6 * SizeConfig.textMultiplier);
  final textstyle2 = TextStyle(
      fontSize: 2 * SizeConfig.textMultiplier, fontWeight: FontWeight.w600);
  var amountValidate;
  var transferValidate;
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

  Future pay() async {
    if (amountController.text.isEmpty) {
      setState(() {
        amountValidate = "Please enter the amount";
        isValidate = true;
      });
    } else {
      setState(() {
        amountValidate = null;
        isValidate = false;
      });
    }

    if (transferController.text.isEmpty) {
      setState(() {
        transferValidate = "Please enter the amount";
        isValidate = true;
      });
    } else {
      setState(() {
        transferValidate = null;
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
                      Text("9745612345", style: textstyle1)
                    ],
                  ),
                  SizedBox(
                    height: 2.4 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Text("Bene Account No.", style: textstyle2),
                      Spacer(),
                      Text("${widget.number}", style: textstyle1)
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
              ),
            ],
          );
        },
      );
    }
  }
}
