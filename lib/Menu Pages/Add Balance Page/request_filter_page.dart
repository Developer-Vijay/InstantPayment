import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Menu%20Pages/Add%20Balance%20Page/payment_requst_report.dart';

class RequestFilterPage extends StatefulWidget {
  @override
  _RequestFilterPageState createState() => _RequestFilterPageState();
}

class _RequestFilterPageState extends State<RequestFilterPage> {
  DateTime selectedDate = DateTime.now();

  DateTime toDate = DateTime.now();
  int selectedradiotile;
  void initState() {
    super.initState();
    selectedradiotile = 0;
  }

  setSelectedradioTile(int value) {
    setState(() {
      selectedradiotile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
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
                        : Text("${toDate.day}-${toDate.month}-${toDate.year}"),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentRequestReport(
                          fromDate: selectedDate.toLocal(),
                          toDate: toDate.toLocal(),
                          // fromDate:
                          //     DateFormat("yyyy-MM-dd").format(selectedDate),
                          // toDate: DateFormat("yyyy-MM-dd").format(toDate),
                        ),
                      ));
                      // Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text("Apply"),
              ),
            ),
          ],
        )
      ],
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
        // selectedDate = fromDate.toLocal();
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
        // toDate = newd.toLocal();
        // print(newd);
      });
  }
}
