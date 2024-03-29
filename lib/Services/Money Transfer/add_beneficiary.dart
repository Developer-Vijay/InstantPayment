import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/Services/Money%20Transfer/add_benficiary_page.dart';
import 'package:netly/Services/Money%20Transfer/login_user.dart';
import 'package:netly/Services/Money%20Transfer/recipientpage.dart';
import 'package:netly/components/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddBeneficiary extends StatefulWidget {
  var data;
  var responseData;
  var limit;
  var spent;
  AddBeneficiary({this.data, this.limit, this.spent, this.responseData});
  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary>
    with TickerProviderStateMixin {
  var number;
  var responseData;
  var bankData;
  bool allowNavigation = false;
  @override
  void initState() {
    super.initState();
    getUserData();

    controller = TabController(
      length: list.length,
      vsync: this,
    );
    print("*******");
    print(widget.data);
    print("************");

    setState(() {
      number = widget.data;
    });

    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });

      print("Selected Index: " + controller.index.toString());
    });
  }

  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      retrieveLogin = prefs.getString('loginInfo');
      logindata = jsonDecode(retrieveLogin);
      sessionToken = logindata['sessionToken'];
      refreshToken = logindata['refreshToken'];
      loginId = logindata['user']['_id'];
    });
  }

  List<Widget> list = [
    Tab(
      child: Text("Recipient"),
    ),
    Tab(
      child: Text("Add Benificiary"),
    ),
  ];

  TabController controller;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginUser(),
            ));
      },
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    if (checker == true) {
                      setState(() {
                        checker = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUser(),
                          ));
                    } else if (checker == false) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUser(),
                          ));
                    }
                  }),
              toolbarHeight: 80,
              bottom: TabBar(
                controller: controller,
                tabs: list,
              ),
            ),
            body: TabBarView(
              controller: controller,
              children: [
                RecipientPage(
                  data: widget.data,
                  limit: widget.limit,
                  controller: controller,
                  spent: widget.spent,
                  apiData: widget.responseData,
                  selectedIndex: selectedIndex,
                ),
                BenificaryPage(
                  data: number,
                  limit: widget.limit,
                  spent: widget.spent,
                  bankData: bankData,
                  controller: controller,
                  selectedIndex: selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
