import 'dart:async';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Screen/HomePage/homebar.dart';
import 'package:netly/Screen/HomePage/menu.dart';
import 'package:netly/Screen/HomePage/services.dart';
import 'package:netly/SetPassword/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';


// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  var walletMoney;
  HomePage({Key key, this.walletMoney}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    getdata();
  }

  var retrieveLogin;
  var sessionToken;
  var refreshToken;
  var loginId;
  var logindata;
  var responseData;
  var walletAmount;
  var amount;
  bool status = false;

  
  ScrollController scrollController = ScrollController();

  bool isAuthenticated = false;

  var storedPasscode = '123456';

  var passcode;
  void getdata() async {
    final prefs = await SharedPreferences.getInstance();
    passcode = prefs.getString('passcode');
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          children: [
            Homebar(
              walletAmount: walletAmount,
            ),
            SizedBox(
              height: 1.5 * SizeConfig.heightMultiplier,
            ),
            SizedBox(
              height: 0,
            ),
            Menu(),
            SizedBox(
              height: 1.5 * SizeConfig.heightMultiplier,
            ),
            Container(
                color: Colors.grey[200],
                margin: EdgeInsets.only(
                    left: 2 * SizeConfig.widthMultiplier,
                    right: 2 * SizeConfig.widthMultiplier),
                child: Services()),
          ],
        ),
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
          spacing: 15, 
          padding: const EdgeInsets.all(40),
          secretConfig: SecretConfig(
            borderColor: Colors.white,
            borderSize: 2.0,
            disabledColor: Colors.black,
            enabledColor: Colors.white,
            height: 20,
            width: 20,
            build: (context, {config, enabled}) {
              return SizedBox(
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
                    color: enabled ? config.enabledColor : config.disabledColor,
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
