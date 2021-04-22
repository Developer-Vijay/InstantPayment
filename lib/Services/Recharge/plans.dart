import 'package:flutter/material.dart';
import 'package:netly/Services/Recharge/Tabs/popular_plans.dart';

class MobilePlan extends StatefulWidget {
  @override
  _MobilePlanState createState() => _MobilePlanState();
}

class _MobilePlanState extends State<MobilePlan> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Plans"),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: Text("Popular"),
                ),
                Tab(
                  child: Text("Jio Cricket"),
                ),
                Tab(
                  child: Text("Jio Phone"),
                ),
                Tab(
                  child: Text("All Plans"),
                ),
              ],
            )),
        body: TabBarView(
          children: [
            PopularPlan(),
            Icon(Icons.car_rental),
            Icon(Icons.car_rental),
            Icon(Icons.car_rental),
          ],
        ),
      ),
    );
  }
}
