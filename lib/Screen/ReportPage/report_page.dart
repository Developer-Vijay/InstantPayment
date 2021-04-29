import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/filterpage.dart';
import 'package:netly/Screen/ReportPage/reportfile.dart';
import 'package:netly/Services/serviceslist.dart';

class ReportPage extends StatefulWidget {
  final data;
  const ReportPage({this.data});
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  Widget walletdata() {
    return DataTable(
      columns: [
        DataColumn(label: Text("TransactionId")),
        DataColumn(label: Text("Previous Amount")),
        DataColumn(label: Text("Amount Transacted")),
        DataColumn(label: Text("Balance Amount")),
        DataColumn(label: Text("Transaction Type")),
        DataColumn(label: Text("Operation")),
        DataColumn(label: Text("Relational Operation")),
        DataColumn(label: Text("Status")),
        DataColumn(label: Text("Created Date")),
        DataColumn(label: Text("Updated Date")),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("jhvfvcvd232vvc")),
          DataCell(Text("400")),
          DataCell(Text("2000")),
          DataCell(Text("2400")),
          DataCell(Text("Credit")),
          DataCell(Text("")),
          DataCell(Text("")),
          DataCell(Text("Succes")),
          DataCell(Text("${DateTime.april}")),
          DataCell(Text("${DateTime.may}")),
        ])
      ],
    );
  }

  Widget rechargeAndBillpayments() {
    if (data == "Mobile Recharge") {
      return DataTable(
        columnSpacing: 35,
        showCheckboxColumn: false,
        columns: [
          DataColumn(onSort: (columnIndex, ascending) {}, label: Text("Id")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Mobile No.")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Detailtable()),
                );
              },
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Recharge")),
                DataCell(Text("8700897955")),
                DataCell(Text("150.0")),
                DataCell(Text("75.0")),
                DataCell(Text("75.0")),
                DataCell(Text("Debit")),
                DataCell(Text("Success")),
                DataCell(Text("2021-02-01")),
                DataCell(Text("2021-02-06")),
              ]),
          DataRow(cells: [
            DataCell(Text("1")),
            DataCell(Text("Recharge")),
            DataCell(Text("8700897955")),
            DataCell(Text("150.0")),
            DataCell(Text("75.0")),
            DataCell(Text("75.0")),
            DataCell(Text("Debit")),
            DataCell(Text("Success")),
            DataCell(Text("2021-02-01")),
            DataCell(Text("2021-02-06")),
          ]),
        ],
      );
    } else if (data == "Dth Recharge") {
      return DataTable(
        columnSpacing: 35,
        showCheckboxColumn: false,
        columns: [
          DataColumn(onSort: (columnIndex, ascending) {}, label: Text("Id")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Mobile No.")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(
              onSelectChanged: (value) {
                showModalBottomSheet(
                  enableDrag: true,
                  //  isScrollControlled: false,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Container(
                      // height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Detailtable()),
                );
              },
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Recharge")),
                DataCell(Text("8700897955")),
                DataCell(Text("150.0")),
                DataCell(Text("75.0")),
                DataCell(Text("75.0")),
                DataCell(Text("Debit")),
                DataCell(Text("Success")),
                DataCell(Text("2021-02-01")),
                DataCell(Text("2021-02-06")),
              ]),
          DataRow(cells: [
            DataCell(Text("1")),
            DataCell(Text("Recharge")),
            DataCell(Text("8700897955")),
            DataCell(Text("150.0")),
            DataCell(Text("75.0")),
            DataCell(Text("75.0")),
            DataCell(Text("Debit")),
            DataCell(Text("Success")),
            DataCell(Text("2021-02-01")),
            DataCell(Text("2021-02-06")),
          ]),
        ],
      );
    } else if (data == "Electricity bill") {
      return DataTable(
        columnSpacing: 35,
        showCheckboxColumn: false,
        columns: [
          DataColumn(onSort: (columnIndex, ascending) {}, label: Text("Id")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Mobile No.")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(
              onSelectChanged: (value) {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Container(
                      // height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Detailtable()),
                );
              },
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Recharge")),
                DataCell(Text("8700897955")),
                DataCell(Text("150.0")),
                DataCell(Text("75.0")),
                DataCell(Text("75.0")),
                DataCell(Text("Debit")),
                DataCell(Text("Success")),
                DataCell(Text("2021-02-01")),
                DataCell(Text("2021-02-06")),
              ]),
          DataRow(cells: [
            DataCell(Text("1")),
            DataCell(Text("Recharge")),
            DataCell(Text("8700897955")),
            DataCell(Text("150.0")),
            DataCell(Text("75.0")),
            DataCell(Text("75.0")),
            DataCell(Text("Debit")),
            DataCell(Text("Success")),
            DataCell(Text("2021-02-01")),
            DataCell(Text("2021-02-06")),
          ]),
        ],
      );
    } else if (data == "Data Card bill") {
      return DataTable(
        columnSpacing: 35,
        showCheckboxColumn: false,
        columns: [
          DataColumn(onSort: (columnIndex, ascending) {}, label: Text("Id")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Mobile No.")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(
              onSelectChanged: (value) {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Container(
                      // height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Detailtable()),
                );
              },
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Recharge")),
                DataCell(Text("8700897955")),
                DataCell(Text("150.0")),
                DataCell(Text("75.0")),
                DataCell(Text("75.0")),
                DataCell(Text("Debit")),
                DataCell(Text("Success")),
                DataCell(Text("2021-02-01")),
                DataCell(Text("2021-02-06")),
              ]),
          DataRow(cells: [
            DataCell(Text("1")),
            DataCell(Text("Recharge")),
            DataCell(Text("8700897955")),
            DataCell(Text("150.0")),
            DataCell(Text("75.0")),
            DataCell(Text("75.0")),
            DataCell(Text("Debit")),
            DataCell(Text("Success")),
            DataCell(Text("2021-02-01")),
            DataCell(Text("2021-02-06")),
          ]),
        ],
      );
    } else if (data == "Gas bill") {
      return DataTable(
        columnSpacing: 35,
        showCheckboxColumn: false,
        columns: [
          DataColumn(onSort: (columnIndex, ascending) {}, label: Text("Id")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Mobile No.")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction type")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(
              onSelectChanged: (value) {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => Container(
                      // height: 600,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Detailtable()),
                );
              },
              cells: [
                DataCell(Text("1")),
                DataCell(Text("Recharge")),
                DataCell(Text("8700897955")),
                DataCell(Text("150.0")),
                DataCell(Text("75.0")),
                DataCell(Text("75.0")),
                DataCell(Text("Debit")),
                DataCell(Text("Success")),
                DataCell(Text("2021-02-01")),
                DataCell(Text("2021-02-06")),
              ]),
          DataRow(cells: [
            DataCell(Text("1")),
            DataCell(Text("Recharge")),
            DataCell(Text("8700897955")),
            DataCell(Text("150.0")),
            DataCell(Text("75.0")),
            DataCell(Text("75.0")),
            DataCell(Text("Debit")),
            DataCell(Text("Success")),
            DataCell(Text("2021-02-01")),
            DataCell(Text("2021-02-06")),
          ]),
        ],
      );
    } else if (data == "Money Transfer Report") {
      return DataTable(
        columnSpacing: 30,
        columns: [
          DataColumn(label: Text("TransactionId")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction Type")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Relational Operation")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text("jhvfvcvd232vvc")),
            DataCell(Text("400")),
            DataCell(Text("2000")),
            DataCell(Text("2400")),
            DataCell(Text("Credit")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("Succes")),
            DataCell(Text("${DateTime.april}")),
            DataCell(Text("${DateTime.may}")),
          ])
        ],
      );
    } else if (data == "AEPS Report") {
      return DataTable(
        columns: [
          DataColumn(label: Text("TransactionId")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction Type")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Relational Operation")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text("jhvfvcvd232vvc")),
            DataCell(Text("400")),
            DataCell(Text("2000")),
            DataCell(Text("2400")),
            DataCell(Text("Credit")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("Succes")),
            DataCell(Text("${DateTime.april}")),
            DataCell(Text("${DateTime.may}")),
          ])
        ],
      );
    } else if (data == "Micro Atm Report") {
      return DataTable(
        columns: [
          DataColumn(label: Text("TransactionId")),
          DataColumn(label: Text("Previous Amount")),
          DataColumn(label: Text("Amount Transacted")),
          DataColumn(label: Text("Balance Amount")),
          DataColumn(label: Text("Transaction Type")),
          DataColumn(label: Text("Operation")),
          DataColumn(label: Text("Relational Operation")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Created Date")),
          DataColumn(label: Text("Updated Date")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text("jhvfvcvd232vvc")),
            DataCell(Text("400")),
            DataCell(Text("2000")),
            DataCell(Text("2400")),
            DataCell(Text("Credit")),
            DataCell(Text("")),
            DataCell(Text("")),
            DataCell(Text("Succes")),
            DataCell(Text("${DateTime.april}")),
            DataCell(Text("${DateTime.may}")),
          ])
        ],
      );
    }
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
                width: 133 * SizeConfig.widthMultiplier,
                height: 28 * SizeConfig.heightMultiplier,
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
                                fontSize: 2.2 * SizeConfig.textMultiplier,
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
                                      height: 85 * SizeConfig.heightMultiplier,
                                      child: Filter()));
                            },
                            child: Container(
                              width: 24 * SizeConfig.widthMultiplier,
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
                 
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Operations :",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "2",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
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
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "₹ 300.0",
                            style: TextStyle(
                              fontFamily: 'arvo',
                                color: Colors.white,
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
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
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "True",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.2 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600),
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
              width: 133 * SizeConfig.widthMultiplier,
              child: SingleChildScrollView(
                child: rechargeAndBillpayments(),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
