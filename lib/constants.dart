import 'package:async/async.dart';
// Memorizer Section

 AsyncMemoizer walletMemorizer = AsyncMemoizer();
 AsyncMemoizer rechargeMemorizer = AsyncMemoizer();
 AsyncMemoizer bannerMemorizer = AsyncMemoizer();
 AsyncMemoizer dthMemorizer = AsyncMemoizer();
 AsyncMemoizer electricityMemorizer = AsyncMemoizer();
 AsyncMemoizer dataMemorizer = AsyncMemoizer();
 AsyncMemoizer gasMemorizer = AsyncMemoizer();
 AsyncMemoizer benficaryBankMemorizer = AsyncMemoizer();
 AsyncMemoizer bankMemorizer=AsyncMemoizer();
 AsyncMemoizer moneyTransferMemorizer = AsyncMemoizer();
 AsyncMemoizer addBalanceMemorizer = AsyncMemoizer();
 AsyncMemoizer postpaidMemorizer = AsyncMemoizer();
 AsyncMemoizer prepaidMemorizer = AsyncMemoizer();

// API Section

const API_BASE_URL = 'https://instantpayment.tk/api/';
const AUTH_API = API_BASE_URL + 'authentication';
const ADMIN_API = API_BASE_URL + 'admin';
const SERVICE_API = API_BASE_URL + 'service';
const COMMON_API = API_BASE_URL + 'common';
const PORTAL_API = API_BASE_URL + 'portal';

// Image Section
const S3_BASE_PATH='https://instant-payment.s3.amazonaws.com/';
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


