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
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Name of Service",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 2 * SizeConfig.textMultiplier),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text(
              //         "Success",
              //         style: TextStyle(
              //             color: Colors.green[600],
              //             fontWeight: FontWeight.w600,
              //             fontSize: 2 * SizeConfig.textMultiplier),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text("Failed",
              //           style: TextStyle(
              //               color: Colors.red[600],
              //               fontWeight: FontWeight.w600,
              //               fontSize: 2 * SizeConfig.textMultiplier)),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Text("Pending",
              //           style: TextStyle(
              //               color: Colors.amber[700],
              //               fontWeight: FontWeight.w600,
              //               fontSize: 2 * SizeConfig.textMultiplier)),
              //     )
              //   ],
              // ),
              // Container(
              //   margin: EdgeInsets.all(4),
              //   padding: EdgeInsets.all(4),
              //   decoration: BoxDecoration(
              //       // color: Colors.blue,
              //       border: Border.all(color: Colors.grey)),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Expanded(
              //             child: Container(
              //                 // color: Colors.red,
              //                 child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 SizedBox(
              //                   height: 0 * SizeConfig.heightMultiplier,
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     "Recharge",
              //                     style: headstyle,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 5 * SizeConfig.heightMultiplier,
              //                 ),
              //                 Divider(),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     "Bill Payments",
              //                     style: headstyle,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 5 * SizeConfig.heightMultiplier,
              //                 ),
              //                 Divider(),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     "Money Transfer",
              //                     style: headstyle,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 5 * SizeConfig.heightMultiplier,
              //                 ),
              //                 Divider(),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Text(
              //                     "AEPS",
              //                     style: headstyle,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 2 * SizeConfig.heightMultiplier,
              //                 ),
              //               ],
              //             )),
              //           ),
              //           Expanded(
              //             flex: 2,
              //             child: Container(
              //                 height: 57 * SizeConfig.heightMultiplier,
              //                 // color: Colors.amber,
              //                 child: Column(
              //                   children: [
              //                     SizedBox(
              //                       height: 2.5 * SizeConfig.heightMultiplier,
              //                     ),
              //                     Row(
              //                       children: [
              //                         SizedBox(
              //                           width: 5 * SizeConfig.heightMultiplier,
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text(
              //                             "1",
              //                             style: dataStyle,
              //                           ),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("0", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("2", style: dataStyle),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 3.58 * SizeConfig.heightMultiplier,
              //                     ),
              //                     Divider(),
              //                     Row(
              //                       children: [
              //                         SizedBox(
              //                           width: 5 * SizeConfig.heightMultiplier,
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("1", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("0", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("2", style: dataStyle),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 9.3 * SizeConfig.heightMultiplier,
              //                     ),
              //                     Divider(),
              //                     Row(
              //                       children: [
              //                         SizedBox(
              //                           width: 5 * SizeConfig.heightMultiplier,
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("1", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("0", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("2", style: dataStyle),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 9.3 * SizeConfig.heightMultiplier,
              //                     ),
              //                     Divider(),
              //                     Row(
              //                       children: [
              //                         SizedBox(
              //                           width: 5 * SizeConfig.heightMultiplier,
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("1", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("0", style: dataStyle),
              //                         ),
              //                         Spacer(),
              //                         Padding(
              //                           padding: const EdgeInsets.all(8.0),
              //                           child: Text("2", style: dataStyle),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 )),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // Container(

              //   child: Row(
              //     children: [

              //       Expanded(
              //         flex: 2,
              //         child: Container(
              //           decoration: BoxDecoration(border: Border.all()),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("Recharge"),
              //               ),
              //               Divider(
              //                 color: Colors.black,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("AEPS"),
              //               ),
              //               Divider(),
              //               Padding(
              //                 padding: const EdgeInsets.all(8.0),
              //                 child: Text("AEPS"),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //        Expanded(
              //          flex: 6,
              //          child: Container(
              //            decoration: BoxDecoration(border: Border.all()),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Text("Success"),
              //                 ],
              //               ),
              //             ],
              //           ),
              //       ),
              //        ),
              //     ],
              //   ),
              // )
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
          //  Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 10),
          //   child: ListView.builder(
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: stautusData.length,
          //     itemBuilder: (context, index) {
          //       return Card(
          //         shadowColor: Colors.grey[400],
          //         elevation: 10,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10)),
          //         // semanticContainer: false,
          //         child: Container(
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               // gradient: LinearGradient(
          //               //   begin: Alignment.topRight,
          //               //   end: Alignment.bottomRight,
          //               //   colors: [
          //               //   Colors.blue,
          //               //   Colors.white10,

          //               // ]),
          //               border: Border.all(color: Colors.grey)),
          //           // color: Colors.blue,
          //           child: Column(
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text(
          //                   stautusData[index].title,
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.w600,
          //                       fontSize: 2.2 * SizeConfig.textMultiplier),
          //                 ),
          //               ),
          //               Text(stautusData[index].totalCount,
          //                   style: TextStyle(fontWeight: FontWeight.w600)),
          //               Column(
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text(
          //                           "Success",
          //                           style: TextStyle(
          //                               color: Colors.green[600],
          //                               fontWeight: FontWeight.w700),
          //                         ),
          //                       ),
          //                       Spacer(),
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text(
          //                           stautusData[index].success,
          //                           style: TextStyle(fontWeight: FontWeight.w600),
          //                         ),
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //               Spacer(),
          //               Column(
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text("Failed",
          //                             style: TextStyle(
          //                                 color: Colors.red[600],
          //                                 fontWeight: FontWeight.w700)),
          //                       ),
          //                       Spacer(),
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text(
          //                           stautusData[index].failed,
          //                           style: TextStyle(fontWeight: FontWeight.w600),
          //                         ),
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               ),
          //               Spacer(),
          //               Column(
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text("Pending",
          //                             style: TextStyle(
          //                                 color: Colors.amber[600],
          //                                 fontWeight: FontWeight.w700)),
          //                       ),
          //                       Spacer(),
          //                       Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text(
          //                           stautusData[index].pending,
          //                           style: TextStyle(fontWeight: FontWeight.w600),
          //                         ),
          //                       ),
          //                     ],
          //                   )
          //                 ],
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     //     crossAxisCount: 2, crossAxisSpacing: 6, mainAxisSpacing: 50),
          //   ),
          // )
          ),
    );
  }
}
