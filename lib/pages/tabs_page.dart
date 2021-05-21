import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/pages/progress_report_page.dart';
import 'package:thzz_project_management/pages/scan_page.dart';
import 'package:thzz_project_management/provide/current_index.dart';
import 'component_query_page.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:thzz_project_management/pages/my_project_page.dart';

class Tabs extends StatelessWidget {
  int currentIndex = 0;
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "进度填报"),
    BottomNavigationBarItem(icon: Icon(Icons.crop_free), label: "扫码"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "构件查看"),
    BottomNavigationBarItem(icon: Icon(Icons.developer_board), label: "我的项目"),
  ];

  HomePage homePage;
  ProcessReportPage processReportPage;
  MyProjectPage myProjectPage;
  ComponentQueryPage componentQueryPage;
  ScanPage scanPage;

  currentPage() {
    switch (currentIndex) {
      case 0:
        {
          homePage = HomePage();
          return homePage;
        }
      case 1:
        {
          processReportPage = ProcessReportPage();
          return processReportPage;
        }
      case 2:
        {
          scanPage = ScanPage();
          return scanPage;
        }
      case 3:
        {
          componentQueryPage = ComponentQueryPage();
          return componentQueryPage;
        }
      case 4:
        {
          myProjectPage = MyProjectPage();
          return myProjectPage;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Consumer<CurrentIndexProvide>(
          builder: (context, currentIndexProvide, val) {
        currentIndex = currentIndexProvide.currentIndex;
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.blue,
              currentIndex: currentIndex,
              iconSize: ScreenUtil().setSp(60),
              fixedColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                currentIndexProvide.changeIndex(index);
              },
              items: bottomTabs),
          body: currentPage(),
        );
      }),
    );
  }
}
