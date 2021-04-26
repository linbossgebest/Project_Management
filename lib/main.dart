import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/pages/home_page.dart';
import 'package:thzz_project_management/provide/current_index.dart';
import 'pages/login_page.dart';
import 'routers/application.dart';
import 'routers/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var currentIndex = CurrentIndexProvide(); //tab索引

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
        home: HomePage(),
      ),
    );
  }
}
