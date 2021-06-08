import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/payment_requst_report.dart';
import 'package:netly/Menu%20Pages/Status%20Page/status_page.dart';
import 'package:netly/SetPassword/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();

    getdata();
  }

  var passcode;
  void getdata() async {
    final prefs = await SharedPreferences.getInstance();
    passcode = prefs.getString('passcode');
  }

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

  int retries = 3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 5,
                color: Colors.blueGrey[50],
                offset: Offset(4, 6))
          ]),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  screenlock();
                },
                child: Container(
                  width: 32 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.blueGrey[50],
                        spreadRadius: 2,
                        offset: Offset(1, 5))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            child: SvgPicture.asset(
                          "assets/icon/shield.svg",
                          height: 6 * SizeConfig.imageSizeMultiplier,
                        )),
                        SizedBox(
                          height: 1.72 * SizeConfig.heightMultiplier,
                        ),
                        Text(
                          " Lock",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: (context) => StatusPage());
                },
                child: Container(
                  width: 32 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.blueGrey[50],
                        spreadRadius: 2,
                        offset: Offset(1, 5))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/icon/package.svg",
                            height: 6 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                        SizedBox(
                          height: 1.72 * SizeConfig.heightMultiplier,
                        ),
                        Text(
                          " Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentRequestReport()));
                },
                child: Container(
                  width: 31 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        color: Colors.blueGrey[50],
                        spreadRadius: 2,
                        offset: Offset(1, 5))
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/icon/money-growth.svg",
                            height: 6 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                        SizedBox(
                          height: 1.72 * SizeConfig.heightMultiplier,
                        ),
                        Text(
                          " Add Balance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future screenlock() async {
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
            height: 2.2 * SizeConfig.heightMultiplier,
            width: 4 * SizeConfig.widthMultiplier,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePasscode()));
              },
              child: Text("Reset Passcode")),
        ));
  }
}
