import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';

class DataCardPage extends StatefulWidget {
  @override
  _DataCardPageState createState() => _DataCardPageState();
}

class _DataCardPageState extends State<DataCardPage> {
  String dropdownValue = 'Operator';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintText: dropdownValue,
                    hintStyle: TextStyle(fontWeight: FontWeight.w600),
                    suffixIcon: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 0) {
                          setState(() {
                            dropdownValue = "Airtel";
                          });
                        } else if (value == 1) {
                          setState(() {
                            dropdownValue = "Jio";
                          });
                        } else if (value == 2) {
                          setState(() {
                            dropdownValue = "Lava";
                          });
                        } else if (value == 3) {
                          setState(() {
                            dropdownValue = "D-Link";
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Airtel"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Jio"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Lava"),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("D-Link"),
                          value: 3,
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "", labelText: "Account No."),
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                   
                      labelText: "Pay"),
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
                onPressed: () {},
                child: Text(
                  "Recharge",
                  style: TextStyle(fontSize: 2.2 * SizeConfig.textMultiplier),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
