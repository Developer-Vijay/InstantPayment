import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/report_page.dart';
import 'package:intl/intl.dart';

class Filter extends StatefulWidget {
  final title;
  final param;

  const Filter({
    this.title,
    this.param,
  });
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  DateTime selectedDate = DateTime.now();

  DateTime toDate = DateTime.now();
  int selectedradiotile;
  void initState() {
    super.initState();
    selectedradiotile = 0;
    params = widget.param;
  }

  setSelectedradioTile(int value) {
    setState(() {
      selectedradiotile = value;
    });
  }

  var params;
  // List jsondata = [];
  // var retrieveLogin;
  // var logindata;

  // var sessionToken;
  // var refreshToken;
  // var loginId;
  // var datarecieved;
  // var index1;
  // bool datachecker = false;
  // bool checker2 = false;
  // getReportType(var param) async {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (_) => Container(
  //           color: Colors.white,
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           )));
  //   final prefs = await SharedPreferences.getInstance();
  //   retrieveLogin = prefs.getString('loginInfo');
  //   logindata = jsonDecode(retrieveLogin);
  //   sessionToken = logindata['sessionToken'];
  //   refreshToken = logindata['refreshToken'];
  //   loginId = logindata['user']['_id'];
  //   print("?????????");
  //   print(loginId);
  //   print("?????????");
  //   try {
  //     var response = await http.get(
  //         Uri.parse(COMMON_API +
  //             '/getReports' +
  //             '?filter={"fromDate":"$selectedDate","toDate":"$toDate","subdomain":"instantpay","reportType":"$params"}&limit=20&page=1'),
  //         headers: {
  //           "Content-type": "application/json",
  //           "authorization": sessionToken,
  //           "refreshToken": refreshToken
  //         });
  //     datarecieved = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       // print(datarecieved['reports']['docs'].length);
  //       setState(() {
  //         datachecker = true;
  //         checker2 = false;
  //       });

  //       print(datarecieved);
  //       print(response.body);

  //       Navigator.pop(context);
  //     } else {
  //       setState(() {
  //         datachecker = false;
  //         checker2 = true;
  //       });
  //       Navigator.pop(context);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Filter"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //         hintText: "Search",
          //         suffixIcon: Icon(Icons.close),
          //         prefixIcon: Icon(Icons.search)),
          //   ),
          // ),

          // Divider(),
          SizedBox(
            height: 2 * SizeConfig.heightMultiplier,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select From Date",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 2.2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 40 * SizeConfig.widthMultiplier,
                    height: 5.4 * SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: selectedDate == DateTime.now()
                          ? Text("Select Date")
                          : Text(
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select To Date",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 2.2 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 40 * SizeConfig.widthMultiplier,
                    height: 5.4 * SizeConfig.heightMultiplier,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: () {
                        _selectedDate(context);
                      },
                      child: toDate == DateTime.now()
                          ? Text("Select Date")
                          : Text(
                              "${toDate.day}-${toDate.month}-${toDate.year}"),
                    )),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Apptheme.textColo1r,
                  textColor: Apptheme.whitetextcolor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text("Cancel"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Apptheme.PrimaryColor,
                  textColor: Apptheme.whitetextcolor,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportPage(
                            data: widget.title,
                            params: params,
                            fromDate:
                                DateFormat("yyyy-MM-dd").format(selectedDate),
                            toDate: DateFormat("yyyy-MM-dd").format(toDate),
                          ),
                        ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text("Apply"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        helpText: "Select  Date",
        confirmText: "Confirm");
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        helpText: "Select  Date",
        confirmText: "Confirm");
    if (picked != null && picked != toDate)
      setState(() {
        toDate = picked;
      });
  }
}
