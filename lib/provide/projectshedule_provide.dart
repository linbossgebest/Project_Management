import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/projectschedule_model.dart';

//进度统计  状态控制
class ProjectScheduleProvide with ChangeNotifier {
  ProjectScheduleModel projectSchedule;

  setProjectSchedule(ProjectScheduleModel info) {
    projectSchedule = info;
    notifyListeners();
  }
}