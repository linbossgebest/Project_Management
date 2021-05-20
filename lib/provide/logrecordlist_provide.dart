import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/logrecord_model.dart';

class LogRecordListProvide with ChangeNotifier {
  LogRecordListModel logRecordList = LogRecordListModel([]);

  setLogRecordList(List list) {
    logRecordList.data = list;
    notifyListeners();
  }
}
