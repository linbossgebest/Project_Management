import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropDownControl extends StatefulWidget {
  final dynamic data;
  CustomDropDownControl({Key key, this.data}) : super(key: key);

  @override
  _CustomDropDownControlState createState() => _CustomDropDownControlState();
}

class _CustomDropDownControlState extends State<CustomDropDownControl> {
  var data;
  List<String> controlItems;
  List itemlist;
  String dropdownValue;

  @override
  void initState() {
    super.initState();

    controlItems = new List<String>();

    //模拟数据
    controlItems.add("value1");
    controlItems.add("value2");
    controlItems.add("value3");
    dropdownValue = controlItems[0];

    // data = widget.data;
    // itemlist = data["control_item"];
    // itemlist.forEach((element) {
    //   controlItems.add(element["name"]);

    //   //设置下拉默认值
    //   if (element["defaults"].toString().contains("1")) {
    //     dropdownValue = element["name"];
    //   }
    // });

    // if (dropdownValue == null || dropdownValue.isEmpty) {
    //   dropdownValue = controlItems[0];
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 1),
        //边框圆角设置
        borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(4, 4), bottom: Radius.elliptical(4, 4)),
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(top: 5, bottom: 3, left: 15),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(color: Colors.white),
        value: dropdownValue,
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: _dropdownItems(),
      ),
    );
  }

  //设置dropdowItems列表
  _dropdownItems() {
    return controlItems.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
