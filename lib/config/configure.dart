class Config {
  static const ipAddress = "http://192.168.6.53:44999/api";

  //用户登录
  static const String userLoginUrl = ipAddress + "/Login/CheckLogin";

  //用户修改密码
  static const String userRevisePasswordUrl =
      ipAddress + "/Login/RevisePassword";

  //获取用户历史操作记录
  static const String getUserLogRecordUrl = ipAddress + "/Login/GetLogRecord";

  //查询轮播图图片资源
  static const String getSwiperImageListUrl =
      ipAddress + "/ProjectFile/GetImageHomeList";

  //获取项目现场上传图片信息
  static const String getProjectImageInfoUrl =
      ipAddress + "/ProjectFile/GetProjectImageInfo";
}
