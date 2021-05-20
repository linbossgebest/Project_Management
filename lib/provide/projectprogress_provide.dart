import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:thzz_project_management/models/projectprocess_model.dart';

class ProjectProgressProvide with ChangeNotifier {
  ProjectProcessModel projectProcessModel = new ProjectProcessModel();
  List<Asset> resultList = [];

  setUploadImages(List list) {
    resultList = list;
    notifyListeners();
  }

  setProjectName(String projectName) {
    projectProcessModel.projectName = projectName;
  }

  setWorkPosition(String workPosition) {
    projectProcessModel.workPosition = workPosition;
  }

  setComponentName(String componentName) {
    projectProcessModel.componentName = componentName;
  }

  setComponentCode(String componentCode) {
    projectProcessModel.componentCode = componentCode;
  }

  setComponentState(String componentState) {
    projectProcessModel.componentState = componentState;
  }

  setStartTime(String startTime) {
    projectProcessModel.startTime = startTime;
  }

  setDescription(String description) {
    projectProcessModel.description = description;
  }
}
