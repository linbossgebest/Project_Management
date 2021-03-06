class Config {
  //static const ipAddress = "http://192.168.6.53:44999/api";//开发

  static const ipAddress = "http://222.72.129.158:44999/api"; //生产

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

  //获取工程部位列表
  static const String getWorkPositionListUrl =
      ipAddress + "/ProjectFile/GetWorkPositionList";

  //获取构件列表
  static const String getComponentListUrl =
      ipAddress + "/ProjectFile/GetComponentList";

  //获取项目现场上传图片信息
  static const String getProjectImageInfoUrl =
      ipAddress + "/ProjectFile/GetProjectImageInfo";

  //进度填报和上传现场图片
  static const String addProjectProgressoUrl =
      ipAddress + "/ProjectFile/AddProjectProgress";

  //获取构件状态列表
  static const String getComponentStateListUrl =
      ipAddress + "/ProjectFile/GetComponentStateList";

  //获取质量问题统计
  static const String getQualitySumListUrl =
      ipAddress + "/ProjectFile/GetQualitySum";

  //构件查询
  static const String getProjectComponentListUrl =
      ipAddress + "/ProjectFile/GetProjectComponentList";

  //构件详细查询
  static const String getComponentDetailUrl =
      ipAddress + "/ProjectFile/GetComponentDetail";

  //进度统计查询
  static const String getScheduleCostUrl =
      ipAddress + "/ProjectFile/GetScheduleCost";
}
