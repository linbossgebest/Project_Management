class ProjectScheduleModel {
  List<int> xAxis;
  List<int> planseries;
  List<int> actualseries;

  ProjectScheduleModel({this.xAxis, this.planseries, this.actualseries});

  ProjectScheduleModel.fromJson(Map<String, dynamic> json) {
    xAxis = json['xAxis'].cast<int>();
    planseries = json['planseries'].cast<int>();
    actualseries = json['actualseries'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xAxis'] = this.xAxis;
    data['planseries'] = this.planseries;
    data['actualseries'] = this.actualseries;
    return data;
  }
}