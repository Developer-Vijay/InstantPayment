import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/add_balance.dart';
import 'package:http/http.dart' as http;
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/request_filter_page.dart';
import 'package:netly/Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class PaymentRequestReport extends StatefulWidget {
  final fromDate;
  final toDate;
  PaymentRequestReport({this.toDate, this.fromDate});
  @override
  _PaymentRequestReportState createState() => _PaymentRequestReportState();
}

class _PaymentRequestReportState extends State<PaymentRequestReport> {
  @override
  void initState() {
    super.initState();

    setState(() {
      fromDate = widget.fromDate;
      toDate = widget.toDate;
    });
    print("from date is  $fromDate");
    print(toDate);
    Future.delayed(Duration.zero, () {
      getReportType();
    });
  }

  List jsondata = [];
  var retrieveLogin;
  var logindata;
  var sessionToken;
  var refreshToken;
  var loginId;
  var fromDate;
  var toDate;
  var datarecieved;
  var index1;
  bool datachecker = false;
  bool checker2 = false;
  getReportType() async {
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
    try {
      var response = await http.get(
          Uri.parse(PORTAL_API +
              '/getPaymentRequestList' +
              '?filter={"fromDate":"$fromDate","toDate":"$toDate"}&limit=10&page=1&userId=$loginId'),
          headers: {
            "Content-type": "application/json",
            "authorization": sessionToken,
            "refreshToken": refreshToken
          });
      datarecieved = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(datarecieved['paymentRequests']['docs'].length);
        setState(() {
          datachecker = true;
          checker2 = false;
          print(loginId);
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
    } catch (e) {
      print(e);
    }
  }

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
      // onWillPop: _onbackPressed,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
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
                              topRight: const Radius.circular(10.0))),
                      height: 40 * SizeConfig.heightMultiplier,
                      child: RequestFilterPage()));
            },
            child: Icon(Icons.filter_alt_sharp),
          ),
          appBar: AppBar(
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minWidth: 20 * SizeConfig.widthMultiplier,
                child: Text("Request"),
                textColor: Apptheme.whitetextcolor,
                // color: Apptheme.PrimaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddBalancePage()));
                },
              )
            ],
            title: Text("Request Report"),
          ),
          body: ListView(shrinkWrap: true, children: [
            SizedBox(
              height: 2.5 * SizeConfig.heightMultiplier,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: datarecieved == null
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
                    : datarecieved['paymentRequests']['docs'].length == 0
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
                              DataColumn(label: Text("Id")),
                              DataColumn(label: Text("requestedBy")),
                              DataColumn(label: Text("Amount")),
                              DataColumn(label: Text("requestedTo")),
                              DataColumn(label: Text("requestType")),
                              DataColumn(label: Text("requestedOn ")),
                              DataColumn(label: Text("depositDate")),
                              DataColumn(label: Text("requested userId")),
                              DataColumn(label: Text("Status")),
                              DataColumn(label: Text("requested Reason")),
                              DataColumn(label: Text("BankRef Id")),
                              DataColumn(label: Text("Created Date")),
                              // DataColumn(label: Text("Updated Date")),
                            ],
                            rows: List.generate(
                                datarecieved['paymentRequests']['docs'].length,
                                (index) {
                              return DataRow(cells: [
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['_id']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestedByUserName']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['amount']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestedToName']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestType']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestedOn']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['depositedDate']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestedTo']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['status']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['requestedReason']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['bankReferenceId']}")),
                                DataCell(Text(
                                    "${datarecieved['paymentRequests']['docs'][index]['creationDate']}")),
                                // DataCell(Text(
                                //     "${datarecieved['paymentRequests']['docs'][index]['']}")
                                //     ),
                              ]);
                            }))),
            SizedBox(
              height: 0 * SizeConfig.heightMultiplier,
            ),
            // Center(
            //     child: MaterialButton(
            //   child: Text("Filter"),
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   minWidth: 60 * SizeConfig.widthMultiplier,
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //   onPressed: () {
            //     showModalBottomSheet(
            //         elevation: 4.0,
            //         isScrollControlled: true,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         context: context,
            //         builder: (context) => Container(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.only(
            //                     topLeft: const Radius.circular(10.0),
            //                     topRight: const Radius.circular(10.0))),
            //             height: 40 * SizeConfig.heightMultiplier,
            //             child: RequestFilterPage()
            //             )
            //             );
            //   },
            // )),
          ])),
    );
  }
}
