class Config{
    static const ipAddress = "http://192.168.6.53:44999/api";

  //用户登录
  static const String userLoginUrl = ipAddress + "/Login/CheckLogin";

    //查询轮播图图片资源
  static const String getSwiperImageListUrl = ipAddress + "/ProjectFile/GetImageList";
}