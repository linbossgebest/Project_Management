class LogRecordModel {
  String operateAccount;
  String operateTime;
  String iPAddress;
  String module;
  String operateType;
  String executeResultJson;

  LogRecordModel(
      {this.operateAccount,
      this.operateTime,
      this.iPAddress,
      this.module,
      this.operateType,
      this.executeResultJson});

  LogRecordModel.fromJson(Map<String, dynamic> json) {
    operateAccount = json['OperateAccount'];
    operateTime = json['OperateTime'];
    iPAddress = json['IPAddress'];
    module = json['Module'];
    operateType = json['OperateType'];
    executeResultJson = json['ExecuteResultJson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OperateAccount'] = this.operateAccount;
    data['OperateTime'] = this.operateTime;
    data['IPAddress'] = this.iPAddress;
    data['Module'] = this.module;
    data['OperateType'] = this.operateType;
    data['ExecuteResultJson'] = this.executeResultJson;
    return data;
  }
}

class LogRecordListModel {
  List<LogRecordModel> data;
  LogRecordListModel(this.data);

  factory LogRecordListModel.fromJson(List json) {
    return LogRecordListModel(
        json.map((e) => LogRecordModel.fromJson(e)).toList());
  }
}