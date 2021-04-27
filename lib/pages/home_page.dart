import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:thzz_project_management/pages/productionschedule_page.dart';
import 'package:thzz_project_management/routers/application.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    var swiperImagelist = new List();
    swiperImagelist.add("lib/images/swip1.jpg");
    swiperImagelist.add("lib/images/swip2.jpg");
    swiperImagelist.add("lib/images/swip3.jpg");
    swiperImagelist.add("lib/images/swip4.jpg");
    swiperImagelist.add("lib/images/swip5.jpg");

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () async {
              return Application.router.navigateTo(context, "/scanView");
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: ScreenUtil().setSp(20),
                  top: ScreenUtil().setSp(20),
                  child: Image.asset(
                    "lib/images/scan.png",
                    height: ScreenUtil().setHeight(60),
                    width: ScreenUtil().setWidth(60),
                  ),
                )
              ],
            ),
          ),
          title: Text("漳州项目管理平台")),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage("lib/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Container(
                 width: ScreenUtil().setWidth(730),
                // margin: EdgeInsets.all(10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Swiper(
                      key: UniqueKey(),
                      //轮播图
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          //获取图片
                          swiperImagelist[index],
                          fit: BoxFit.fill,
                        );
                      },
                      autoplay: true,
                      itemCount: swiperImagelist.length,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(), //左右箭头
                    )),
              ),
              Container(
                color: Colors.white,
                width: ScreenUtil().setWidth(730),
                height: ScreenUtil().setHeight(500),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ProductionSchedulePage(),
              )
            ],
          )),
    );
  }

}
