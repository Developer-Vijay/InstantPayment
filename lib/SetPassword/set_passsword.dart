import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:netly/Components/Auth/login.dart';
import 'package:netly/Components/Resources/images.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPasscode extends StatefulWidget {
  @override
  _SetPasscodeState createState() => _SetPasscodeState();
}

class _SetPasscodeState extends State<SetPasscode> {
  TextEditingController controller = TextEditingController();
  var pinValidate;
  bool isValidate = false;
    Future<bool> _onbackPressed() async {
    return showDialog(
        context: context,
        builder: (contex) => AlertDialog(
              title: Text("Do you Really want to exit"),
              actions: [
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 22.2 * SizeConfig.heightMultiplier,
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                elevation: 14,
                child: Image.asset(
                  Images.loginImage,
                  height: 40 * SizeConfig.imageSizeMultiplier,
                ),
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Center(
              child: Text(
                "Set Passcode",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 2.4 * SizeConfig.textMultiplier),
              ),
            ),
            SizedBox(height: 5 * SizeConfig.heightMultiplier),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
                
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  maxLength: 4,
                  maxLines: 1,
                  enabled: true,
                  obscureText: true,
                  decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.only(left: 10),
                      border: InputBorder.none,
                      errorText: pinValidate,
                      suffixIcon: Icon(Icons.lock),
                      labelText: "Passcode",),
                ),
              ),
            ),
            SizedBox(height: 4 * SizeConfig.heightMultiplier),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                height: 6 * SizeConfig.heightMultiplier,
                textColor: Colors.white,
                color: Apptheme.PrimaryColor,
                onPressed: () {
                  setPin();
                },
                child: Text("Set Passcode"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future setPin() async {
       final prefs = await SharedPreferences.getInstance();
    if (controller.text.isEmpty) {
      setState(() {
        pinValidate = "Please Enter The Pin";
        isValidate = true;
      });
    } else if (controller.text.length < 4) {
      setState(() {
        pinValidate = "Pin should be of 4 Characters";
        isValidate = true;
      });
    } else {
      setState(() {
        pinValidate = null;
        isValidate = false;
      });
    }
    if (isValidate==false) {
   
      prefs.setString('passcode', controller.text.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
