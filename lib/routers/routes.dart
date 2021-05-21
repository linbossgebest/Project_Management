import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart' hide Router;
import 'package:thzz_project_management/pages/home_page.dart';
import 'package:thzz_project_management/routers/route_handler.dart';

class Routes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static String root = "/";
  static String loading = "/loading";
  static String login = "/login";
  static String tabs = "/tabs";
  static String homePage = "/home";
  static String scanPage = "/scanPage";
  static String aboutUsPage = "/aboutUs";
  static String myProjectPage = "/myProject";
  static String progressReportPage = "/progressReport";
  static String settingPage = "/setting";
  static String historyOperatePage = "/historyOperate";
  static String componentQueryPage = "/componentQuery";
  static String componentQueryDetailPage = "/componentQueryDetail";
  static String componentQueryDetailCommentPage =
      "/componentQueryDetailComment";
  static String changePwdPage = "/changePwd";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
      handlerFunc:
          (BuildContext context, Map<String, List<String>> parameters) {
        return HomePage();
      },
    );

    router.define(loading, handler: loadingHandler);
    router.define(login, handler: loginHandler);
    router.define(tabs, handler: tabsHandler);
    router.define(scanPage, handler: scanHandler);
    router.define(aboutUsPage, handler: aboutUsHandler);
    router.define(myProjectPage, handler: myProjectHandler);
    router.define(progressReportPage, handler: progressReportHandler);
    router.define(settingPage, handler: settingHandler);
    router.define(historyOperatePage, handler: historyOperateHandler);
     router.define(componentQueryPage,
        handler: componentQueryHandler);
    router.define(componentQueryDetailPage,
        handler: componentQueryDetailHandler);
    router.define(componentQueryDetailCommentPage,
        handler: componentQueryDetailCommentHandler);
    router.define(changePwdPage, handler: changePwdHandler);
  }
}
