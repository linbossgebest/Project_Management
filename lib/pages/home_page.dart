import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/swiperimage_model.dart';
import 'package:thzz_project_management/pages/productionschedule_page.dart';
import 'package:thzz_project_management/provide/swiperimagelist_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/getswiperimages_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String projectName = "";
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(
          Duration.zero,
          () => setState(() {
                getCached();
                getSwiperImageList();
              }));
    }
  }

  getCached() async {
    projectName = await querySharedPerferences("projectName");
  }

  getSwiperImageList() async {
    var token = await querySharedPerferences("token");
    querySwiperImageList(token).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = SwiperImageListModel.fromJson(resultData);

        Provider.of<SwiperImageListProvide>(context, listen: false)
            .setImageList(data.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var swiperImagelist =
        Provider.of<SwiperImageListProvide>(context, listen: false)
            .swiperImageList
            .data;

    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
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
                      "lib/images/icon.jpg",
                      fit: BoxFit.fill,
                      height: ScreenUtil().setHeight(80),
                      width: ScreenUtil().setWidth(80),
                    ),
                  )
                ],
              ),
            ),
            title: Text(projectName)),
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
                          //print(swiperImagelist[index].filePath);
                          return Image.network(
                            //获取图片
                            swiperImagelist[index].filePath,
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
                  color: Colors.white.withAlpha(200),
                  width: ScreenUtil().setWidth(730),
                  height: ScreenUtil().setHeight(500),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ProductionSchedulePage(),
                )
              ],
            )),
      ),
    );
  }
}
