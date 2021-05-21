class ComponentStateModel {
  int code;
  String stateName;

  ComponentStateModel({this.code, this.stateName});

  ComponentStateModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['StateName'] = this.stateName;
    return data;
  }
}

class ComponentStateListModel {
  List<ComponentStateModel> data;
  ComponentStateListModel(this.data);

  factory ComponentStateListModel.fromJson(List json) {
    return ComponentStateListModel(
        json.map((e) => ComponentStateModel.fromJson(e)).toList());
  }
}
