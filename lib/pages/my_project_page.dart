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
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12)),
                  ),
                ),
          ListTile(
            leading: Icon(Icons.menu),
            title: Text("我的项目"),
          ),
          Divider(
            height: ScreenUtil().setHeight(10),
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.menu),
            title: Text("历史操作"),
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
        ],
      )),
    );
  }
}
