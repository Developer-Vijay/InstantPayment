class AddBalance {
  var amount;
  var id;
  var date;
  var transfer;
  var bank;
  AddBalance({this.amount, this.bank, this.date, this.id, this.transfer});
}

List<AddBalance> addbalance = [
  AddBalance(
      amount: "1000",
      bank: "State Bank of India",
      date: "2021-04-26",
      id: "12034437460",
      transfer: "IMPS")
];

class Status {
  var title;
  var totalCount;
  var success;
  var failed;
  var pending;
  Status(
      {this.failed, this.pending, this.success, this.title, this.totalCount});
}

List<Status> stautusData=[
  Status(failed: "0",pending: "2",success: "10",title: "Recharge",totalCount: "12"),
  Status(failed: "1",pending: "0",success: "9",title: "Bill Payments",totalCount: "10"),
  Status(failed: "0",pending: "2",success: "10",title: "Money Transfer",totalCount: "12"),
  Status(failed: "0",pending: "2",success: "10",title: "AEPS",totalCount: "12"),
];