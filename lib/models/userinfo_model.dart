class UserInfoModel {
  String token;
  String realName;
  String headIcon;

  UserInfoModel({this.token, this.realName, this.headIcon});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    realName = json['RealName'];
    headIcon = json['HeadIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['RealName'] = this.realName;
    data['HeadIcon'] = this.headIcon;
    return data;
  }
}