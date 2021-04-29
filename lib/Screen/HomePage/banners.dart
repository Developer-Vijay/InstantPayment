import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:netly/Components/Resources/sizeconfig.dart';
import 'package:netly/list.dart';

class Banners extends StatefulWidget {
  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 180),
        child: Card(
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
              height: 18.99 * SizeConfig.heightMultiplier,
              width: 166.2 * SizeConfig.widthMultiplier,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Swiper(
                  pagination: SwiperPagination(),
                  itemCount: imageslist.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      placeholder: (context, url) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      imageUrl: imageslist[index],
                    );
                  },
                ),
              )),
        ));
  }
}
