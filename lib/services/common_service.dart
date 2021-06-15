import 'package:dio/dio.dart';
import 'package:thzz_project_management/models/return_model.dart';
import 'package:thzz_project_management/routers/routes.dart';
import 'package:thzz_project_management/untils/toast.dart';

//公共get方法
get(String url, {Map<String, dynamic> queryParameters}) async {
  try {
    // print(queryParameters["token"]);
    if (queryParameters["token"] == null) {
      Toast.show("用户登录已失效,请重新登录！");
      Routes.navigatorKey.currentState?.pushNamed("/login");
    } else {
      var dio = Dio();

      Response response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        ReturnModel returnModel = ReturnModel.fromJson(response.data);
        print(response.data);
        if (returnModel.type == 3 || returnModel.message.contains("超时")) {
          Toast.show(returnModel.message);
          Routes.navigatorKey.currentState?.pushNamed("/login");
        } else if (returnModel.type == 1) {
          return response;
        } else {
          Toast.show(returnModel.message);
          return;
        }
      } else {
        print(response.statusCode);
      }
    }
  } catch (e) {
    print("$e");
  }
}

//公共post方法
post(String url, {dynamic data}) async {
  try {
    var dio = Dio();

    Response response = await dio.post(url, data: data);
    if (response.statusCode == 200) {
      ReturnModel returnModel = ReturnModel.fromJson(response.data);
      if (returnModel.type == 3 || returnModel.message.contains("超时")) {
        Toast.show(returnModel.message);
        Routes.navigatorKey.currentState.pushNamed("/login");
      } else if (returnModel.type == 1) {
        Toast.show(returnModel.message);
        return response;
      } else {
        Toast.show(returnModel.message);
        return;
      }
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print("$e");
  }
}
