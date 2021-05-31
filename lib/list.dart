import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: camel_case_types
class grid {
  var icon;
  var title;
  int index;
  grid({this.icon, this.title, this.index});
}

// 1. Mobile Recharge
// 2. Electricity
// 3. DTH
// 4. Data Card
// 5. Gas
// 6. Money Transfer
// 7. Aeps
// 8. Micro ATM
// 9. See All

List<grid> data = [
  grid(
      index: 0,
      icon: SvgPicture.asset(
        "assets/icon/upi.svg",
        height: 25,
      ),
      title: "Recharge"),
  grid(
      index: 1,
      icon: SvgPicture.asset(
        "assets/icon/parabolic-dishes.svg",
        height: 25,
      ),
      title: "DTH"),
  grid(
      index: 2,
      icon: SvgPicture.asset(
        "assets/icon/tower.svg",
        height: 25,
      ),
      title: "Electricity"),
  grid(
    index: 3,
    icon: SvgPicture.asset(
      "assets/icon/card.svg",
      height: 25,
    ),
    title: "Data Card",
  ),
  grid(
      index: 4,
      icon: SvgPicture.asset(
        "assets/icon/gas.svg",
        height: 25,
      ),
      title: "Gas"),
  grid(
      index: 5,
      icon: SvgPicture.asset(
        "assets/icon/money-transfer.svg",
        height: 25,
      ),
      title: "Money Transfer"),
  grid(
      index: 6,
      icon: SvgPicture.asset(
        "assets/icon/aep.svg",
        height: 25,
      ),
      title: "Aeps"),
  grid(
      index: 7,
      icon: SvgPicture.asset(
        "assets/icon/atm-machine.svg",
        height: 25,
      ),
      title: "Micro ATM"),
  grid(
      index: 8,
      icon: SvgPicture.asset(
        "assets/icon/reply.svg",
        height: 25,
      ),
      title: "See All")
];

List imageslist = [
  "https://business.paytm.com/blog/wp-content/uploads/2019/05/1-App-multiple-solution-Blog-Banner.jpg",
  "https://business.paytm.com/blog/wp-content/uploads/2018/03/Revamped-paytmforbusiness-blog-banner.jpg",
];

class ProfileList {
  var title;
  var icon;
  int index;
  var hasnavigation;
  ProfileList({this.title, this.hasnavigation, this.icon, this.index});
}

List<ProfileList> profile = [
  ProfileList(
      hasnavigation: true,
      icon: Icon(Icons.lock),
      title: "Change Passcode",
      index: 0),
  ProfileList(
      hasnavigation: true,
      icon: Icon(Icons.settings),
      title: "Change Password",
      index: 1),
  ProfileList(
      hasnavigation: true,
      icon: Icon(Icons.settings),
      title: "Settings",
      index: 1),
];

class TableData {
  var transactionid;
  var operationDescription;
  int mobilenumber;
  double amount;
  double transactionamount;
  double balanceAmount;
  var transactionType;
  var status;
  DateTime createdTime;
  DateTime updatedTime;

  TableData(
      {this.amount,
      this.balanceAmount,
      this.createdTime,
      this.mobilenumber,
      this.operationDescription,
      this.status,
      this.transactionType,
      this.transactionamount,
      this.transactionid,
      this.updatedTime});
}

List<TableData> table = [
  TableData(
      transactionid: "a56678831893686gxzxdjk",
      operationDescription: "Airtel Recharge",
      mobilenumber: 9871224515,
      amount: 1605.66,
      transactionamount: 49.0,
      balanceAmount: 1556.0,
      transactionType: "Debit",
      status: "Success",
      createdTime: DateTime.now(),
      updatedTime: DateTime.now())
];

class DessertDataSource extends DataTableSource {
  int _selecte4dRowcount = 0;
  List<TableData> table = [
    TableData(
        transactionid: "a56678831893686gxzxdjk",
        operationDescription: "Airtel Recharge",
        mobilenumber: 9871224515,
        amount: 1605.66,
        transactionamount: 49.0,
        balanceAmount: 1556.0,
        transactionType: "Debit",
        status: "Success",
        createdTime: DateTime.now(),
        updatedTime: DateTime.now())
  ];
  @override
  DataRow getRow(int index) {
    // ignore: todo
    // TODO: implement getRow
    assert(index >= 0);
    if (index >= table.length) return null;
    final TableData table1 = table[index];

    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text("${table1.transactionid}")),
      DataCell(Text("${table1.operationDescription}")),
      DataCell(Text("${table1.mobilenumber}")),
      DataCell(Text("${table1.amount}")),
      DataCell(Text("${table1.transactionamount}")),
      DataCell(Text("${table1.balanceAmount}")),
      DataCell(Text("${table1.transactionType}")),
      DataCell(Text("${table1.status}")),
      DataCell(Text("${table1.createdTime}")),
      DataCell(Text("${table1.updatedTime}")),
    ]);
  }

  @override
  // ignore: todo
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // ignore: todo
  // TODO: implement rowCount
  int get rowCount => table.length;

  @override
  // ignore: todo
  // TODO: implement selectedRowCount
  int get selectedRowCount => _selecte4dRowcount;
}

class Bottomdata {
  var heading;
  var headingdata;

  Bottomdata({this.heading, this.headingdata});
}

List<Bottomdata> sheetdata = [
  Bottomdata(heading: "Id:", headingdata: "1"),
  Bottomdata(heading: "operation:", headingdata: "Recharge"),
  Bottomdata(heading: "Mobile No.:", headingdata: "9818069709"),
  Bottomdata(heading: "Previous Amount:", headingdata: "150.0"),
  Bottomdata(heading: "Amount Transacted:", headingdata: "75.0"),
  Bottomdata(heading: "Balance Amount:", headingdata: "75.0"),
  Bottomdata(heading: "Transaction type:", headingdata: "Debit"),
  Bottomdata(heading: "Status:", headingdata: "Success"),
  Bottomdata(heading: "Created Date:", headingdata: "2021-02-01"),
  Bottomdata(heading: "Updated Date:", headingdata: "2021-02-06"),
];

class Radiolist {
  var value;
  var head;

  Radiolist({this.head, this.value});
}

List<Radiolist> radio = [
  Radiolist(head: "Recharge", value: 1),
  Radiolist(head: "Money Transfer", value: 2),
  Radiolist(head: "AEPS", value: 3),
  Radiolist(head: "MicroATM", value: 4),
  Radiolist(head: "BillPayment", value: 5),
  Radiolist(head: "Wallet", value: 6),
  Radiolist(head: "InterWallet", value: 7),
  Radiolist(head: "Commision", value: 8),
];
