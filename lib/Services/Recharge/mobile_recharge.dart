import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Recharge/plans.dart';
import 'package:netly/Services/serviceslist.dart';

class MobileRecharge extends StatefulWidget {
  @override
  _MobileRechargeState createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  String dropdownValue = "Select Operator";
  int selectedradiotile;
  void initState() {
    super.initState();
    selectedradiotile = 0;
  }

  setSelectedradioTile(int value) {
    setState(() {
      selectedradiotile = value;
    });
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8)
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(20)
                      // )
                      ),
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(

                        // border: InputBorder.none,
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
                                dropdownValue = "Vodafone";
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
                              child: Text("Voda Phone"),
                              value: 2,
                            )
                          ],
                        )),
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
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.attach_money),
                        contentPadding: EdgeInsets.only(left: 12),
                        // border: InputBorder.none,
                        // suffix: InkWell(
                        //   // onTap: () {
                        //   //   showModalBottomSheet(
                        //   //     context: context,
                        //   //     isScrollControlled: true,
                        //   //     builder: (context) => Container(
                        //   //       height: 600,
                        //   //       child: MobilePlan()),
                        //   //   );
                        //   // },
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         "See all plans",
                        //         style: TextStyle(
                        //             fontSize: 2 * SizeConfig.textMultiplier,
                        //             fontWeight: FontWeight.bold),
                        //       ),
                        //       Icon(
                        //         Icons.arrow_forward_ios,
                        //         size: 4 * SizeConfig.imageSizeMultiplier,
                        //       )
                        //     ],
                        //   ),
                        // ),
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
                  onPressed: () {},
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
}
