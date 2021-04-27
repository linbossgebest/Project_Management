import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:thzz_project_management/pages/about_us_page.dart';
import 'package:thzz_project_management/pages/component_query_detail_comment_page.dart';
import 'package:thzz_project_management/pages/component_query_detail_page.dart';
import 'package:thzz_project_management/pages/history_operate_page.dart';
import 'package:thzz_project_management/pages/loading_page.dart';
import 'package:thzz_project_management/pages/login_page.dart';
import 'package:thzz_project_management/pages/progress_report_page.dart';
import 'package:thzz_project_management/pages/scan_page.dart';
import 'package:thzz_project_management/pages/tabs_page.dart';
import 'package:thzz_project_management/pages/my_project_page.dart';
import 'package:thzz_project_management/pages/setting_page.dart';


Handler loadingHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoadingPage();
  },
);

Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  },
);

Handler tabsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Tabs();
  },
);

Handler scanHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return ScanPage();
  },
);

Handler aboutUsHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return AboutUsPage();
  },
);

Handler myProjectHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return MyProjectPage();
  },
);

Handler progressReportHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return ProcessReportPage();
  },
);

Handler settingHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return SettingPage();
  },
);

Handler historyOperateHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return HistoryOperatePage();
  },
);

Handler componentQueryDetailHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return ComponentQueryDetailPage();
  },
);

Handler componentQueryDetailCommentHandler=Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
    return ComponentQueryDetailCommentPage();
  },
);
