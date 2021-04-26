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
            )
          ],
        ),
      ),
    );
  }
}
