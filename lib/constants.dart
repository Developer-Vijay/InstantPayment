// API Section

const API_BASE_URL = 'https://instantpayment.tk/api/';

const AUTH_API = API_BASE_URL + 'authentication';
const ADMIN_API = API_BASE_URL + 'admin';
const SERVICE_API = API_BASE_URL + 'service';
const COMMON_API = API_BASE_URL + 'common';
const PORTAL_API = API_BASE_URL + 'portal';

class Name {
  var name;
  var accountnumber;
  var bankname;
  var ifscCode;
  var beneId;
  var mobileNumber;
  Name(
      {this.name,
      this.accountnumber,
      this.bankname,
      this.beneId,
      this.mobileNumber,
      this.ifscCode});

  // startsWith(String query) {}
}

List<Name> named = [];
