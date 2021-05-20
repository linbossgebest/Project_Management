class WorkPositionModel {
  String workPositionCode;
  String workPositionName;

  WorkPositionModel({this.workPositionCode, this.workPositionName});

  WorkPositionModel.fromJson(Map<String, dynamic> json) {
    workPositionCode = json['WorkPositionCode'];
    workPositionName = json['WorkPositionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WorkPositionCode'] = this.workPositionCode;
    data['WorkPositionName'] = this.workPositionName;
    return data;
  }
}

class WorkPositionListModel{
    List<WorkPositionModel> data;
  WorkPositionListModel(this.data);

  factory WorkPositionListModel.fromJson(List json) {
    return WorkPositionListModel(
        json.map((e) => WorkPositionModel.fromJson(e)).toList());
  }
}