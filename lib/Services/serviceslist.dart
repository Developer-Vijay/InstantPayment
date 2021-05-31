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
  var index;
  Recharge({this.title, this.value,this.index});
}

List<Recharge> rechqarge = [
  Recharge(title: "Prepaid", value: 0,index: 0),
  Recharge(title: "Postpaid", value: 1,index: 1)
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

class Transfer {
  var number;
  var mode;
  var imps;
  var neft;
  var accountNumber;
  var bankName;
  var firstName;
  var lastName;
  var spent;
  var limit;
  var verification;
  var bulktransfer;

  Transfer(
      {this.bulktransfer,
      this.imps,
      this.mode,
      this.accountNumber,
      this.bankName,
      this.limit,
      this.spent,
      this.neft,
      this.firstName,
      this.lastName,
      this.number,
      this.verification});
}

List<Transfer> add = [
  Transfer(
      accountNumber: "1546245621456215",
      bankName: "State Bank of India",
      bulktransfer: true,
      firstName: "Carl",
      imps: true,
      lastName: "woase",
      limit: "20000",
      mode: "Active",
      neft: false,
      number: "9818069709",
      spent: "10",
      verification: true)
];

class BankDetails {
  var name;
  var accountNumber;
  var bankName;
  BankDetails({this.accountNumber, this.bankName, this.name});
}

List<BankDetails> banklist = [
  BankDetails(
      accountNumber: 12546789451203560,
      bankName: "STATE BANK OF INDIA (SBI)",
      name: "Mr Carlwoase"),
  BankDetails(
      accountNumber: 98745612345604646,
      bankName: "ICICI BANK LTD",
      name: "Shivam Singal"),
  BankDetails(
      accountNumber: 45612306478914204,
      bankName: "INDUSIND BANK",
      name: "Prakash Raut"),
];

class ReportList {
  var title;
  var icon;
  var subtitle;
  var params;

  ReportList({this.icon, this.subtitle, this.title,this.params});
}

List<ReportList> reportlist=[
  ReportList(icon: "assets/icon/bill.svg",title:"Recharges",subtitle: "See Mobile Recharge Report",params: "Recharge" ),
  // ReportList(icon: "assets/icon/parabolic-dishes.svg",title:"Dth Recharge",subtitle: "See Dth Recharge Report" ),
  ReportList(icon: "assets/icon/tower.svg",title:"Electricity bill",subtitle: "See Electricity bill Report",params: "BillPayment" ),
  // ReportList(icon: "assets/icon/card.svg",title:"Data Card bill",subtitle: "See Data Card bill Report" ),
  // ReportList(icon:"assets/icon/gas.svg",title: "Gas bill",subtitle: "See Gas bill Report " ),
  ReportList(icon: "assets/icon/money-transfer.svg",title:"Money Transfer Report",subtitle: "See Money Transfer Report",params: "Money Transfer" ),
  ReportList(icon: "assets/icon/aep.svg",title:"AEPS Report",subtitle: "See AEPS Report",params: "AEPS" ),
  ReportList(icon: "assets/icon/atm-machine.svg",title:"Micro Atm Report",subtitle: "See Micro Atm Report",params: "MicroATM" ),
  ReportList(icon: "assets/icon/digital-wallet.svg",title: "Wallet",subtitle: "See Wallet Report",params: "Wallet"),
  ReportList(icon: "assets/icon/wallet.svg",title: "InterWallet",subtitle: "See InterWallet Report",params: "Inter Wallet"),
  ReportList(icon: "assets/icon/commission.svg",title: "Commission",subtitle: "See Commison Report",params: "Commission")
];

