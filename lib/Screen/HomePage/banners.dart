import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/constants.dart';
import 'package:netly/list.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Banners extends StatefulWidget {
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  var responsedData;
  getbanner() {
    return bannerMemorizer.runOnce(() async {
      final prefs = await SharedPreferences.getInstance();
      var retrieveLogin = prefs.getString('loginInfo');
      var logindata = jsonDecode(retrieveLogin);
      var sessionToken = logindata['sessionToken'];
      var refreshToken = logindata['refreshToken'];
      print(refreshToken);
      print(sessionToken);
      var response =
          await http.get(COMMON_API + '/getBannerDashboardimg', headers: {
        "Content-type": "application/json",
        "authorization": sessionToken,
        "refreshToken": refreshToken
      });
      responsedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        return responsedData;
      } else {
        return responsedData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 180),
        child: Card(
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
              height: 16 * SizeConfig.heightMultiplier,
              width: 140 * SizeConfig.widthMultiplier,
              child: FutureBuilder(
                  future: this.getbanner(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Swiper(
                          pagination: SwiperPagination(),
                          itemCount: snapshot.data.length - 1,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              imageUrl: S3_BASE_PATH +
                                  snapshot.data['result']
                                      ['bannerImgRemotePath'],
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
        ));
  }
}
