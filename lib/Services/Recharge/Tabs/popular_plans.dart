import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/serviceslist.dart';

class PopularPlan extends StatefulWidget {
  @override
  _PopularPlanState createState() => _PopularPlanState();
}

class _PopularPlanState extends State<PopularPlan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Validity",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("28 Days"),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          Text(
                            "Data",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("1.5 GB/day"),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Apptheme.PrimaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Price"),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Data:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text("1.5 GB/day", style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        width: 18,
                      ),
                      Text("Voice:", style: TextStyle(color: Colors.grey)),
                      SizedBox(
                        width: 4,
                      ),
                      Text("Unlimited Calls",
                          style: TextStyle(color: Colors.grey))
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
