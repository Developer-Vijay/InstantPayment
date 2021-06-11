import 'package:async/async.dart';
// Memorizer Section

final AsyncMemoizer walletMemorizer = AsyncMemoizer();
final AsyncMemoizer rechargeMemorizer = AsyncMemoizer();
final AsyncMemoizer dthMemorizer = AsyncMemoizer();
final AsyncMemoizer electricityMemorizer = AsyncMemoizer();
final AsyncMemoizer dataMemorizer = AsyncMemoizer();
final AsyncMemoizer gasMemorizer = AsyncMemoizer();
final AsyncMemoizer benficaryBankMemorizer = AsyncMemoizer();
final AsyncMemoizer bankMemorizer=AsyncMemoizer();
final AsyncMemoizer moneyTransferMemorizer = AsyncMemoizer();
final AsyncMemoizer addBalanceMemorizer = AsyncMemoizer();
final AsyncMemoizer postpaidMemorizer = AsyncMemoizer();
final AsyncMemoizer prepaidMemorizer = AsyncMemoizer();

// API Section

const API_BASE_URL = 'https://instantpayment.tk/api/';
const AUTH_API = API_BASE_URL + 'authentication';
const ADMIN_API = API_BASE_URL + 'admin';
const SERVICE_API = API_BASE_URL + 'service';
const COMMON_API = API_BASE_URL + 'common';
const PORTAL_API = API_BASE_URL + 'portal';

class BankList{
  int index;
  String bankName;
  var ifscCode;
   BankList({this.bankName,this.ifscCode,this.index});
}

class Name {
  var name;
  var accountnumber;
  var bankname;
  var ifscCodes;
  var beneId;
  var mobileNumber;
  Name(
      {this.name,
      this.accountnumber,
      this.bankname,
      this.beneId,
      this.mobileNumber,
      this.ifscCodes});
}
List<Name> named = [];


