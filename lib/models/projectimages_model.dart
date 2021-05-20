class ProjectImagesModel {
  List<String> imgPaths;
  String description;

  ProjectImagesModel({this.imgPaths, this.description});

  ProjectImagesModel.fromJson(Map<String, dynamic> json) {
    imgPaths = json['imgPaths'].cast<String>();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgPaths'] = this.imgPaths;
    data['description'] = this.description;
    return data;
  }
}