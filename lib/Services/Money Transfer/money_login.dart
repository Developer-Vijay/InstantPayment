import 'package:flutter/material.dart';

import 'add_user.dart';
import 'login_user.dart';

class MoneyTransferLoginScreen extends StatefulWidget {
  @override
  _MoneyTransferLoginScreenState createState() =>
      _MoneyTransferLoginScreenState();
}

class _MoneyTransferLoginScreenState extends State<MoneyTransferLoginScreen> with TickerProviderStateMixin {
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
      child: Text("Add User"),
    ),
    Tab(
      child: Text("Login"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Money Transfer"),
          bottom: TabBar(controller: controller, tabs: list),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            AddUser(
              controller: controller,
              selectedindex: selectedIndex,
            ),
            LoginUser(
              controller: controller,
              selectedindex: selectedIndex,
            )
          ],
        ),
      ),
    );
  }
}
