import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Money%20Transfer/transfer_money.dart';
import 'package:netly/Services/serviceslist.dart';
import 'package:netly/constants.dart';

// ignore: must_be_immutable
class RecipientPage extends StatefulWidget {
  final data;
  final apiData;

  TabController controller;
  int selectedIndex;

  RecipientPage({this.controller, this.selectedIndex, this.data, this.apiData});

  @override
  _RecipientPageState createState() => _RecipientPageState();
}

class _RecipientPageState extends State<RecipientPage> {
  var number;
  bool show = false;
  TextEditingController searhed = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      number = widget.data;
      responseData = widget.apiData;
      filter = searhed.text;
      // condition();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searhed.dispose();
  }

  var responseData;
  var filter;

  Widget condition() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        if (searhed.text == null || searhed.text == "") {
          return data();
        } else if (searhed.text ==
            responseData['beneficiaryList'][index]['name']) {
          setState(() {});
          print("workibng");
          return _buildRow(index);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildRow(data1) {
    return ListTile(
      title: responseData['beneficiaryList'][data1]['name'],
    );
  }

  Widget data() {
    return ListView.builder(
      itemCount: responseData['beneficiaryList'].length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      child: responseData['beneficiaryList'] == null
                          ? Text("Name in the Bank Account",
                              style: TextStyle(fontWeight: FontWeight.w500))
                          : Text(
                              "${responseData['beneficiaryList'][index]['name']}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check,
                      color: Colors.green[600],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      child: responseData['beneficiaryList'] == null
                          ? Text("Bank Name",
                              style: TextStyle(fontWeight: FontWeight.w500))
                          : Text(
                              "${responseData['beneficiaryList'][index]['bank_name']}"),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransferMoney(
                                  bankname: responseData['beneficiaryList']
                                      [index]['bank_name'],
                                  name: responseData['beneficiaryList'][index]
                                      ['name'],
                                  number: responseData['beneficiaryList'][index]
                                      ['customer_number'],
                                  accountNumber: responseData['beneficiaryList']
                                      [index]['account_number'],
                                  ifscCode: responseData['beneficiaryList']
                                      [index]['ifsc'],
                                  beneId: responseData['beneficiaryList'][index]
                                      ['beneId'],
                                ),
                              ));
                        },
                        child: Icon(
                          Icons.send_outlined,
                          color: Apptheme.PrimaryColor,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      child: responseData['beneficiaryList'] == null
                          ? Text("Bank Account Number",
                              style: TextStyle(fontWeight: FontWeight.w500))
                          : Text(
                              "${responseData['beneficiaryList'][index]['account_number']}"),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          banklist.remove(banklist[index]);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: Apptheme.textColo1r,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 3 * SizeConfig.heightMultiplier,
          ),
InkWell(
  onTap: (){
      showSearch(
                context: context,
                delegate: Searchbar(hintText: "Search"),
              );
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: SizeConfig.heightMultiplier * 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all()),
      child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search,color: Apptheme.PrimaryColor,),
        ),
        // Spacer(),
        SizedBox(width: SizeConfig.widthMultiplier * 4,),
        Text("Search",style: TextStyle(color: Colors.grey,fontSize: SizeConfig.textMultiplier * 2.5),),
        Spacer(),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.clear,color: Apptheme.PrimaryColor,),
        ),

      ],
    ),),
  )),
        
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier,
          ),
          Container(
              child: responseData == null
                  ? Center(child: Text("Loading....."))
                  : condition())
        ],
      ),
    );
  }
}

class Searchbar extends SearchDelegate<String> {
  Searchbar({
    String hintText,
  }) : super(
          keyboardType: TextInputType.name,
          searchFieldLabel: hintText,
        );
  List username = List.generate(named.length, (index) => named[index].name);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    print(username);
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = " ";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return Card(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final mylist = query.isEmpty
        ? named
        : named
            .where((p) => p.name.toString().toLowerCase().startsWith(query))
            .toList();

    return Container(
      child: mylist.isEmpty
          ? Center(
              child: Text(
              "No results Found",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                final Name name = mylist[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransferMoney(
                              bankname: name.bankname,
                              name: name.name,
                              number: name.mobileNumber,
                              accountNumber: name.accountnumber,
                              ifscCode: name.ifscCode,
                              beneId: name.beneId),
                        ));
                  },
                  child: Column(
                    children: [
                      Divider(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                name.name,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check,
                              color: Colors.green[600],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Text(name.bankname),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TransferMoney(
                                            bankname: name.bankname,
                                            name: name.name,
                                            number: name.mobileNumber,
                                            accountNumber: name.accountnumber,
                                            ifscCode: name.ifscCode,
                                            beneId: name.beneId),
                                      ));
                                },
                                child: Icon(
                                  Icons.send_outlined,
                                  color: Apptheme.PrimaryColor,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              child:
                                  // responseData['beneficiaryList'] == null
                                  //     ? Text("Bank Account Number",
                                  //         style: TextStyle(fontWeight: FontWeight.w500))
                                  Text("${name.accountnumber}"),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  banklist.remove(banklist[index]);
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Apptheme.textColo1r,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                    ],
                  ),
                );
              },
              itemCount: mylist.length,
            ),
    );
  }
}
