import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/logrecord_model.dart';
import 'package:thzz_project_management/provide/logrecordlist_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/user_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class MyProjectPage extends StatefulWidget {
  MyProjectPage({Key key}) : super(key: key);

  @override
  _MyProjectPageState createState() => _MyProjectPageState();
}

class _MyProjectPageState extends State<MyProjectPage> {
  LogRecordListModel logRecordList = LogRecordListModel([]);
  String username;
  String usericon;
  String projectName;
  String projectDescribe;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(
          Duration.zero,
          () => setState(() {
                querySharedPerferences("username")
                    .then((value) => username = value);
                querySharedPerferences("usericon")
                    .then((value) => usericon = value);
                querySharedPerferences("projectName")
                    .then((value) => projectName = value);
                querySharedPerferences("projectDescribe")
                    .then((value) => projectDescribe = value);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(
            title: Text("我的项目"), automaticallyImplyLeading: false //设置没有返回按钮
            ),
        body: Container(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: ScreenUtil().setHeight(200),
              //color: Colors.blue,
              child: ListTile(
                leading: ClipOval(
                  child: usericon != null
                      ? Image.network(usericon)
                      : Image.asset("lib/images/defaultuser.jpg"),
                ),
                title: Text("用户名称:" + "$username"),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[500],
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black12)),
              ),
            ),
            Container(
                child: ExpansionTile(
              title: Text("我的项目"),
              leading: Icon(Icons.inbox),
              children: <Widget>[
                ListTile(
                  title: Text('项目名称'),
                  subtitle: Text('$projectName'),
                ),
                ListTile(
                  title: Text('项目简介'),
                  subtitle: Text('$projectDescribe'),
                ),
              ],
            )),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  querySharedPerferences("token").then((token) => {
                        userGetLogRecord(token).then((value) {
                          var resultData = value.data["resultdata"];
                          if (resultData != null) {
                            var data = LogRecordListModel.fromJson(resultData);
                            logRecordList = data;
                            Provider.of<LogRecordListProvide>(context,
                                    listen: false)
                                .setLogRecordList(logRecordList.data);
                          }
                        })
                      });

                  return Application.router
                      .navigateTo(context, "/historyOperate");
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("历史操作"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  return Application.router.navigateTo(context, "/aboutUs");
                },
                child: ListTile(
                    leading: Icon(Icons.info),
                    title: Text("关于我们"),
                    trailing: InkWell(
                      child: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        return Application.router
                            .navigateTo(context, "/aboutUs");
                      },
                    )),
              ),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  return Application.router.navigateTo(context, "/setting");
                },
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("设置"),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            Container(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "提示",
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            "是否确定退出",
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("取消")),
                            MaterialButton(
                                onPressed: () {
                                  ///退出移除本地缓存
                                  removeAllSharedPreferences();
                                  return Application.router.navigateTo(
                                      context, "/login",
                                      clearStack: true);
                                },
                                child: Text("确定")),
                          ],
                        );
                      });
                },
                child: ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text("退出登录"),
                ),
              ),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
          ],
        )),
      ),
    );
  }
}
