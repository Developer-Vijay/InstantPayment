import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:netly/Components/Auth/login.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/HomePage/home_page.dart';
import 'package:netly/Screen/ProfilePage/profile_list.dart';
import 'package:netly/Screen/ReportPage/ReportPageMain/report_page_main.dart';
import 'package:netly/SetPassword/change_password.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final walletAmount;
  const HomeScreen({Key key, this.walletAmount}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var passcode;

  var data;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this.screenlock(context);
    });
    checkDateAndTime();
    data = widget.walletAmount;
  }

  var getDate = DateTime.now();
  var loginDate;
  var currentDate;
  checkDateAndTime() async {
    final prefs = await SharedPreferences.getInstance();
    passcode = prefs.getString('passcode');
    loginDate = prefs.getString("LoginDate");
    currentDate = DateFormat("dd/MM/yyyy").format(getDate);
    if (currentDate == loginDate) {
      print("The Current Date is  $currentDate");
      print("The Login Date is $loginDate");
      print("Login");
    } else {
      print("The Current Date is  $currentDate");
      print("The Login Date is $loginDate");
      setState(() {
        prefs.setBool("Authenticated", false);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }
  }

  int _currentIndex = 0;
  Future<bool> _onbackPressed() async {
    return showDialog(
        context: context,
        builder: (contex) => AlertDialog(
              title: Text("Do you Really want to exit"),
              actions: [
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }

  List<Widget> _pages = [
    HomePage(),
    ReportPageMain(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: SafeArea(
          child: Scaffold(
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: [
                  // Home
                  SalomonBottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Dashboard"),
                    selectedColor: Apptheme.PrimaryColor,
                  ),

                  //Report-*+
                  SalomonBottomBarItem(
                      icon: Icon(Icons.notes),
                      title: Text("Reports"),
                      selectedColor: Apptheme.textColo1r),
                  // Profile
                  SalomonBottomBarItem(
                      icon: Icon(Icons.person),
                      title: Text("Profile"),
                      selectedColor: Apptheme.textColor2),
                ],
              ),
              body: _pages[_currentIndex])),
    );
  }

  Future screenlock(context) async {
    await screenLock(
        context: context,
        title: Text('Enter the password to Go in'),
        confirmTitle: Text('Confirm'),
        correctString: passcode,
        confirmation: false,
        didMaxRetries: (retries) {},
        canCancel: false,
        screenLockConfig: ScreenLockConfig(
          backgroundColor: Colors.black.withOpacity(0.1),
        ),
        secretsConfig: SecretsConfig(
          spacing: 15, // or spacingRatio
          padding: const EdgeInsets.all(40),
          secretConfig: SecretConfig(
            borderColor: Colors.white,
            borderSize: 2.0,
            disabledColor: Colors.black,
            enabledColor: Colors.white,
            height: 20,
            width: 20,
            build: (context, {config, enabled}) {
              return WillPopScope(
                onWillPop: _onbackPressed,
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey,
                            spreadRadius: 2,
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color:
                          enabled ? config.enabledColor : config.disabledColor,
                      border: Border.all(
                        width: config.borderSize,
                        color: config.borderColor,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    width: config.width,
                    height: config.height,
                  ),
                  width: config.width,
                  height: config.height,
                ),
              );
            },
          ),
        ),
        inputButtonConfig: InputButtonConfig(
          textStyle: InputButtonConfig.getDefaultTextStyle(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          buttonStyle: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            backgroundColor: Colors.blue.withOpacity(0.9),
          ),
        ),
        cancelButton: const Icon(Icons.close),
        deleteButton: const Icon(Icons.close),
        footer: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasscode(),
                    ));
              },
              child: Text("Reset Passcode")),
        ));
  }
}
