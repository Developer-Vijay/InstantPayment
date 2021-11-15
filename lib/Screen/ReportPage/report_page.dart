import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:netly/mobile.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/filterpage.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:netly/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  final data;
  final params;
  final fromDate;
  final toDate;
  const ReportPage({this.data, this.params, this.fromDate, this.toDate});
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var data;
  var params;
  var fromDate;
  var toDate;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    params = widget.params;
    fromDate = widget.fromDate;
    toDate = widget.toDate;
    Future.delayed(Duration.zero, () {
      getReportType(widget.params);
      print(widget.fromDate);
      print(widget.toDate);
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController seaarchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  List jsondata = [];
  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;
  var datarecieved;
  var index1;
  bool datachecker = false;
  bool checker2 = false;
  getReportType(var param) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            )));
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    refreshToken = logindata['refreshToken'];
    loginId = logindata['user']['_id'];
    print("?????????");
    print(loginId);
    print("?????????");
    // try {
    var response = await http.get(
        Uri.parse(COMMON_API +
            '/getReports' +
            '?filter={"fromDate":"$fromDate","toDate":"$toDate","userId":"$loginId","subdomain":"instantpay","reportType":"$param"}&limit=20&page=1'),
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        });
    datarecieved = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (datarecieved['reports'] == null) {
        print("No Data");
      } else {
        print(datarecieved['reports']['docs'].length);
      }
      setState(() {
        datachecker = true;
        checker2 = false;
      });

      print(datarecieved);
      print(response.body);

      Navigator.pop(context);
    } else {
      setState(() {
        datachecker = false;
        checker2 = true;
      });
      Navigator.pop(context);
    }
  }

  searchReportType(var param, var string) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            )));
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    refreshToken = logindata['refreshToken'];
    loginId = logindata['user']['_id'];
    try {
      var response = await http.get(
          Uri.parse(COMMON_API +
              '/getReports' +
              '?filter={"fromDate":"$fromDate","toDate":"$toDate","userId":"$loginId","subdomain":"instantpay","reportType":"$param","searchString":"$string"}&limit=20&page=1'),
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          });
      datarecieved = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(datarecieved['reports']['docs'].length);
        setState(() {
          datachecker = true;
          checker2 = false;
        });

        Navigator.pop(context);
      } else {
        setState(() {
          datachecker = false;
          checker2 = true;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future saveandShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/report.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  // ignore: missing_return
  Widget rechargeAndBillpayments() {
    if (data == "Recharge") {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: datarecieved['reports'] == null
            ? Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 25 * SizeConfig.widthMultiplier,
                    vertical: 35 * SizeConfig.heightMultiplier),
                child: Text(
                  "No Data Found",
                  style: TextStyle(
                      fontSize: 3.3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600),
                ))
            : datarecieved['reports']['docs'].length == 0
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 25 * SizeConfig.widthMultiplier,
                        vertical: 35 * SizeConfig.heightMultiplier),
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                          fontSize: 3.3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.w600),
                    ))
                : DataTable(
                    columnSpacing: 35,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(label: Text("TransactionId")),
                      DataColumn(label: Text("Operation Description")),
                      DataColumn(label: Text("Mobile No.")),
                      DataColumn(label: Text("Previous Amount")),
                      DataColumn(label: Text("Amount Transacted")),
                      DataColumn(label: Text("Balance Amount")),
                      DataColumn(label: Text("Transaction type")),
                      DataColumn(label: Text("Status")),
                      DataColumn(label: Text("Created Date")),
                      DataColumn(label: Text("Updated Date")),
                      DataColumn(label: Text("Action")),
                    ],
                    rows: List.generate(
                        datarecieved['reports']['docs'].length,
                        (index) => DataRow(
                                onSelectChanged: (value) async {
                                  // saveandShare();async {
                                  final image =
                                      await screenshotController.capture();
                                  return await saveandShare(image);
                                  // saveImage(image);
                                },
                                cells: [
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['transactionId']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['serviceType']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['mobileNumber']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['transactionType']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['status']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['creationDate']}")),
                                  DataCell(Text(
                                      "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                                  DataCell(MaterialButton(
                                    minWidth: 30,

                                    // color: Apptheme.PrimaryColor,textColor:Apptheme.whitetextcolor,
                                    child: Icon(
                                      Icons.share_outlined,
                                      size: 20,
                                    ),
                                    onPressed: () {},
                                  )),
                                ]))),
      );
    } else if (data == "bill Payment") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      columnSpacing: 35,
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(label: Text("TransactionId")),
                        DataColumn(label: Text("Operation Description")),
                        DataColumn(label: Text("Mobile No.")),
                        DataColumn(label: Text("Previous Amount")),
                        DataColumn(label: Text("Amount Transacted")),
                        DataColumn(label: Text("Balance Amount")),
                        DataColumn(label: Text("Transaction type")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Created Date")),
                        DataColumn(label: Text("Updated Date")),
                      ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length,
                          (index) => DataRow(
                                  onSelectChanged: (value) {
                                    print("Data");
                                  },
                                  cells: [
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['transactionId']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['serviceType']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['mobileNumber']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['transactionType']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['status']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['creationDate']}")),
                                    DataCell(Text(
                                        "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                                  ]))));
    } else if (data == "Money Transfer") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      columnSpacing: 30,
                      columns: [
                        DataColumn(label: Text("TransactionId")),
                        DataColumn(label: Text("To Account")),
                        DataColumn(label: Text("Previous Amount")),
                        DataColumn(label: Text("Amount Transacted")),
                        DataColumn(label: Text("Balance Amount")),
                        DataColumn(label: Text("Bank Name")),
                        DataColumn(label: Text("Bene Mobile No.")),
                        DataColumn(label: Text("Beneficiary Name")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Transaction Mode")),
                        DataColumn(label: Text("BankRef No.")),
                        DataColumn(label: Text("Created Date")),
                        DataColumn(label: Text("Updated Date")),
                      ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(
                            onSelectChanged: (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            },
                            cells: [
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['transactionId']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['accountNumber']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['bankName']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['mobile']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['beneName']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['status']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['transferMode']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['bankRefNo']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['creationDate']}")),
                              DataCell(Text(
                                  "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                            ]);
                      })));
    } else if (data == "AEPS Report") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      columns: [
                          DataColumn(label: Text("TransactionId")),
                          DataColumn(label: Text("To Account")),
                          DataColumn(label: Text("Previous Amount")),
                          DataColumn(label: Text("Amount Transacted")),
                          DataColumn(label: Text("Balance Amount")),
                          DataColumn(label: Text("Bank Name")),
                          DataColumn(label: Text("Bene Mobile No.")),
                          DataColumn(label: Text("Beneficiary Name")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Transaction Mode")),
                          DataColumn(label: Text("BankRef No.")),
                          DataColumn(label: Text("Created Date")),
                          DataColumn(label: Text("Updated Date")),
                        ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionId']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['_id']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['bankName']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['mobile']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['beneName']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['status']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transferMode']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['bankRefNo']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['creationDate']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                        ]);
                      })));
    } else if (data == "Micro Atm Report") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
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
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionId']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['_id']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionType']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['operationPerformed']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['relationalOperation']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['status']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transferMode']}")),
                        ]);
                      })));
    } else if (data == "Wallet") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      columns: [
                          DataColumn(label: Text("TransactionId")),
                          DataColumn(label: Text("Previous Amount")),
                          DataColumn(label: Text("Amount Transacted")),
                          DataColumn(label: Text("Balance Amount")),
                          DataColumn(label: Text("Transaction Type")),
                          DataColumn(label: Text("Operation Performed")),
                          DataColumn(label: Text("Relational Operation")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Created Date")),
                          DataColumn(label: Text("Updated Date")),
                        ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionId']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionType']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['operationPerformed']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['relationalOperation']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['status']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['creationDate']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                        ]);
                      })));
    } else if (data == "InterWallet") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      columns: [
                          DataColumn(label: Text("TransactionId")),
                          DataColumn(label: Text("Previous Amount")),
                          DataColumn(label: Text("Amount Transacted")),
                          DataColumn(label: Text("Balance Amount")),
                          DataColumn(label: Text("Transaction Type")),
                          DataColumn(label: Text("Operation Performed")),
                          DataColumn(label: Text("Relational Operation")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Created Date")),
                          DataColumn(label: Text("Updated Date")),
                        ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionId']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionType']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['operationPerformed']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['relationalOperation']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['status']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['creationDate']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                        ]);
                      })));
    } else if (data == "Commission") {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: datarecieved['reports'] == null
              ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 25 * SizeConfig.widthMultiplier,
                      vertical: 35 * SizeConfig.heightMultiplier),
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 3.3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ))
              : datarecieved['reports']['docs'].length == 0
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * SizeConfig.widthMultiplier,
                          vertical: 35 * SizeConfig.heightMultiplier),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontSize: 3.3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.w600),
                      ))
                  : DataTable(
                      showBottomBorder: true,
                      columns: [
                        DataColumn(label: Text("TransactionId")),
                        DataColumn(
                            label: Text(
                          "Relational Amount",
                        )),
                        DataColumn(label: Text("Previous Amount")),
                        DataColumn(label: Text("Amount Transacted")),
                        DataColumn(label: Text("Balance Amount")),
                        DataColumn(label: Text("Transaction Type")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Relational Operation")),
                        DataColumn(label: Text("Created Date")),
                        DataColumn(label: Text("Updated Date")),
                      ],
                      rows: List.generate(
                          datarecieved['reports']['docs'].length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionId']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['relationalAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['previousAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['balanceAmount']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['transactionType']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['status']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['relationalOperation']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['creationDate']}")),
                          DataCell(Text(
                              "${datarecieved['reports']['docs'][index]['updatedDate']}")),
                        ]);
                      })));
    }
  }

  DateTime date;
  var date1;
  String dropdownValue = 'Recharge';
  final textstyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      },
      child: SafeArea(
        child: datachecker == false
            ? Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ))
            : SafeArea(
                child: Screenshot(
                  controller: screenshotController,
                  child: Scaffold(
                      floatingActionButton: FloatingActionButton(
                        child: Icon(
                          Icons.filter_alt_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
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
                                          topLeft: const Radius.circular(10.0),
                                          topRight:
                                              const Radius.circular(10.0))),
                                  height: 40 * SizeConfig.heightMultiplier,
                                  child: Filter(
                                    param: widget.params,
                                    title: widget.data,
                                  )));
                        },
                      ),
                      body: Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                  width: 133 * SizeConfig.widthMultiplier,
                                  color: Apptheme.PrimaryColor,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Total Result Found from",
                                              style: TextStyle(
                                                  fontSize: 2.2 *
                                                      SizeConfig.textMultiplier,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "$fromDate",
                                                  style: textstyle,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 40),
                                                child: Text(
                                                  "to",
                                                  style: textstyle,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "$toDate",
                                                  style: textstyle,
                                                ),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              height: 5 *
                                                  SizeConfig.heightMultiplier,
                                              width: 60 *
                                                  SizeConfig.widthMultiplier,
                                              child: TextField(
                                                controller: seaarchController,
                                                decoration: InputDecoration(
                                                    hintText: "Search",
                                                    hintStyle: TextStyle(
                                                        fontSize: 2 *
                                                            SizeConfig
                                                                .textMultiplier),
                                                    border: InputBorder.none,
                                                    suffixIcon: InkWell(
                                                      onTap: () {
                                                        seaarchController
                                                            .clear();
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 2.5 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                      ),
                                                    ),
                                                    prefixIcon: InkWell(
                                                      onTap: () {
                                                        searchReportType(
                                                            widget.params,
                                                            seaarchController
                                                                .text);
                                                      },
                                                      child: Icon(
                                                        Icons.search,
                                                        size: 2.5 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                      ),
                                                    )),
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
                                              "Total Transactions :",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 2.2 *
                                                      SizeConfig.textMultiplier,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: datarecieved == null
                                                ? Text("₹ 0",
                                                    style: TextStyle(
                                                        fontFamily: 'arvo',
                                                        color: Colors.white,
                                                        fontSize: 2.2 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.w600))
                                                : Text(
                                                    "₹ ${datarecieved['totalTransactionAmount']}",
                                                    style: TextStyle(
                                                        fontFamily: 'arvo',
                                                        color: Colors.white,
                                                        fontSize: 2.2 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                width: 133 * SizeConfig.widthMultiplier,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: [
                                    rechargeAndBillpayments(),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 4),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Apptheme.PrimaryColor,
                                  textColor: Apptheme.whitetextcolor,
                                  child: Text("Save CSV"),
                                  onPressed: () {
                                    getCsv();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
      ),
    );
  }

  getCsv() async {
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    sessionToken = logindata['sessionToken'];
    refreshToken = logindata['refreshToken'];
    loginId = logindata['user']['_id'];
    print(params);
    print(fromDate);
    print(toDate);
    Map pdfdata = {
      "filter": {
        "fromDate": fromDate,
        "toDate": toDate,
        "userId": loginId,
        "subdomain": "instantpay",
        "reportType": params,
        "searchString": seaarchController.text
      }
    };

    var response = await http.post(COMMON_API + '/exportReport',
        body: jsonEncode(pdfdata),
        headers: {
          "Content-type": "application/json",
          "authorization": sessionToken,
          "refreshToken": refreshToken
        });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Saved Successfully");
      print(response.body);
      saveAndLaunchFile(response.bodyBytes, "Report_${DateTime.now()}.csv");
    } else {
      Fluttertoast.showToast(msg: "Something went Wrong");

      print(response.statusCode);
    }
  }
}
