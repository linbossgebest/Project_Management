import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/componentinfo_model.dart';

//构件明细查询 状态控制
class ComponentInfoListProvide with ChangeNotifier {
  ComponentInfoListModel componentInfoList = ComponentInfoListModel([]);

  setComponentInfoList(List list) {
    componentInfoList.data = list;
    notifyListeners();
  }
}