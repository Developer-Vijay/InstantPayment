// import 'package:flutter/material.dart';
// import 'package:netly/Components/Resources/sizeconfig.dart';
// import 'package:netly/Components/Resources/styling.dart';

// import '../serviceslist.dart';

// class VerifiedData extends StatefulWidget {
//   @override
//   _VerifiedDataState createState() => _VerifiedDataState();
// }

// class _VerifiedDataState extends State<VerifiedData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Verification"),
//       ),
//       body: ListView(
//         children: [
//           SizedBox(
//             height: 5 * SizeConfig.widthMultiplier,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Apptheme.PrimaryColor, border: Border.all()),
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 1,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Monthly",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             SizedBox(
//                               width: 15 * SizeConfig.widthMultiplier,
//                             ),
//                             Text("Spent:",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600)),
//                             SizedBox(
//                               width: 2.1 * SizeConfig.widthMultiplier,
//                             ),
//                             Text(add[index].spent,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ))
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text("Limit:",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600)),
//                             SizedBox(
//                               width: 2.1 * SizeConfig.widthMultiplier,
//                             ),
//                             Text(add[index].limit,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w700))
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 2 * SizeConfig.heightMultiplier,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               decoration: BoxDecoration(border: Border.all()),
//               child: ListView.builder(
//                 itemCount: 1,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(border: Border.all()),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Text("Mode",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600)),
//                               Spacer(),
//                               Text("${add[index].mode}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500))
//                             ],
//                           ),
//                           Divider(),
//                           Row(
//                             children: [
//                               Text("IMPS",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600)),
//                               Spacer(),
//                               Text("${add[index].imps}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500))
//                             ],
//                           ),
//                           Divider(),
//                           Row(
//                             children: [
//                               Text("NEFT",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600)),
//                               Spacer(),
//                               Text("${add[index].neft}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500))
//                             ],
//                           ),
//                           Divider(),
//                           Row(
//                             children: [
//                               Text("Verification",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600)),
//                               Spacer(),
//                               Text("${add[index].verification}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500))
//                             ],
//                           ),
//                           Divider(),
//                           Row(
//                             children: [
//                               Text("Bulk-transfer",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600)),
//                               Spacer(),
//                               Text("${add[index].bulktransfer}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500))
//                             ],
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.all(8.0),
//                           //   child: MaterialButton(
//                           //     shape: RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.circular(10)),
//                           //     height: 6 * SizeConfig.heightMultiplier,
//                           //     textColor: Apptheme.whitetextcolor,
//                           //     color: Apptheme.PrimaryColor,
//                           //     onPressed: () {
//                           //       Navigator.push(
//                           //           context,
//                           //           MaterialPageRoute(
//                           //               builder: (context) => AddBeneficiary()));
//                           //     },
//                           //     child: Text(
//                           //       "Add Benificiary",
//                           //       style: TextStyle(
//                           //           fontSize: 2.1 * SizeConfig.textMultiplier),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ));
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
