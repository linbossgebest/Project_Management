import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/projectimages_model.dart';

//现场上传图片&&描述信息  状态控制
class ProjectImageInfoProvide with ChangeNotifier {
  ProjectImagesModel projectImageInfo;

  setProjectImagesInfo(ProjectImagesModel info) {
    projectImageInfo = info;
    notifyListeners();
  }
}