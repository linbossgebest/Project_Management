import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/componentinfo_model.dart';
import 'package:thzz_project_management/models/projectimages_model.dart';
import 'package:thzz_project_management/provide/componentinfolist_provide.dart';
import 'package:thzz_project_management/provide/projectimageinfo_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class ComponentQueryDetailPage extends StatefulWidget {
  ComponentQueryDetailPage({Key key}) : super(key: key);

  @override
  _ComponentQueryDetailPageState createState() =>
      _ComponentQueryDetailPageState();
}

class _ComponentQueryDetailPageState extends State<ComponentQueryDetailPage> {
  getProjectImageInfo(String componentName, String componentState) async {
    String token = await querySharedPerferences("token");

    getProjectImages(token, componentName, componentState).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = ProjectImagesModel.fromJson(resultData);
        //componentStateList = data;
        Provider.of<ProjectImageInfoProvide>(context, listen: false)
            .setProjectImagesInfo(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ;
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text("明细"),
        ),
        body: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Consumer<ComponentInfoListProvide>(
                  builder: (context, componentInfoListProivide, child) {
                return Container(
                  child: DataTable(
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(
                          label: Text('构件名称',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(30)))),
                      DataColumn(
                          label: Text('状态',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(30)))),
                      DataColumn(
                          label: Text('开始日期',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(30)))),
                    ],
                    rows: _setDataRows(
                        componentInfoListProivide.componentInfoList.data),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> _setDataRows(List<ComponentInfoModel> componentList) {
    List<DataRow> list = [];

    componentList.forEach((componentItem) {
      DataRow dataRow = DataRow(
          cells: [
            DataCell(Text(componentItem.componentName)),
            DataCell(Text(componentItem.componentState)),
            DataCell(Text(componentItem.startTime)),
          ],
          onSelectChanged: (selected) {
            // print("object2");
            getProjectImageInfo(
                componentItem.componentName, componentItem.componentState);
            return Application.router
                .navigateTo(context, "/componentQueryDetailComment");
          });

      list.add(dataRow);
    });

    return list;
  }
}
