import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/componentcurrentinfo_model.dart';

//构件查询 状态控制
class ComponentCurrentInfoListProvide with ChangeNotifier {
  ComponentCurrentInfoListModel componentInfoList = ComponentCurrentInfoListModel([]);

  setComponentInfoList(List list) {
    componentInfoList.data = list;
    notifyListeners();
  }
}