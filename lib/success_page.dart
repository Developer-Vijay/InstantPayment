import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';

import 'Screen/home_screen.dart';

class SuccessPage extends StatefulWidget {
  final title;
  final responseData;
  SuccessPage({this.responseData, this.title});
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  var title;
  var responseData;
  @override
  void initState() {
    super.initState();
    setState(() {
      title = widget.title;
      responseData = widget.responseData;
    });
  }

  var time;

  @override
  Widget build(BuildContext context) {
    var time = responseData['transactionData']['transactionDate'];
    // var format=DateFormat("").format(time);
    DateTime dateTime = DateTime.parse(time);
    dateTime.toLocal();
    var timedis =
        "${dateTime.day}/${dateTime.month}/${dateTime.year} , ${dateTime.hour}:${dateTime.minute}";
    print(
        "${dateTime.day}/${dateTime.month}/${dateTime.year} , ${dateTime.hour}:${dateTime.minute}");
    print("${dateTime.hour}:${dateTime.minute}");
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(),
          body: ListView(
            children: [
              Center(
                child: Text(
                  "$title",
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Tranaction Done",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      // "",
                      "₹${responseData['transactionData']['transactionAmount']}",
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 5,
                          fontFamily: ''),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin:
                        EdgeInsets.only(right: SizeConfig.widthMultiplier * 5),
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.heightMultiplier * 6,
                    child: Icon(
                      Icons.check,
                      size: SizeConfig.imageSizeMultiplier * 5,
                      color: Apptheme.whitetextcolor,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    // "",
                    "$timedis"),
              ),

              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  "To",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 2, top: 2),
                    child: Text(
                      "${responseData['transactionData']['shopName']}",
                      style:
                          TextStyle(fontSize: SizeConfig.textMultiplier * 2.5),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/icon/shops.svg",
                      height: SizeConfig.imageSizeMultiplier * 8,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${responseData['transactionData']['userPhone']}",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text(
                  "From",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, bottom: 2, top: 2),
                    child: Text(
                      "${responseData['transactionData']['bankName']}",
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2,
                          color: Colors.black54),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/icon/bank.svg",
                      height: SizeConfig.imageSizeMultiplier * 8,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 2, top: 2),
                child: Text(
                  "ac/no. ${responseData['transactionData']['accountNumber']}",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "${responseData['transactionData']['transferMode']}",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 2, top: 2),
                child: Text(
                  "${responseData['transactionData']['beneName']}",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 2, top: 2),
                child: Text(
                  "${responseData['transactionData']['mobile']}",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Center(
                child: Text(
                  "${responseData['transactionData']['status']}",
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 3,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "*Terms & Condition:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "1. it will full responsibility of customer to provide the complete and correct details of beneficiary.",
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "2. Bank Name, Account Numberr and Amount should be given by customer.Bene Verification is avaliable for Account Number Verification.",
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "3.it's up to customer whether he/she wants to verify or not. if customer has given wrong account detials,retailer is not responsible for that however customer's branch can help in those case.   ",
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "4.This is a server generated response,hence no signature required.",
                  maxLines: 3,
                ),
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       child: Text(
              //         "Shop Name :",
              //         style: TextStyle(
              //             fontSize: SizeConfig.textMultiplier * 2.3,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 20.0),
              //       child: Text(
              //         "OM COMM",
              //         style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.2),
              //       ),
              //     ),
              //     // Spacer()
              //   ],
              // ),
              // SizedBox(
              //   height: SizeConfig.heightMultiplier * 2,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       child: Text(
              //         "Contact Number :",
              //         style: TextStyle(
              //             fontSize: SizeConfig.textMultiplier * 2.3,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 20.0),
              //       child: Text(
              //         "224412124",
              //         style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.2),
              //       ),
              //     ),
              //     // Spacer()
              //   ],
              // ),
              // SizedBox(
              //   height: SizeConfig.heightMultiplier * 2,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       child: Text(
              //         "Date and Time :",
              //         style: TextStyle(
              //             fontSize: SizeConfig.textMultiplier * 2.3,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 20.0),
              //       child: Text(
              //         "5/21/2021",
              //         style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.2),
              //       ),
              //     ),
              //     // Spacer()
              //   ],
              // ),
              // Divider(
              //   color: Colors.black,
              //   thickness: 1,
              // ),
              //  SizedBox(
              //   height: SizeConfig.heightMultiplier * 2,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 5.0),
              //       child: Text(
              //         "Transaction Details :",
              //         style: TextStyle(
              //             fontSize: SizeConfig.textMultiplier * 2,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 5.0),
              //       child: Text(
              //         "Beneficiary Details",
              //         style: TextStyle(
              //             fontSize: SizeConfig.textMultiplier * 2,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     // Spacer()
              //   ],
              // ),
              //  SizedBox(
              //   height: SizeConfig.heightMultiplier * 2,
              // ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 5.0),
              //       child: Column(
              //         children: [
              //           Text(
              //             "Transaction",
              //             style: TextStyle(
              //                 fontSize: SizeConfig.textMultiplier * 1.5,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //           Text("Amount :", style: TextStyle(
              //                 fontSize: SizeConfig.textMultiplier * 1.5,
              //                 fontWeight: FontWeight.w600))
              //         ],
              //       ),
              //     ),
              //     SizedBox(width: SizeConfig.widthMultiplier * 8,),
              //     Text("5"),
              //     Spacer(),

              //     Text("Account No.",style: TextStyle(
              //                 fontSize: SizeConfig.textMultiplier * 1.5,
              //                 fontWeight: FontWeight.w600)),
              //   SizedBox(width: SizeConfig.widthMultiplier * 2,),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 5.0),
              //       child: Text(
              //         "1444455444",
              //         style: TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
              //       ),
              //     ),
              //     // Spacer()
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
