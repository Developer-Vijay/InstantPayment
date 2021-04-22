import 'package:flutter/material.dart';

class Dth {
  var logo;
  var title;
  int index;
  Dth({this.logo, this.index, this.title});
}

List<Dth> dthlist = [
  Dth(
      index: 0,
      logo: Image.asset(
        "assets/images/tatasky.png",
        fit: BoxFit.cover,
        width: 100,
        height: 140,
      ),
      title: "Tata Sky"),
  Dth(
      index: 1,
      logo: Image.asset(
        "assets/images/dishtv.png",
        fit: BoxFit.cover,
        width: 100,
        height: 140,
      ),
      title: "Dish Tv"),
  Dth(
      index: 2,
      logo: Image.asset(
        "assets/images/d2h.png",
        fit: BoxFit.cover,
        width: 100,
        height: 140,
      ),
      title: "D2H"),
  Dth(
      index: 3,
      logo: Image.asset(
        "assets/images/sundirect.png",
        fit: BoxFit.contain,
        width: 100,
        height: 140,
      ),
      title: "Sun Direct"),
  Dth(
      index: 4,
      logo: Image.asset(
        "assets/images/airtel.png",
        fit: BoxFit.cover,
        width: 100,
        height: 140,
      ),
      title: "Airtel Digital Tv"),
];

class Recharge {
  var value;
  var title;
  Recharge({this.title, this.value});
}

List<Recharge> rechqarge = [
  Recharge(title: "Prepaid", value: 0),
  Recharge(title: "Postpaid", value: 1)
];

class Plans {
  var price;
  var data;
  var validity;
  var voice;

  Plans({this.data, this.price, this.validity, this.voice});
}

List<Plans> plandata = [
  Plans(
      data: "1.5 GB/day",
      voice: "Unlimited voice calls",
      price: "₹199",
      validity: "28 Days"),
  Plans(
      data: "1 GB/day",
      voice: "Unlimited voice calls",
      price: "₹149",
      validity: "24 Days"),
  Plans(
      data: "1.5 GB/day",
      voice: "Unlimited voice calls",
      price: "₹555",
      validity: "84 Days"),
];
