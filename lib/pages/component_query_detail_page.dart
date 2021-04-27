import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:thzz_project_management/routers/application.dart';

class ComponentQueryDetailPage extends StatefulWidget {
  ComponentQueryDetailPage({Key key}) : super(key: key);

  @override
  _ComponentQueryDetailPageState createState() => _ComponentQueryDetailPageState();
}

class _ComponentQueryDetailPageState extends State<ComponentQueryDetailPage> {
  @override
  Widget build(BuildContext context) {
        //屏幕适配
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
   return Scaffold(
      appBar: AppBar(
        title: Text("明细"),
      ),
      body:Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
                child: DataTable(
              showCheckboxColumn: false,
              columns: [
                DataColumn(
                    label: Text('构件名称',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)))),
                DataColumn(
                    label: Text('状态',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)))),
                DataColumn(
                    label: Text('开始日期',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30)))),
              ],
              rows: [
                DataRow(
                    cells: [
                      DataCell(Text('构件test1')),
                      DataCell(Text('前期')),
                      DataCell(Text('2021-4-27')),
                    ],
                    onSelectChanged: (selected) {
                      print("object1");
                      return Application.router
                          .navigateTo(context, "/componentQueryDetailComment");
                    }),
                DataRow(
                    cells: [
                      DataCell(Text('构件test1')),
                      DataCell(Text('支模')),
                      DataCell(Text('2021-4-27')),
                    ],
                    onSelectChanged: (selected) {
                      print("object2");
                    }),
              ],
            ))
          ],
        ),
      ),
      );
  }
}