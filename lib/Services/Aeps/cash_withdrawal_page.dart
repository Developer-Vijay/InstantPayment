import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Aeps/finger_print_page.dart';

class CashWithDrawPage extends StatefulWidget {
  @override
  _CashWithDrawPageState createState() => _CashWithDrawPageState();
}

class _CashWithDrawPageState extends State<CashWithDrawPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController aadharNumberController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  var phoneNumberValidate;
  var aafharNumbervalidate;
  var bankValidate;
  var amountValidate;

  bool isValidate = false;

  String dropdownValue = "Select Bank";
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 2 * SizeConfig.heightMultiplier,
        ),
        // Phone Number
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: phoneNumberController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: phoneNumberValidate,
                counterText: "",
                labelText: "Phone Number"),
          ),
        ),
        SizedBox(
          height: 2 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: aadharNumberController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: aafharNumbervalidate,
                counterText: "",
                labelText: "Aadhar Number"),
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
                hintText: dropdownValue,
                errorText: bankValidate,
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
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: TextField(
            controller: aadharNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                errorText: aafharNumbervalidate,
                counterText: "",
                labelText: "Amount"),
          ),
        ),
        SizedBox(
          height: 2 * SizeConfig.heightMultiplier,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 46 * SizeConfig.widthMultiplier,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Apptheme.PrimaryColor,
                  textColor: Apptheme.whitetextcolor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FingerPrintPage()));
                  },
                  child: Text("Withdrawal"),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 46 * SizeConfig.widthMultiplier,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Apptheme.PrimaryColor,
                  textColor: Apptheme.whitetextcolor,
                  onPressed: () {},
                  child: Text("Reset"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
