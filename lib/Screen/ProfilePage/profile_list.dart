import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/SetPassword/change_password.dart';
import 'package:netly/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  var retrieveLogin;
  var logindata;
  var email;
  var name;
  var phonenumber;
  var photo;
  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    retrieveLogin = prefs.getString('loginInfo');
    logindata = jsonDecode(retrieveLogin);
    setState(() {
      name = logindata['user']['userName'];
      email = logindata['user']['email'];
      photo = logindata['user']['imageInfo'][0]['path'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 7 * SizeConfig.widthMultiplier),
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 6.77 * SizeConfig.heightMultiplier,
                        backgroundColor: Colors.red,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: CachedNetworkImage(
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              imageUrl:
                                  "https://images.unsplash.com/photo-1509668521827-dd7d42a587e2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzV8fHVzZXJ8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
                              fit: BoxFit.fitWidth,
                              width: 33 * SizeConfig.widthMultiplier,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                      ),
                      Positioned(
                        top: 8.7 * SizeConfig.heightMultiplier,
                        left: 20.2 * SizeConfig.widthMultiplier,
                        child: CircleAvatar(
                          radius: 1.39 * SizeConfig.heightMultiplier,
                          child: Icon(
                            Icons.edit,
                            size: 3 * SizeConfig.imageSizeMultiplier,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 4 * SizeConfig.widthMultiplier,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "9818069709",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 2.6 * SizeConfig.textMultiplier),
                        ),
                      ),
                      SizedBox(
                        height: 1.5 * SizeConfig.heightMultiplier,
                      ),
                      Container(
                          child: name == null
                              ? Text(
                                  "Carl Woase",
                                  style: TextStyle(
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                      fontWeight: FontWeight.bold),
                                )),
                      Container(
                          child: email == null
                              ? Text("carlwoase@gmail.com")
                              : Text(email)),
                      SizedBox(
                        height: 1 * SizeConfig.heightMultiplier,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25 * SizeConfig.widthMultiplier,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                "Verify Email",
                                style: TextStyle(
                                    color: Apptheme.textColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 1.6 * SizeConfig.textMultiplier),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1.2 * SizeConfig.heightMultiplier,
            ),
            Divider(),
            ListView.builder(
              itemCount: profile.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    if (profile[index].index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasscode()));
                    }
                  },
                  leading: Container(
                    child: profile[index].icon,
                  ),
                  title: Text(profile[index].title),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
