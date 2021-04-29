import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import '../serviceslist.dart';

class DthSelect extends StatefulWidget {
  var data;
  DthSelect({this.data});
  @override
  _DthSelectState createState() => _DthSelectState();
}

class _DthSelectState extends State<DthSelect> {
  List data1 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select an operator"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: dthlist.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (dthlist[index].index == 0) {
                setState(() {
                  data1 = dthlist[index].title;
                });

                Navigator.pop(context);
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        elevation: 10,
                        child: CircleAvatar(
                          backgroundColor: Apptheme.whitetextcolor,
                          radius: 5 * SizeConfig.heightMultiplier,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: dthlist[index].logo),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        dthlist[index].title,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
