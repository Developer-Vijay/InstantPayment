import 'package:flutter/material.dart';
import 'package:netly/Services/Aeps/balance_enquiry.dart';
import 'package:netly/Services/Aeps/cash_withdrawal_page.dart';

class AepsMainPage extends StatefulWidget {
  @override
  _AepsMainPageState createState() => _AepsMainPageState();
}

class _AepsMainPageState extends State<AepsMainPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: list.length,
      vsync: this,
    );

    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
      print("Selected Index: " + controller.index.toString());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabController controller;
  int selectedIndex = 0;
  List<Widget> list = [
    Tab(
      child: Text("Cash Withdrawal"),
    ),
    //   Tab(
    //   child: Text("Finger Print Reader"),
    // ),
    Tab(
      child: Text("Balance Enquiry"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("AEPS"),
            bottom: TabBar(
              controller: controller,
              tabs: list,
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              CashWithDrawPage(), 
            BalanceEnquiry()],
          ),
        ),
      ),
    );
  }
}
