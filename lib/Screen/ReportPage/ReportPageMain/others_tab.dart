// import 'package:flutter/material.dart';

// class Othertab extends StatefulWidget {
//   @override
//   _OthertabState createState() => _OthertabState();
// }

// class _OthertabState extends State<Othertab> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: reportlist.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               elevation: 2,
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ReportPage(
//                           data: reportlist[index].title,
//                         ),
//                       ));
//                 },
//                 leading: SvgPicture.asset(
//                   "${reportlist[index].icon}",
//                   height: 30,
//                 ),
//                 title: Text(
//                   reportlist[index].title,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Apptheme.PrimaryColor),
//                 ),
//                 subtitle: Text(reportlist[index].subtitle),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios,
//                   color: Apptheme.PrimaryColor,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),,
//     );
//   }
// }