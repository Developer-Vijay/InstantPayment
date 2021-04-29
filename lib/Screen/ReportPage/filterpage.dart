import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/list.dart';

class Filter extends StatefulWidget {
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
  }

  setSelectedradioTile(int value) {
    setState(() {
      selectedradiotile = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Filter"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.close),
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 1,
                childAspectRatio: 3),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: radio.length,
            itemBuilder: (context, index) {
              return 
              RadioListTile(
                value: radio[index].value,
                groupValue: selectedradiotile,
                onChanged: (value) {
                  setSelectedradioTile(value);
                },
                selected: true,
                title: Text("${radio[index].head}"),
              );
            },
          ),
          Divider(),
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
                  onPressed: () {},
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
        lastDate: DateTime(2030),
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
        lastDate: DateTime(2030),
        helpText: "Select  Date",
        confirmText: "Confirm");
    if (picked != null && picked != toDate)
      setState(() {
        toDate = picked;
      });
  }
}
