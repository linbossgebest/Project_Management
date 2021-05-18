
//获取轮播图资源
import 'package:thzz_project_management/config/configure.dart';

import 'common_service.dart';

querySwiperImageList(String token) async {
  Map<String, dynamic> queryParameters = {"token": token};
  return await get(Config.getSwiperImageListUrl,  queryParameters:queryParameters);
}
