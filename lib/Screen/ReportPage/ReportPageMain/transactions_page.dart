import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/report_page.dart';
import 'package:netly/Services/serviceslist.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  var fromDate = DateTime.now();
  var toDate = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: reportlist.length,
          itemBuilder: (context, index) {
            print(  DateFormat("yyyy-MM-dd").format(fromDate));
            print(DateFormat("yyyy-MM-dd").format(toDate));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportPage(
                              data: reportlist[index].title,
                              params: reportlist[index].params,
                              fromDate:
                                  DateFormat("yyyy-MM-dd").format(fromDate),
                              toDate: DateFormat("yyyy-MM-dd").format(toDate)),
                        ));
                  },
                  leading: SvgPicture.asset(
                    "${reportlist[index].icon}",
                    height: 7 * SizeConfig.imageSizeMultiplier,
                  ),
                  title: Text(
                    reportlist[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Apptheme.PrimaryColor),
                  ),
                  subtitle: Text(reportlist[index].subtitle),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Apptheme.PrimaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
