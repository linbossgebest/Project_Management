import 'package:flutter/material.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/untils/common.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String _user;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      var localUser = querySharedPerferences("username");
      localUser.then((value) {
        //print("查询本地持久化$value");
        _user = value;
        if (value == null) {
          return Application.router.navigateTo(context, "/login");
        } else {
          return Application.router.navigateTo(context, "/tabs");
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            "lib/images/background.jpg",
            fit: BoxFit.fill,
          ),
          Container(
             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Center(
            child: Text(
              "欢迎使用同豪项目管理平台",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  decoration: TextDecoration.none),
            ),
          ))
        ],
      ),
    );
  }
}
