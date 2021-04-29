import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FingerPrintPage extends StatefulWidget {
  @override
  _FingerPrintPageState createState() => _FingerPrintPageState();
}

class _FingerPrintPageState extends State<FingerPrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reader"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 5 * SizeConfig.heightMultiplier,
          ),
          Column(
            children: [
              Text(
                "Mantra Device",
              ),
              SizedBox(
                height: 8 * SizeConfig.heightMultiplier,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  height: 25 * SizeConfig.imageSizeMultiplier,
                  imageUrl:
                      "https://image.flaticon.com/icons/png/512/125/125503.png",
                ),
              ),
              SizedBox(
                height: 8 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 50,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 2000,
                  percent: 0.7,
                  center: Text(
                    "70.0%",
                    style: TextStyle(color: Apptheme.whitetextcolor),
                  ),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Apptheme.PrimaryColor,
                ),
              ),
              Text(
                "Recommended Fingerprint Strength is 70%",
                style: TextStyle(
                    color: Apptheme.textColo1r, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 46 * SizeConfig.widthMultiplier,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Apptheme.PrimaryColor,
                    textColor: Apptheme.whitetextcolor,
                    onPressed: () {},
                    child: Text("Capture"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
