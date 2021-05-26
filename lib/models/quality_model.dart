class QualityModel {
  String state;
  String stateCount;

  QualityModel({this.state, this.stateCount});

  QualityModel.fromJson(Map<String, dynamic> json) {
    state = json['State'];
    stateCount = json['StateCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['State'] = this.state;
    data['StateCount'] = this.stateCount;
    return data;
  }
}

class QualityListModel {
  List<QualityModel> data;
  QualityListModel(this.data);

  factory QualityListModel.fromJson(List json) {
    return QualityListModel(json.map((e) => QualityModel.fromJson(e)).toList());
  }
}
