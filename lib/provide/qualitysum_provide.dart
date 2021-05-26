import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/quality_model.dart';

//质量问题 状态控制
class QualityListProvide with ChangeNotifier {
  QualityListModel qualityList = QualityListModel([]);

  setQualityList(List list) {
    qualityList.data = list;
    notifyListeners();
  }
}