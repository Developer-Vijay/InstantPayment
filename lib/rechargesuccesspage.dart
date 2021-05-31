import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/home_screen.dart';

class RechargeSuccessPage extends StatefulWidget {
  final responseData;
  final amount;
  final number;
  final date;
  final orderId;

  RechargeSuccessPage(
      {this.responseData, this.amount, this.date, this.number, this.orderId});
  @override
  _RechargeSuccessPageState createState() => _RechargeSuccessPageState();
}

class _RechargeSuccessPageState extends State<RechargeSuccessPage> {
  var responseData;
  var amount;
  var number;
  var date;
  var orderId;
  @override
  void initState() {
    super.initState();
    responseData = widget.responseData;
    amount = widget.amount;
    number = widget.number;
    date = widget.date;
    orderId = widget.orderId;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_statements
    var time = date;
    // var format=DateFormat("").format(time);
    DateTime dateTime = DateTime.parse(time);
    dateTime.toLocal();
    var timedis =
        "${dateTime.day}/${dateTime.month}/${dateTime.year},${dateTime.hour}:${dateTime.minute}";
    print(
        "${dateTime.day}/${dateTime.month}/${dateTime.year},${dateTime.hour}:${dateTime.minute}");
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
          body: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black12,
                      spreadRadius: 5,
                    )
                  ]),
                  child: ClipPath(
                    child: Container(
                      color: Apptheme.PrimaryColor,
                      width: SizeConfig.widthMultiplier * 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "$number",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Apptheme.whitetextcolor),
                                ),
                              ),
                              // Spacer(),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: InkWell(
                              //       onTap: () {},
                              //       child: Text(
                              //         "View Receipt",
                              //         style: TextStyle(
                              //             color: Apptheme.PrimaryColor,
                              //             fontWeight: FontWeight.bold),
                              //       )),
                              // )
                            ],
                          ),
                          SvgPicture.asset("assets/icon/check.svg",
                              height: SizeConfig.imageSizeMultiplier * 20),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          Text(
                            "₹ $amount",
                            style: TextStyle(
                                fontFamily: ' ',
                                fontWeight: FontWeight.w600,
                                color: Apptheme.whitetextcolor,
                                fontSize: SizeConfig.textMultiplier * 2.5),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          Text(
                            "Payment Success!",
                            style: TextStyle(
                                fontFamily: ' ',
                                fontWeight: FontWeight.w600,
                                color: Apptheme.whitetextcolor,
                                fontSize: SizeConfig.textMultiplier * 3.5),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 3,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 5,
                          child: ListView(
                            children: [
                              Center(
                                child: Text(
                                  "Payment Reciept",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          SizeConfig.textMultiplier * 2.5),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Amount"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "₹ $amount",
                                      style: TextStyle(fontFamily: ""),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mobile Number"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("$number"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Operaotor Id"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("$orderId"),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1,
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Date and Time"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("$timedis"),
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Payment Method"),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Wallet"),
                                  )
                                ],
                              )
                            ],
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: MaterialButton(
                              color: Colors.grey[100],
                              textColor: Colors.blue,
                              minWidth: SizeConfig.widthMultiplier * 100,
                              height: SizeConfig.heightMultiplier * 20,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              },
                              child: Text(
                                "Go To Homepage",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
