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
  return await post(Config.userLoginUrl, data:data);
}
