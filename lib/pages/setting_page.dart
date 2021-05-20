import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thzz_project_management/routers/application.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(title: Text("设置")),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
              child: InkWell(
                onTap: () {
                  return Application.router.navigateTo(context, "/changePwd");
                },
                child: ListTile(
                  leading: Icon(Icons.security),
                  title: Text("修改密码"),
                  trailing:InkWell(
                    child:   Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                        return Application.router.navigateTo(context, "/aboutUs");
                    },
                  )
                
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.security),
                title: Text("修改密码"),
                trailing: InkWell(
                  onTap: () {
                    return Application.router.navigateTo(context, "/changePwd");
                  },
                )),
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
