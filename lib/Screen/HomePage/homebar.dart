import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/HomePage/banners.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:async/async.dart';

class Homebar extends StatefulWidget {
  final walletAmount;
  const Homebar({Key key, this.walletAmount}) : super(key: key);
  @override
  _HomebarState createState() => _HomebarState();
}

class _HomebarState extends State<Homebar> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // getWalletDetails();
  }

  var retrieveLogin;
  var sessionToken;
  var refreshToken;
  var loginId;
  var logindata;
  var responseData;
  var walletAmount;
  var amount;
  var status;
  List money = [];
  getWalletDetails() async {
    return walletMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshToken = logindata['refreshToken'];
      print(refreshToken);
      print(sessionToken);
      loginId = logindata['user']['_id'];
      status = prefs.getBool('walletStatus');
      print("?????????");
      print(loginId);
      print("?????????");

      try {
        var response = await http.get(
            Uri.parse(COMMON_API +
                '/getWalletAmount' +
                '?userId=$loginId&subdomain=instantpay'),
            headers: {
              "Content-type": "application/json",
              "authorization": sessionToken,
              "refreshToken": refreshToken
            });
        responseData = jsonDecode(response.body);
        if (response.statusCode == 200) {
          print(responseData['walletAmount']);

          walletMemorizer = AsyncMemoizer();
          print("??????");

          return responseData;
        } else {
          print("wallet error ${response.statusCode}");
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        prefs.setBool("walletStatus", false);
      });
    });
  }

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
                                    fontFamily: 'arvo',
                                    color: Apptheme.whitetextcolor),
                                text: "Instant",
                              ),
                              TextSpan(
                                  style: TextStyle(
                                      fontFamily: 'arvo',
                                      color: Apptheme.whitetextcolor),
                                  text: "Payments"),
                            ],
                          )),
                          Spacer(),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 14, top: 8),
                          //   child: Badge(
                          //     badgeColor: Colors.red,
                          //     showBadge: true,
                          //     padding: EdgeInsets.all(3),
                          //     badgeContent: Text(
                          //       "3",
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 1.6 * SizeConfig.textMultiplier),
                          //     ),
                          //     child: Icon(
                          //       Icons.notifications,
                          //       color: Apptheme.whitetextcolor,
                          //     ),
                          //   ),
                          // )
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
                            SizedBox(
                              height: 2.1 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 50 * SizeConfig.widthMultiplier,
                                margin: EdgeInsets.only(left: 10),
                                child: walletAmount == null
                                    ? FutureBuilder(
                                        future: getWalletDetails(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var money = snapshot
                                                .data['walletAmount']
                                                .toStringAsFixed(0);
                                            return Text(
                                              "₹$money",
                                              style: TextStyle(
                                                  color:
                                                      Apptheme.whitetextcolor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'arvo',
                                                  fontSize: 5 *
                                                      SizeConfig
                                                          .textMultiplier),
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          } else {
                                            return Text(
                                              "₹0.",
                                              style: TextStyle(
                                                  color:
                                                      Apptheme.whitetextcolor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'arvo',
                                                  fontSize: 5 *
                                                      SizeConfig
                                                          .textMultiplier),
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          }
                                        })
                                    : Text(
                                        "₹ 0",
                                        style: TextStyle(
                                            fontFamily: 'arvo',
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            color: Apptheme.whitetextcolor),
                                      )),
                            SizedBox(height: 1.4 * SizeConfig.heightMultiplier),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(alignment: Alignment.center, child: Banners())
      ],
    );
  }
}
