import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:thzz_project_management/routers/application.dart';

class MyProjectPage extends StatefulWidget {
  MyProjectPage({Key key}) : super(key: key);

  @override
  _MyProjectPageState createState() => _MyProjectPageState();
}

class _MyProjectPageState extends State<MyProjectPage> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
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
                child: Image.asset("lib/images/defaultuser.jpg"),
              ),
              title: Text("用户名称:lin"),
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
                subtitle: Text('xxxxxx'),
              ),
              ListTile(
                title: Text('项目简介'),
                subtitle: Text('xxxxxx'),
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
                return Application.router.navigateTo(context, "/historyOperate");
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
                                // removeSharedPreferences("username");
                                // removeSharedPreferences("token");
                                return Application.router
                                    .navigateTo(context, "/login");
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
    );
  }
}
