import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Services/Money%20Transfer/transfer_money.dart';
import 'package:netly/Services/serviceslist.dart';

class RecipientPage extends StatefulWidget {
  TabController controller;
  int selectedIndex;

  RecipientPage({this.controller, this.selectedIndex});

  @override
  _RecipientPageState createState() => _RecipientPageState();
}

class _RecipientPageState extends State<RecipientPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  prefixIcon: Icon(Icons.clear),
                  hintText: "Search"),
            ),
          ),
        ),
        SizedBox(
          height: 3 * SizeConfig.heightMultiplier,
        ),
        ListView.builder(
          itemCount: banklist.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Text("${banklist[index].name}"),
                        Spacer(),
                        Icon(Icons.check)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Text("${banklist[index].bankName}"),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TransferMoney(
                                      bankname: banklist[index].bankName,
                                      name: banklist[index].name,
                                      number: banklist[index].accountNumber,
                                    ),
                                  ));
                            },
                            child: Icon(Icons.send_outlined)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Text("${banklist[index].accountNumber}"),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            banklist.remove(banklist[index]);
                          },
                          child: Icon(Icons.delete_outline))
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
