import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Screen/ReportPage/report_page.dart';
import 'package:netly/Services/serviceslist.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: reportlist.length,
        itemBuilder: (context, index) {
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
                        ),
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
    );
  }
}
