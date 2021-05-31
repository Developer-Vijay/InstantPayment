import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/HomePage/banners.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

    Future.delayed(Duration.zero, () {
      getWalletDetails();
    });
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

  Future getWalletDetails() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => Container(
          color: Apptheme.PrimaryColor,
          child: Center(
            child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200))),
          )),
    );

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
        setState(() {
          walletAmount = responseData['walletAmount'];
          prefs.setInt("amount", walletAmount);
          status = true;
        });
        print(responseData['walletAmount']);
        print("??????");
        print("2222");
        Navigator.pop(context);
      } else {
        print("error");
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      prefs.setBool("walletStatus", false);
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
                            // Container(
                            //     margin: EdgeInsets.only(
                            //       left: 2.4 * SizeConfig.widthMultiplier,
                            //     ),
                            //     child: Text("Total Balance",
                            //         style: TextStyle(
                            //             fontSize: 3 * SizeConfig.textMultiplier,
                            //             fontWeight: FontWeight.w800,
                            //             color: Apptheme.whitetextcolor))),
                            SizedBox(
                              height: 2.1 * SizeConfig.heightMultiplier,
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: walletAmount != null
                                    ? RichText(
                                        text: TextSpan(
                                        style: TextStyle(
                                            color: Apptheme.PrimaryColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                5 * SizeConfig.textMultiplier),
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                fontFamily: 'arvo',
                                                color: Apptheme.whitetextcolor),
                                            text: "₹",
                                          ),
                                          TextSpan(
                                              style: TextStyle(
                                                  fontFamily: 'arvo',
                                                  color:
                                                      Apptheme.whitetextcolor),
                                              text: " $walletAmount.00"),
                                        ],
                                      ))
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
