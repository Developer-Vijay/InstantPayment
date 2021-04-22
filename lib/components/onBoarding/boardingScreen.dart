import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/SetPassword/set_passsword.dart';

class OnboardingScreen extends StatefulWidget {
  // Navigation to Dashboard Screen
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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

  void onIntroEnd(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetPasscode()),
    );
  }

  Widget buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 180.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
        fontSize: 19,
        color: Apptheme.boardingTextColor,
        fontWeight: FontWeight.w600);
    const Decoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: Apptheme.boardinglabelColor),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: IntroductionScreen(
        onDone: () => onIntroEnd(context),
        showSkipButton: true,
        showNextButton: true,
        skipFlex: 0,
        nextFlex: 0,
        next: Icon(Icons.arrow_forward),
        skip: const Text('Skip'),
        done: Column(
          children: [
            Icon(Icons.arrow_forward),
            const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        pages: [
          PageViewModel(
            title: "High Earning Potential",
            body:
                "NetPayment will give you a chance to earn more Become a retailer,distributor and master distributer and start high earning., ",
            image: buildImage('Profit'),
            decoration: Decoration,
          ),
          PageViewModel(
              title: "Get Instant Commission",
              body:
                  "Get instant commission and high commission & convert your commission into cash for a fee. ",
              image: buildImage('percentage'),
              decoration: Decoration),
          PageViewModel(
              title: "Faster Transaction",
              body:
                  " Best technologies have been used to make it as fast as possible to payment transactions. Faster transaction anywhere & anytime. ",
              image: buildImage("transaction"),
              decoration: Decoration)
        ],
      ),
    );
  }
}
