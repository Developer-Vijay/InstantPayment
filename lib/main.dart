import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/SplashScreen/splashScreen.dart';

void main() {
  runApp(Netly());
}

class Netly extends StatefulWidget {
  @override
  _NetlyState createState() => _NetlyState();
}

class _NetlyState extends State<Netly> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: ("Netpayment"),
                theme: ThemeData(
                  fontFamily: 'PT Serif',
                  primarySwatch: Colors.blue),
                home: SplashPage());
          },
        );
      },
    );
  }
}
