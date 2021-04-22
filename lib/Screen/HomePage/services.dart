import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netly/Services/Dth/select_dth_operator.dart';
import 'package:netly/Services/Recharge/mobile_recharge.dart';
import 'package:netly/list.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3),
      color: Colors.grey[50],
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.red,
                  onTap: () {
                    if (data[index].index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileRecharge()));
                    } else if (data[index].index == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectDthOperator()));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: data[index].icon,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          data[index].title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
