import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextBoxControl extends StatefulWidget {
  final dynamic data;
  final bool isEnabled;
  CustomTextBoxControl({Key key, this.data,this.isEnabled}) : super(key: key);

  @override
  _CustomTextBoxControlState createState() => _CustomTextBoxControlState();
}

class _CustomTextBoxControlState extends State<CustomTextBoxControl> {
  var data;
  var isEnabled;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    isEnabled=widget.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        enabled: isEnabled,
        //textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
            hintText: "$data",
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder()),
        onChanged: (value) {},
      ),
    );
  }
}
