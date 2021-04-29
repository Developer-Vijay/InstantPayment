import 'package:flutter/material.dart';
import 'package:netly/Services/Money%20Transfer/add_benficiary_page.dart';
import 'package:netly/Services/Money%20Transfer/recipientpage.dart';

class AddBeneficiary extends StatefulWidget {
  var data;
  AddBeneficiary({this.data});
  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary>
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

  List<Widget> list = [
    Tab(
      child: Text("Add Benificiary"),
    ),
    Tab(
      child: Text("Recipient"),
    ),
  ];
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabController controller;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            bottom: TabBar(
              controller: controller,
              tabs: list,
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: [
              BenificaryPage(
                data: widget.data,
                controller: controller,
                selectedIndex: selectedIndex,
              ),
              RecipientPage(
                controller: controller,
                selectedIndex: selectedIndex,
              )
            ],
          ),
        ),
      ),
    );
  }
}
