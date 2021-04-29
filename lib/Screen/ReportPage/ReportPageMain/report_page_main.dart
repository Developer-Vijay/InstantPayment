import 'package:flutter/material.dart';
import 'package:netly/Screen/ReportPage/ReportPageMain/others_tab.dart';
import 'package:netly/Screen/ReportPage/ReportPageMain/transactions_page.dart';

class ReportPageMain extends StatefulWidget {
  @override
  _ReportPageMainState createState() => _ReportPageMainState();
}

class _ReportPageMainState extends State<ReportPageMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reports"),
        ),
        body: Transactions(),
      ),
    );
  }
}
