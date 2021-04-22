import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/HomePage/banners.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                height: 280,
                color: Apptheme.PrimaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 12,
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
                                fontSize: 24),
                            children: [
                              TextSpan(
                                style: TextStyle(
                                    fontFamily: 'Orelega One',
                                    color: Apptheme.whitetextcolor),
                                text: "Instant",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'Orelega One',
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
                                    color: Colors.white, fontSize: 14),
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Text("Total Balance",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Apptheme.whitetextcolor))),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "₹ 10000",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Apptheme.whitetextcolor),
                                )),
                            SizedBox(
                              height: 8,
                            ),
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
