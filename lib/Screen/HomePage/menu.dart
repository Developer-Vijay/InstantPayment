import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screen_lock/configurations/input_button_config.dart';
import 'package:flutter_screen_lock/configurations/screen_lock_config.dart';
import 'package:flutter_screen_lock/configurations/secret_config.dart';
import 'package:flutter_screen_lock/configurations/secrets_config.dart';
import 'package:flutter_screen_lock/functions.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
                // onTap: () async {
                //   final isAuthenticated = await LocalAuthPi.authenticate();

                //   if (isAuthenticated) {
                //     Fluttertoast.showToast(msg: "Authenticated");
                //   }
                // },
                child: Container(
                  width: 126,
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
                          height: 25,
                        )),
                        SizedBox(
                          height: 12,
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
                onTap: () {},
                child: Container(
                  width: 126,
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
                            height: 25,
                          ),
                        ),
                        SizedBox(
                          height: 12,
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
                  // screenlock();
                },
                child: Container(
                  width: 120,
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
                            height: 25,
                          ),
                        ),
                        SizedBox(
                          height: 12,
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

  void screenlock() {
    screenLock(
        context: context,
        title: Text('Enter the password to Go in'),
        confirmTitle: Text('Confirm'),
        correctString: '1234',
        confirmation: false,
        maxRetries: retries,
        didMaxRetries: (retries) {},
        canCancel: false,
        screenLockConfig: ScreenLockConfig(
          backgroundColor: Colors.black,
        ),
        secretsConfig: SecretsConfig(
          spacing: 15, // or spacingRatio
          padding: const EdgeInsets.all(40),
          secretConfig: SecretConfig(
            borderColor: Colors.amber,
            borderSize: 2.0,
            disabledColor: Colors.black,
            enabledColor: Colors.amber,
            height: 20,
            width: 20,
            build: (context, {config, enabled}) {
              return SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.blue,
          ),
        ),
        cancelButton: const Icon(Icons.close),
        deleteButton: const Icon(Icons.close),
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "Pin is Working");
              },
              child: Text("Reset Pin")),
        ));
  }
}
