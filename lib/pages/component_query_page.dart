import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/componentcurrentinfo_model.dart';
import 'package:thzz_project_management/models/componentinfo_model.dart';
import 'package:thzz_project_management/provide/componentcurrentinfolist_provide.dart';
import 'package:thzz_project_management/provide/componentinfolist_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class ComponentQueryPage extends StatefulWidget {
  ComponentQueryPage({Key key}) : super(key: key);

  @override
  _ComponentQueryPageState createState() => _ComponentQueryPageState();
}

class _ComponentQueryPageState extends State<ComponentQueryPage> {
  String _componentName = "";

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

  getComponentDetailInfo(String componentName) async {
    String token = await querySharedPerferences("token");

    queryProjectComponentDetai(token, componentName).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = ComponentInfoListModel.fromJson(resultData);
        //componentStateList = data;
        Provider.of<ComponentInfoListProvide>(context, listen: false)
            .setComponentInfoList(data.data);
      }
    });
  }

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
          child: ListView(
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
                          hintText: "请输入构件名称",
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        //print(value);
                        _componentName = value;
                      },
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
                      onPressed: () {
                        setState(() {
                          getComponentCurrentInfo(_componentName);
                        });
                      },
                      icon: Icon(Icons.search),
                      label: Text('查询'),
                    ),
                  ),
                ],
              ),
              Container(
                child: FutureBuilder(
                  future: getComponentCurrentInfo(_componentName),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Consumer<ComponentCurrentInfoListProvide>(
                        builder:
                            (context, componentCurrentInfoListProivide, child) {
                          return componentCurrentInfoListProivide
                                      .componentInfoList.data.length ==
                                  0
                              ? Center(
                                  child: Text("未查找到该构件信息"),
                                )
                              : Container(
                                  child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    showCheckboxColumn: false,
                                    columns: [
                                      //标题名称
                                      DataColumn(
                                          label: Text('构件名称',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(36)))),
                                      DataColumn(
                                          label: Text('当前状态',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(36)))),
                                      DataColumn(
                                          label: Text('开始日期',
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(36)))),
                                    ],
                                    rows: _setDataRows(
                                        componentCurrentInfoListProivide
                                            .componentInfoList.data),
                                  ),
                                ));
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(), //加载等待动画
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> _setDataRows(List<ComponentCurrentInfoModel> componentList) {
    List<DataRow> list = [];

    componentList.forEach((componentItem) {
      DataRow dataRow = DataRow(
          cells: [
            DataCell(Text(componentItem.componentName)),
            DataCell(Text(componentItem.componentNowState)),
            DataCell(Text(componentItem.startTime)),
          ],
          onSelectChanged: (selected) {
            // print("object2");
            getComponentDetailInfo(componentItem.componentName);
            return Application.router
                .navigateTo(context, "/componentQueryDetail");
          });

      list.add(dataRow);
    });

    return list;
  }
}
