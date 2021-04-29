import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/HomePage/banners.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Homebar extends StatefulWidget {
  @override
  _HomebarState createState() => _HomebarState();
}

class _HomebarState extends State<Homebar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 38 * SizeConfig.heightMultiplier,
                color: Apptheme.PrimaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.6 * SizeConfig.heightMultiplier,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          RichText(
                              text: TextSpan(
                            style: TextStyle(
                                color: Apptheme.PrimaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 3.4 * SizeConfig.textMultiplier),
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    // fontFamily: 'Orelega One',
                                    color: Apptheme.whitetextcolor),
                                text: "Instant",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                      // fontFamily: 'Orelega One',
                                      color: Apptheme.whitetextcolor),
                                  text: "Payments"),
                            ],
                          )),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 14, top: 8),
                            child: Badge(
                              badgeColor: Colors.red,
                              showBadge: true,
                              padding: EdgeInsets.all(3),
                              badgeContent: Text(
                                "3",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 1.6 * SizeConfig.textMultiplier),
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: Apptheme.whitetextcolor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.5 * SizeConfig.heightMultiplier,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  left: 2.4 * SizeConfig.widthMultiplier,
                                ),
                                child: Text("Total Balance",
                                    style: TextStyle(
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w800,
                                        color: Apptheme.whitetextcolor))),
                            SizedBox(
                              height: 2.1 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "₹ 12000",
                                  style: TextStyle(
                                      fontFamily: 'arvo',
                                      fontSize: 3 * SizeConfig.textMultiplier,
                                      color: Apptheme.whitetextcolor),
                                )),
                            SizedBox(height: 2.1 * SizeConfig.heightMultiplier),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.white,
            )
          ],
        ),
        Align(alignment: Alignment.bottomCenter, child: Banners())
      ],
    );
  }
}
