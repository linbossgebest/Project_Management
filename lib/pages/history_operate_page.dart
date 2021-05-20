import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/logrecord_model.dart';
import 'package:thzz_project_management/provide/logrecordlist_provide.dart';

class HistoryOperatePage extends StatefulWidget {
  HistoryOperatePage({Key key}) : super(key: key);

  @override
  _HistoryOperatePageState createState() => _HistoryOperatePageState();
}

class _HistoryOperatePageState extends State<HistoryOperatePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: () => Consumer<LogRecordListProvide>(
                builder: (context, logRecordListProvide, val) {
              return Scaffold(
                  appBar: AppBar(title: Text("历史操作")),
                  body: Container(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            showCheckboxColumn: false,
                            columns: [
                              DataColumn(label: Text('操作账户')),
                              DataColumn(label: Text('操作时间')),
                              DataColumn(label: Text('ip地址')),
                              DataColumn(label: Text('模块')),
                              DataColumn(label: Text('操作类型')),
                              DataColumn(label: Text('操作结果')),
                            ],
                            rows: getRows(
                                logRecordListProvide.logRecordList.data),
                          ))));
            }));
  }

  ///动态生成datarow
  List<DataRow> getRows(list) {
    List<LogRecordModel> data = list;
    List<DataRow> dateRows = [];
    for (int i = 0; i < data.length; i++) {
      dateRows.add(DataRow(
        cells: [
          DataCell(Text('${data[i].operateAccount}')),
          DataCell(Text('${data[i].operateTime}')),
          DataCell(Text('${data[i].iPAddress}')),
          DataCell(Text('${data[i].module}')),
          DataCell(Text('${data[i].operateType}')),
          DataCell(Text('${data[i].executeResultJson}')),
        ],
      ));
    }
    return dateRows;
  }
}
