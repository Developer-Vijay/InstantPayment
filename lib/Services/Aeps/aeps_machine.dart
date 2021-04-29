import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/Services/Aeps/Aeps_main_screen.dart';
import 'package:netly/Services/Aeps/aepslist.dart';

class AepsChoice extends StatefulWidget {
  @override
  _AepsChoiceState createState() => _AepsChoiceState();
}

class _AepsChoiceState extends State<AepsChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AEPS Devices"),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Machine",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 2.4 * SizeConfig.heightMultiplier,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: machinedata.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Card(
                    elevation: 14,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: CircleAvatar(
                      radius: 12 * SizeConfig.imageSizeMultiplier,
                      backgroundColor: Apptheme.whitetextcolor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => AepsMainPage()));
                          },
                          child: CachedNetworkImage(
                            height: 300 * SizeConfig.imageSizeMultiplier,
                            width: 500 * SizeConfig.imageSizeMultiplier,
                            imageUrl: machinedata[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.2 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    machinedata[index].name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          ),
        ],
      ),
    );
  }
}
