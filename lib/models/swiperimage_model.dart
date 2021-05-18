class SwiperImageModel {
  String fileName;
  String filePath;

  SwiperImageModel({this.fileName, this.filePath});

  factory SwiperImageModel.fromJson(dynamic json) {
    return SwiperImageModel(
        fileName: json["FileName"], filePath: json["FilePath"]);
  }
}

class SwiperImageListModel {
  List<SwiperImageModel> data;
  SwiperImageListModel(this.data);

  factory SwiperImageListModel.fromJson(List json) {
    return SwiperImageListModel(
        json.map((e) => SwiperImageModel.fromJson(e)).toList());
  }
}
