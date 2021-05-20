class UserInfoModel {
  String token;
  String realName;
  String headIcon;
  String projectName;
  String projectDescribe;

  UserInfoModel(
      {this.token,
      this.realName,
      this.headIcon,
      this.projectName,
      this.projectDescribe});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    realName = json['RealName'];
    headIcon = json['HeadIcon'];
    projectName = json["ProjectName"];
    projectDescribe = json["ProjectDescribe"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['RealName'] = this.realName;
    data['HeadIcon'] = this.headIcon;
    data['ProjectName'] = this.projectName;
    data['ProjectDescribe'] = this.projectDescribe;
    return data;
  }
}
