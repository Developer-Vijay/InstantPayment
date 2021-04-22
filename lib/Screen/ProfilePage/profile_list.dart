import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netly/Components/Resources/styling.dart';
import 'package:netly/SetPassword/change_password.dart';
import 'package:netly/list.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
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
                              width: 100,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )),
                      ),
                      Positioned(
                        top: 65,
                        left: 80,
                        child: CircleAvatar(
                          radius: 10,
                          child: Icon(
                            Icons.edit,
                            size: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "9871224515",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Carl Woase",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text("carlwoase@gmail.com"),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                "Verify Email",
                                style: TextStyle(
                                    color: Apptheme.textColor2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
