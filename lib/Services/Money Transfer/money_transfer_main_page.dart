// import 'package:flutter/material.dart';
// import 'package:netly/Services/Money%20Transfer/add_user.dart';
// import 'package:netly/Services/Money%20Transfer/login_user.dart';

// class MoneyTransferMainPage extends StatefulWidget {
//   @override
//   _MoneyTransferMainPageState createState() => _MoneyTransferMainPageState();
// }

// class _MoneyTransferMainPageState extends State<MoneyTransferMainPage>
//     with TickerProviderStateMixin {
//   TextEditingController numberController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   void initState() {
//     super.initState();
//     controller = TabController(
//       length: list.length,
//       vsync: this,
//     );

//     controller.addListener(() {
//       setState(() {
//         selectedIndex = controller.index;
//       });
//       print("Selected Index: " + controller.index.toString());
//     });
//   }

//   List<Widget> list = [
//     Tab(
//       child: Text(
//         "Add User",
//         style: TextStyle(fontWeight: FontWeight.w600),
//       ),
//     ),
//     Tab(
//       child: Text("Login"),
//     ),
//   ];
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   TabController controller;
//   int selectedIndex = 0;

//   var numberValidate;
//   var firstNameValidate;
//   var lastNameValidate;

//   // ignore: unused_field
//   bool _isValidate = false;
//   bool firstname = false;
//   bool lastname = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text("Money Transfer"),
//               bottom: TabBar(
//                   indicatorPadding: EdgeInsets.only(left: 10),
//                   controller: controller,
//                   tabs: list),
//             ),
//             body: TabBarView(
//               controller: controller,
//               children: [
//                 AddUser(controller: controller, selectedindex: selectedIndex),
//                 LoginUser(
//                   controller: controller,
//                   selectedindex: selectedIndex,
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
