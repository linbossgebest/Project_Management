class ComponentModel {
  int componentCode;
  String componentName;
  String componentState;

  ComponentModel({this.componentCode, this.componentName, this.componentState});

  ComponentModel.fromJson(Map<String, dynamic> json) {
    componentCode = json['ComponentCode'];
    componentName = json['ComponentName'];
    componentState = json['ComponentState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComponentCode'] = this.componentCode;
    data['ComponentName'] = this.componentName;
    data['ComponentState'] = this.componentState;
    return data;
  }
}

class ComponentListModel {
  List<ComponentModel> data;
  ComponentListModel(this.data);

  factory ComponentListModel.fromJson(List json) {
    return ComponentListModel(
        json.map((e) => ComponentModel.fromJson(e)).toList());
  }
}
