import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:thzz_project_management/models/component_model.dart';
import 'package:thzz_project_management/models/componentstate_model.dart';
import 'package:thzz_project_management/models/projectprocess_model.dart';
import 'package:thzz_project_management/models/workposition_model.dart';

class ProjectProgressProvide with ChangeNotifier {
  ProjectProcessModel projectProcessModel = new ProjectProcessModel();
  List<WorkPositionModel> workPositionlist = [];
  String workPositionValue;
  String workPositionCode;
  List<ComponentModel> componentlist = [];
  String componentValue;
  String componentCode;
  List<ComponentStateModel> componentStatelist = [];
  List<Asset> resultList = [];

  setUploadImages(List list) {
    resultList = list;
    notifyListeners();
  }

  setInitWorkPositionList(List list) {
    workPositionlist = list;
    notifyListeners();
  }

  setWorkPositionValue(String workPositionValue) {
    this.workPositionValue = workPositionValue;
  }

  setWorkPositionCode(String workPositionCode) {
    this.workPositionCode = workPositionCode;
  }

  setInitComponentList(List list) {
    componentlist = list;
    notifyListeners();
  }

  setComponentStateList(List list){
    componentStatelist=list;
    notifyListeners();
  }

  setComponentValue(String componentValue) {
    this.componentValue = componentValue;
  }

  setComponentCode(String componentCode) {
    this.componentCode = componentCode;
  }
}
