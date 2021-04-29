import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/add_balance.dart';

import 'menulist.dart';

class PaymentRequestReport extends StatefulWidget {
  @override
  _PaymentRequestReportState createState() => _PaymentRequestReportState();
}

class _PaymentRequestReportState extends State<PaymentRequestReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            minWidth: 20 * SizeConfig.widthMultiplier,
            child: Text("Request"),
            textColor: Apptheme.whitetextcolor,
            // color: Apptheme.PrimaryColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBalancePage()));
            },
          )
        ],
        title: Text("Request Report"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 2.5 * SizeConfig.heightMultiplier,
          ),
          // Center(
          //     child: Text(
          //   "Request Report",
          //   style: TextStyle(
          //       fontSize: 2.6 * SizeConfig.textMultiplier,
          //       fontWeight: FontWeight.w600),
          // )),
          ListView.builder(
            shrinkWrap: true,
            itemCount: addbalance.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showBottomBorder: true,
                    columnSpacing: 29,
                    columns: [
                      DataColumn(label: Text("Amount")),
                      DataColumn(label: Text("Id")),
                      DataColumn(label: Text("Date")),
                      DataColumn(label: Text("type")),
                      DataColumn(label: Text("Bank Name")),
                    ],
                    rows: [
                      DataRow.byIndex(index: index, cells: [
                        DataCell(Text(addbalance[index].amount)),
                        DataCell(Text(addbalance[index].id)),
                        DataCell(Text(addbalance[index].date)),
                        DataCell(Text(addbalance[index].transfer)),
                        DataCell(Text(addbalance[index].bank)),
                      ]),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 2.5 * SizeConfig.heightMultiplier,
          ),
          // Center(
          //     child: MaterialButton(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //   minWidth: 40 * SizeConfig.widthMultiplier,
          //   child: Text("Request"),
          //   textColor: Apptheme.whitetextcolor,
          //   color: Apptheme.PrimaryColor,
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => AddBalancePage()));
          //   },
          // )
          // )
        ],
      ),
    );
  }
}
