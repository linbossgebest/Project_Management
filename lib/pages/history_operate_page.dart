import 'package:flutter/material.dart';

class HistoryOperatePage extends StatefulWidget {
  HistoryOperatePage({Key key}) : super(key: key);

  @override
  _HistoryOperatePageState createState() => _HistoryOperatePageState();
}

class _HistoryOperatePageState extends State<HistoryOperatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("历史操作")),
        body: Container(
            child: DataTable(
              showCheckboxColumn :false,
          columns: [
            DataColumn(label: Text('姓名')),
            DataColumn(label: Text('年龄')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('老孟')),
              DataCell(Text('18')),
            ],
            onSelectChanged: (selected) {
              print("object1");
            }
            ),
            DataRow(cells: [
              DataCell(Text('老林sr')),
              DataCell(Text('18')),
            ],
             onSelectChanged: (selected) {
              print("object2");
            }),
          ],
        )
        )
        );
  }
}
