import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDateTimeControl extends StatefulWidget {
  final dynamic data;
  CustomDateTimeControl({Key key, this.data}) : super(key: key);

  @override
  _CustomDateTimeControlState createState() => _CustomDateTimeControlState();
}

class _CustomDateTimeControlState extends State<CustomDateTimeControl> {
  DateTime selectedDate = DateTime.now();

  bool _decideWhichDayToEnable(DateTime day) {
    ///时间间隔从当前日期到增加10天用户可以选择
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        helpText: "日历",
        cancelText: "取消",
        confirmText: "确定",
        selectableDayPredicate: _decideWhichDayToEnable,
        builder: (context, child) {
          return Theme(data: ThemeData.light(), child: child);
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            textColor: Colors.white,
            color: Colors.blue[500],
            onPressed: () => _selectDate(context),
            child: Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              // style: TextStyle(color: Colors.black),
            ),
            // color: Colors.white10,
          ),
        ],
      ),
    );
  }
}
