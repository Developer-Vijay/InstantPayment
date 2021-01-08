import 'package:flutter/material.dart';
import 'package:netly/components/splashScreen/SplashScreen.dart';

void main() {
  runApp(Netly());
}

class Netly extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      title: ("Netpayment"),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: splashPage(),
    );
  }
}
