import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final headstyle = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 2.2 * SizeConfig.textMultiplier);
  final dataStyle = TextStyle(
      fontWeight: FontWeight.w500, fontSize: 2.3 * SizeConfig.textMultiplier);
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Status"),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
             
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  showBottomBorder: true,
                  columnSpacing: 30,
                  columns: [
                    DataColumn(
                        label: Text("Name of Service",
                            style: TextStyle(
                                // color: Colors.red[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 2 * SizeConfig.textMultiplier))),
                    DataColumn(
                        label: Text("Success",
                            style: TextStyle(
                                color: Colors.green[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 2 * SizeConfig.textMultiplier))),
                    DataColumn(
                        label: Text("Failed",
                            style: TextStyle(
                                color: Colors.red[600],
                                fontWeight: FontWeight.w600,
                                fontSize: 2 * SizeConfig.textMultiplier))),
                    DataColumn(
                        label: Text("Pending",
                            style: TextStyle(
                                color: Colors.amber[700],
                                fontWeight: FontWeight.w600,
                                fontSize: 2 * SizeConfig.textMultiplier))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        "Recharge",
                        style: headstyle,
                      )),
                      DataCell(Text(
                        "1",
                        style: dataStyle,
                      )),
                      DataCell(Text("0", style: dataStyle)),
                      DataCell(Text("2", style: dataStyle)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Bill Payments",
                        style: headstyle,
                      )),
                      DataCell(Text("1", style: dataStyle)),
                      DataCell(Text("0", style: dataStyle)),
                      DataCell(Text("2", style: dataStyle)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Money Transfer",
                        style: headstyle,
                      )),
                      DataCell(Text("1", style: dataStyle)),
                      DataCell(Text("0", style: dataStyle)),
                      DataCell(Text("2", style: dataStyle)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        "Recharge",
                        style: headstyle,
                      )),
                      DataCell(Text("1", style: dataStyle)),
                      DataCell(Text("0", style: dataStyle)),
                      DataCell(Text("2", style: dataStyle)),
                    ]),
                  ],
                ),
              )
            ],
          )
        
          ),
    );
  }
}
