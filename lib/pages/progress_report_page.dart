import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:thzz_project_management/untils/common.dart';
import 'package:thzz_project_management/models/control_type_enum.dart';
import 'package:thzz_project_management/components/custom_imagespick_control.dart';

class ProcessReportPage extends StatefulWidget {
  ProcessReportPage({Key key}) : super(key: key);

  @override
  _ProcessReportState createState() => _ProcessReportState();
}

class _ProcessReportState extends State<ProcessReportPage> {
  @override
  Widget build(BuildContext context) {
    //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("进度填报"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          child: ListView(children: <Widget>[
        generateControl("项目名称", "xx项目名称", ControlType.text, isEnabled: false),
        generateControl("工程部位", null, ControlType.select),
        generateControl("构件名称", null, ControlType.select),
        generateControl("构件编号", "xxx构建编号", ControlType.text, isEnabled: false),
        generateControl("构件状态", null, ControlType.select),
        generateControl("开始日期", null, ControlType.datetime),
        generateControl("施工描述", "施工描述", ControlType.text, isEnabled: true),
        Container(
          child: CustomImagesPickControl(),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue[500],
                child: Text("暂存"),
                onPressed: () {},
              )),
              Container(
                  child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue[500],
                child: Text("提交"),
                onPressed: () {},
              )),
            ],
          ),
        )
      ])),
    );
  }
}
