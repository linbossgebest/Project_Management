import 'package:thzz_project_management/config/configure.dart';
import 'common_service.dart';

/**
 * 用户登录
 * account：用户账号
 * password：用户密码
 */
userLoginCheck(String account, String password) async {
  Map<String, dynamic> data = {
    "account": account,
    "password": password,
  };
  return await post(Config.userLoginUrl, data: data);
}

//修改密码
userRevisePassword(String token, String password) async {
  Map<String, dynamic> data = {
    "token": token,
    "password": password,
  };
  return await post(Config.userLoginUrl, data: data);
}

//获取历史操作
userGetLogRecord(String token) async {
  Map<String, dynamic> queryParameters = {"token": token};
  return await get(Config.getUserLogRecordUrl,
      queryParameters: queryParameters);
}
