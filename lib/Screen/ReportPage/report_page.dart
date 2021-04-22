import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/filterpage.dart';
import 'package:netly/Screen/ReportPage/reportfile.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  DateTime toDate = DateTime.now();

  DateTime date;
  var date1;
  String dropdownValue = 'Recharge';
  final textstyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Container(
                width: 400,
                height: 200,
                color: Apptheme.PrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total Result Found from",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 4),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  elevation: 4.0,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  context: context,
                                  builder: (context) => Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(10.0),
                                              topRight:
                                                  const Radius.circular(10.0))),
                                      height: 600,
                                      child: Filter()));
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "22.02.2021",
                            style: textstyle,
                          ),
                        ),
                        Text(
                          "to",
                          style: textstyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "24.02.2021",
                            style: textstyle,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Operations :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "2",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total Transactions :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "₹ 300.0",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Status :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "True",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
                width: 400,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      // sortAscending: true,
                      columnSpacing: 35,
                      showCheckboxColumn: false,

                      columns: [
                        DataColumn(
                            onSort: (columnIndex, ascending) {},
                            label: Text("Id")),
                        DataColumn(label: Text("Operation")),
                        DataColumn(label: Text("Mobile No.")),
                        DataColumn(label: Text("Previous Amount")),
                      ],
                      rows: [
                        DataRow(
                            onSelectChanged: (value) {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                context: context,
                                builder: (context) => Container(
                                    height: 600,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Detailtable()),
                              );
                            },
                            cells: [
                              DataCell(Text("1")),
                              DataCell(Text("Recharge")),
                              DataCell(Text("8700897955")),
                              DataCell(Text("150.0")),
                            ]),
                        DataRow(cells: [
                          DataCell(Text("1")),
                          DataCell(Text("Recharge")),
                          DataCell(Text("8700897955")),
                          DataCell(Text("150.0")),
                        ]),
                      ],
                    ))),
          ),
        ],
      )),
    );
  }
}
