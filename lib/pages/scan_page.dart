import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/componentcurrentinfo_model.dart';
import 'package:thzz_project_management/provide/componentcurrentinfolist_provide.dart';
import 'package:thzz_project_management/provide/current_index.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';

//扫描二维码
class ScanPage extends StatefulWidget {
  ScanPage({Key key}) : super(key: key);

  @override
  _ScanViewState createState() => new _ScanViewState();
}

class _ScanViewState extends State<ScanPage> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  getComponentCurrentInfo(String componentName) async {
    String token = await querySharedPerferences("token");

    queryProjectComponentList(token, componentName).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = ComponentCurrentInfoListModel.fromJson(resultData);
        //componentStateList = data;
        Provider.of<ComponentCurrentInfoListProvide>(context, listen: false)
            .setComponentInfoList(data.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: QrcodeReaderView(
        key: _key,
        onScan: onScan,
        headerWidget: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }

  Future onScan(String data) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("扫码结果"),
          content: Text(data),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("确认"),
                onPressed: () {
                  getComponentCurrentInfo(data);
                  // Application.router.navigateTo(context, "/componentQuery",
                  //     replace: true); //路由跳转 构件查看页面
                  Provider.of<CurrentIndexProvide>(context, listen: false)
                      .currentIndex = 3;
                  Application.router.navigateTo(context, "/tabs"); //路由跳转 构件查看页面
                })
          ],
        );
      },
    );
    _key.currentState.startScan();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
