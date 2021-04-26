//接口返回固定格式数据model
class ReturnModel {
  int type; //类型（1=成功，2=警告，3=失败）
  int errorcode; //错误码
  String message; //消息
  dynamic resultdata; //返回数据明细信息

  ReturnModel({this.type, this.errorcode, this.message, this.resultdata});

  factory ReturnModel.fromJson(dynamic json) {
    return ReturnModel(
        type: json["type"],
        errorcode: json["errorcode"],
        message: json["message"],
        resultdata: json["resultdata"]);
  }
}
