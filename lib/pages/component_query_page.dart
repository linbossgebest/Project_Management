import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thzz_project_management/routers/application.dart';

class ComponentQueryPage extends StatefulWidget {
  ComponentQueryPage({Key key}) : super(key: key);

  @override
  _ComponentQueryPageState createState() => _ComponentQueryPageState();
}

class _ComponentQueryPageState extends State<ComponentQueryPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text("构件查看"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TextField(
                      style: TextStyle(height: 1),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 4.0),
                          hintText: "请输入项目名称",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: RaisedButton.icon(
                      textColor: Colors.white,
                      color: Colors.blue[500],
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      label: Text('查询'),
                    ),
                  ),
                ],
              ),
              Container(
                  child: DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                      label: Text('构件名称',
                          style: TextStyle(fontSize: ScreenUtil().setSp(30)))),
                  DataColumn(
                      label: Text('当前状态',
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
                            .navigateTo(context, "/componentQueryDetail");
                      }),
                  DataRow(
                      cells: [
                        DataCell(Text('构件test2')),
                        DataCell(Text('支模')),
                        DataCell(Text('2021-4-27')),
                      ],
                      onSelectChanged: (selected) {
                        print("object2");
                        return Application.router
                            .navigateTo(context, "/componentQueryDetail");
                      }),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
