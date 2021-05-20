import 'package:thzz_project_management/config/configure.dart';
import 'common_service.dart';

//获取项目现场上传图片信息
getProjectImages(String token) async {
  Map<String, dynamic> queryParameters = {"token": token};
  return await get(Config.getProjectImageInfoUrl,
      queryParameters: queryParameters);
}

//进度填报和上传现场图片
addProjectProgress(dynamic data) async {
  return await post(Config.addProjectProgressoUrl, data: data);
}

//获取工程部位列表
getWorkPositionList(String token) async {
  Map<String, dynamic> queryParameters = {"token": token};
  return await get(Config.getWorkPositionListUrl,
      queryParameters: queryParameters);
}

//获取构件列表
getComponentList(
    String token, String workPositionCode) async {
  Map<String, dynamic> queryParameters = {
    "token": token,
    "WorkPositionCode": workPositionCode
  };
  return await get(Config.getComponentListUrl,
      queryParameters: queryParameters);
}
