import 'package:flutter/material.dart';
import 'package:netly/list.dart';

class Detailtable extends StatefulWidget {
  @override
  _DetailtableState createState() => _DetailtableState();
}

class _DetailtableState extends State<Detailtable> {
  final textstyle = TextStyle(fontSize: 16);
  final textstyleheading = TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Details"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sheetdata.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              sheetdata[index].heading,
                              style: textstyleheading,
                            ),
                            Spacer(),
                            Text(
                              sheetdata[index].headingdata,
                              textAlign: TextAlign.right,
                              style: textstyle,
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ));
  }
}
