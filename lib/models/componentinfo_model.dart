class ComponentInfoModel {
  String componentName;
  String componentState;
  String startTime;

  ComponentInfoModel({this.componentName, this.componentState, this.startTime});

  ComponentInfoModel.fromJson(Map<String, dynamic> json) {
    componentName = json['ComponentName'];
    componentState = json['ComponentState'];
    startTime = json['StartTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComponentName'] = this.componentName;
    data['ComponentState'] = this.componentState;
    data['StartTime'] = this.startTime;
    return data;
  }
}

class ComponentInfoListModel {
  List<ComponentInfoModel> data;
  ComponentInfoListModel(this.data);

  factory ComponentInfoListModel.fromJson(List json) {
    return ComponentInfoListModel(
        json.map((e) => ComponentInfoModel.fromJson(e)).toList());
  }
}