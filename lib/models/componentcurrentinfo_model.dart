class ComponentCurrentInfoModel {//构件当前状态信息
  String componentName;
  String componentNowState;
  String startTime;

  ComponentCurrentInfoModel(
      {this.componentName, this.componentNowState, this.startTime});

  ComponentCurrentInfoModel.fromJson(Map<String, dynamic> json) {
    componentName = json['ComponentName'];
    componentNowState = json['ComponentNowState'];
    startTime = json['StartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComponentName'] = this.componentName;
    data['ComponentNowState'] = this.componentNowState;
    data['StartTime'] = this.startTime;
    return data;
  }
}

class ComponentCurrentInfoListModel{
   List<ComponentCurrentInfoModel> data;
  ComponentCurrentInfoListModel(this.data);

  factory ComponentCurrentInfoListModel.fromJson(List json) {
    return ComponentCurrentInfoListModel(
        json.map((e) => ComponentCurrentInfoModel.fromJson(e)).toList());
  }
}