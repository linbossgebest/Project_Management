
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ComponentQueryPage extends StatefulWidget {
  ComponentQueryPage({Key key}) : super(key: key);

  @override
  _ComponentQueryPageState createState() => _ComponentQueryPageState();
}

class _ComponentQueryPageState extends State<ComponentQueryPage> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title:Text("构件查看"),
        automaticallyImplyLeading: false,
      ),
    );
  }
}