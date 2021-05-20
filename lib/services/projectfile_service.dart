import 'package:thzz_project_management/config/configure.dart';
import 'common_service.dart';

//获取项目现场上传图片信息
getProjectImages(String token) async {
  Map<String, dynamic> queryParameters = {"token": token};
  return await get(Config.getProjectImageInfoUrl,
      queryParameters: queryParameters);
}