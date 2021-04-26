import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(title: Text("设置")),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: Icon(Icons.message),
            title: Text("设置1"),
          ),
          Divider(
            height: ScreenUtil().setHeight(10),
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text("设置2"),
          ),
          Divider(
            height: ScreenUtil().setHeight(10),
            color: Colors.grey,
          ),
          Container(
            child: InkWell(
              onTap: () {
              },
              child: ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("退出"),
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
