import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Dth/dthselect.dart';

class SelectDthOperator extends StatefulWidget {
  @override
  _SelectDthOperatorState createState() => _SelectDthOperatorState();
}

class _SelectDthOperatorState extends State<SelectDthOperator> {
  String dropdownValue = 'Operator';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            dropdownValue = "Tata Sky";
                          });
                        } else if (value == 1) {
                          setState(() {
                            dropdownValue = "Airtel Digital Tv";
                          });
                        } else if (value == 2) {
                          setState(() {
                            dropdownValue = "Dish Tv";
                          });
                        } else if (value == 3) {
                          setState(() {
                            dropdownValue = "D2H";
                          });
                        } else if (value == 4) {
                          setState(() {
                            dropdownValue = "Sun Direct";
                          });
                        }
                      },
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Tata sky"),
                          value: 0,
                        ),
                        PopupMenuItem(
                          child: Text("Airtel Digital Tv"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Dish Tv"),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("D2H"),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text("Sun Direct"),
                          value: 4,
                        )
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
                      counterText: "", labelText: "Registered Mobile Number"),
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
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "See all plans",
                            style: TextStyle(
                                fontSize: 2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 4 * SizeConfig.imageSizeMultiplier,
                          )
                        ],
                      ),
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
