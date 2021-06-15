import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(title: Text("关于我们")),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.message,color: Colors.blue),
              title: Text("公司介绍"),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.message,color: Colors.blue),
              title: Text("公司优势"),
            ),
            Divider(
              height: ScreenUtil().setHeight(10),
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.message,color: Colors.blue),
              title: Text("联系我们"),
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
