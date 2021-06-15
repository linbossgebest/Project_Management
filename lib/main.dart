import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/pages/tabs_page.dart';
import 'package:thzz_project_management/provide/componentcurrentinfolist_provide.dart';
import 'package:thzz_project_management/provide/componentinfolist_provide.dart';
import 'package:thzz_project_management/provide/current_index.dart';
import 'package:thzz_project_management/provide/logrecordlist_provide.dart';
import 'package:thzz_project_management/provide/projectimageinfo_provide.dart';
import 'package:thzz_project_management/provide/projectprogress_provide.dart';
import 'package:thzz_project_management/provide/projectshedule_provide.dart';
import 'package:thzz_project_management/provide/qualitysum_provide.dart';
import 'package:thzz_project_management/provide/swiperimagelist_provide.dart';
import 'pages/login_page.dart';
import 'routers/application.dart';
import 'routers/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var currentIndex = CurrentIndexProvide(); //tab索引
  var swiperImageList = SwiperImageListProvide(); //轮播图片
  var logRecordList = LogRecordListProvide(); //历史操作
  var projectProgress = ProjectProgressProvide(); //上传图片
  var qualityList = QualityListProvide(); //质量问题报表
  var componentCurrentList = ComponentCurrentInfoListProvide(); //构件查询
  var componentList = ComponentInfoListProvide(); //构件明细查询
  var projectImageInfo = ProjectImageInfoProvide(); //项目现场图片和描述信息
  var projectSchedule = ProjectScheduleProvide(); //进度统计

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //路由注入
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => currentIndex,
        ),
        ChangeNotifierProvider(
          create: (_) => swiperImageList,
        ),
        ChangeNotifierProvider(
          create: (_) => logRecordList,
        ),
        ChangeNotifierProvider(
          create: (_) => projectProgress,
        ),
        ChangeNotifierProvider(
          create: (_) => qualityList,
        ),
        ChangeNotifierProvider(
          create: (_) => componentCurrentList,
        ),
        ChangeNotifierProvider(
          create: (_) => componentList,
        ),
        ChangeNotifierProvider(
          create: (_) => projectImageInfo,
        ),
        ChangeNotifierProvider(
          create: (_) => projectSchedule,
        ),
      ],
      child: MaterialApp(
        title: '漳州项目管理平台',
        debugShowCheckedModeBanner: false, //取消右上角debug图标
        onGenerateRoute: Application.router.generator, //路由注入
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.standard,
        ),
        navigatorKey: Routes.navigatorKey, //不使用context进行页面跳转
        routes: {
          '/login': (ctx) => LoginPage(),
        },
        initialRoute: "/loading",
        home: Tabs(),
        localizationsDelegates: [
        //此处
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      ),
    );
  }
}
