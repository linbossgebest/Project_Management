import 'package:flutter/material.dart';
import 'package:thzz_project_management/models/swiperimage_model.dart';

//轮播图片 状态控制
class SwiperImageListProvide with ChangeNotifier {
  SwiperImageListModel swiperImageList = SwiperImageListModel([]);

  getImageList(List list) {
    swiperImageList.data = list;
    notifyListeners();
  }
}
