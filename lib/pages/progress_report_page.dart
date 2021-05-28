import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/component_model.dart';
import 'package:thzz_project_management/models/componentstate_model.dart';
import 'package:thzz_project_management/provide/projectprogress_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';
import 'package:thzz_project_management/components/custom_imagespick_control.dart';
import 'package:http_parser/http_parser.dart';

class ProcessReportPage extends StatefulWidget {
  ProcessReportPage({Key key}) : super(key: key);

  @override
  _ProcessReportState createState() => _ProcessReportState();
}

class _ProcessReportState extends State<ProcessReportPage> {
  List<Asset> resultList;
  String projectName;
  String token;
  String description;
  String componentStateDropdownValue;
  ComponentListModel componentlist = ComponentListModel([]);
  ComponentStateListModel componentStateList = ComponentStateListModel([]);
  String cachedWorkPositionValue;
  String cachedComponentValue;
  String cachedComponentCode;
  String cachedComponentState;
  String cachedDescription;

  DateTime selectedDate = DateTime.now();

  bool _decideWhichDayToEnable(DateTime day) {
    ///时间间隔从当前日期到增加10天用户可以选择
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // if (mounted) {
    //   Future.delayed(
    //       Duration.zero,
    //       () => setState(() {
    //             getCached();
    //             initProjectFileList(context);
    //             getComponentState();
    //           }));
    // }

    if (mounted) {
      setState(() {
        getCached();
        initProjectFileList(this.context);
        getComponentState();
      });
    }

    super.initState();
  }

  getCached() async {
    token = await querySharedPerferences("token");
    projectName = await querySharedPerferences("projectName");
    cachedWorkPositionValue = await querySharedPerferences("workPositionValue");
    cachedComponentValue = await querySharedPerferences("componentValue");
    cachedComponentCode = await querySharedPerferences("componentCode");
    cachedComponentState = await querySharedPerferences("componentState");
    cachedDescription = await querySharedPerferences("description");
  }

  Future removeCached() async {
    removeSharedPreferences("workPositionValue");
    removeSharedPreferences("componentValue");
    removeSharedPreferences("componentCode");
    removeSharedPreferences("componentState");
    removeSharedPreferences("description");

    cachedWorkPositionValue = null;
    cachedComponentValue = null;
    cachedComponentCode = null;
    cachedComponentState = null;
  }

  //获取构件状态列表
  getComponentState() async {
    String token = await querySharedPerferences("token");

    getComponentStateList(token).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = ComponentStateListModel.fromJson(resultData);
        componentStateList = data;
        Provider.of<ProjectProgressProvide>(context, listen: false)
            .setComponentStateList(componentStateList.data);
        this.componentStateDropdownValue = componentStateList.data[0].stateName;
      }
    });
  }

  //获取构件列表
  Future getComponent(String workPositionCode) async {
    String token = await querySharedPerferences("token");

    getComponentList(token, workPositionCode).then((value) {
      var resultData = value.data["resultdata"];

      if (resultData != null) {
        var data = ComponentListModel.fromJson(resultData);
        componentlist = data;
        Provider.of<ProjectProgressProvide>(context, listen: false)
            .setInitComponentList(componentlist.data);
        Provider.of<ProjectProgressProvide>(context, listen: false)
            .componentValue = componentlist.data[0].componentName;
        Provider.of<ProjectProgressProvide>(context, listen: false)
            .componentCode = componentlist.data[0].componentCode.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        builder: () => Consumer<ProjectProgressProvide>(
                builder: (context, projectProgressProvide, val) {
              return Scaffold(
                  appBar: AppBar(
                    title: Text("进度填报"),
                    automaticallyImplyLeading: false,
                  ),
                  body: Container(
                      child: ListView(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(3),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "项目名称",
                              style: TextStyle(fontSize: 16),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                enabled: false,
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: projectName,
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder()),
                              ),
                            )),
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "工程部位",
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 1),
                                  //边框圆角设置
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.elliptical(4, 4),
                                      bottom: Radius.elliptical(4, 4)),
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 3, left: 15),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(color: Colors.white),
                                  value: cachedWorkPositionValue != null
                                      ? cachedWorkPositionValue
                                      : projectProgressProvide
                                          .workPositionValue,
                                  items: projectProgressProvide.workPositionlist
                                      .map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.workPositionName),
                                      value: item.workPositionName,
                                    );
                                  }).toList(),
                                  //items: _workPositionDropdownItems(),
                                  onChanged: (newValue) async {
                                    removeCached().then((value) {
                                      if (mounted) {
                                        setState(() {
                                          projectProgressProvide
                                              .workPositionValue = newValue;
                                          projectProgressProvide
                                                  .workPositionCode =
                                              projectProgressProvide
                                                  .workPositionlist
                                                  .firstWhere((element) =>
                                                      element
                                                          .workPositionName ==
                                                      newValue)
                                                  .workPositionCode;
                                          getComponent(projectProgressProvide
                                              .workPositionCode);
                                        });
                                      }
                                    });
                                  },
                                ),
                              )),
                        ])),
                    Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "构件名称",
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 1),
                                  //边框圆角设置
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.elliptical(4, 4),
                                      bottom: Radius.elliptical(4, 4)),
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 3, left: 15),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(color: Colors.white),
                                  value: cachedComponentValue != null
                                      ? cachedComponentValue
                                      : projectProgressProvide.componentValue,
                                  onChanged: (newValue) {
                                    if (mounted) {
                                      setState(() {
                                        //projectProgressProvide.setComponentValue(newValue);
                                        projectProgressProvide.componentValue =
                                            newValue;
                                        projectProgressProvide.componentCode =
                                            projectProgressProvide.componentlist
                                                .firstWhere((element) =>
                                                    element.componentName ==
                                                    newValue)
                                                .componentCode
                                                .toString();
                                      });
                                    }
                                  },
                                  items: projectProgressProvide.componentlist
                                      .map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.componentName),
                                      value: item.componentName,
                                    );
                                  }).toList(),
                                ),
                              )),
                        ])),
                    Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(3),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "构件编号",
                              style: TextStyle(fontSize: 16),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                enabled: false,
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: cachedComponentCode != null
                                        ? cachedComponentCode
                                        : projectProgressProvide.componentCode,
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder()),
                              ),
                            )),
                      ]),
                    ),
                    Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                "构件状态",
                                style: TextStyle(fontSize: 16),
                              )),
                          Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 1),
                                  //边框圆角设置
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.elliptical(4, 4),
                                      bottom: Radius.elliptical(4, 4)),
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 3, left: 15),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  underline: Container(color: Colors.white),
                                  value: cachedComponentState != null
                                      ? cachedComponentState
                                      : componentStateDropdownValue,
                                  onChanged: (String newValue) {
                                    if (mounted) {
                                      setState(() {
                                        componentStateDropdownValue = newValue;
                                        cachedComponentState =
                                            componentStateDropdownValue;
                                      });
                                    }
                                  },
                                  items: projectProgressProvide
                                      .componentStatelist
                                      .map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.stateName),
                                      value: item.stateName,
                                    );
                                  }).toList(),
                                ),
                              )),
                        ])),
                    Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(3),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "开始日期",
                              style: TextStyle(fontSize: 16),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
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
                            )),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(3),
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              "施工描述",
                              style: TextStyle(fontSize: 16),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: TextField(
                                enabled: true,
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    hintText: "施工描述",
                                    labelText: cachedDescription,
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder()),
                                onChanged: (newValue) {
                                  if (mounted) {
                                    setState(() {
                                      this.description = newValue;
                                      //print(description);
                                    });
                                  }
                                },
                              ),
                            )),
                      ]),
                    ),
                    Container(
                      child: CustomImagesPickControl(),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue[500],
                            child: Text("暂存"),
                            onPressed: () async {
                              addSharedPreferences("workPositionValue",
                                  projectProgressProvide.workPositionValue);
                              addSharedPreferences("componentValue",
                                  projectProgressProvide.componentValue);
                              addSharedPreferences("componentCode",
                                  projectProgressProvide.componentCode);
                              addSharedPreferences("componentState",
                                  componentStateDropdownValue);
                              addSharedPreferences("description", description);
                              //addListSharedPreferences("imgs",projectProgressProvide);
                            },
                          )),
                          Container(
                              child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue[500],
                            child: Text("提交"),
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "提示",
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(
                                        "是否确定提交数据",
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("取消")),
                                        MaterialButton(
                                            onPressed: () async {
                                              //移除缓存
                                              removeSharedPreferences(
                                                  "workPositionValue");
                                              removeSharedPreferences(
                                                  "componentValue");
                                              removeSharedPreferences(
                                                  "componentCode");
                                              removeSharedPreferences(
                                                  "componentState");
                                              removeSharedPreferences(
                                                  "description");

                                              resultList =
                                                  projectProgressProvide
                                                      .resultList;
                                              List<MultipartFile> files = [];
                                              if (resultList.length != 0) {
                                                for (int i = 0;
                                                    i < resultList.length;
                                                    i++) {
                                                  // 获取 ByteData
                                                  ByteData byteData =
                                                      await resultList[i]
                                                          .getByteData(); //图片byte
                                                  List<int> imageData = byteData
                                                      .buffer
                                                      .asUint8List();
                                                  String fileName =
                                                      resultList[i].name; //图片名称

                                                  MultipartFile multipartFile =
                                                      MultipartFile.fromBytes(
                                                    imageData,
                                                    // 文件名
                                                    filename: fileName,
                                                    // 文件类型
                                                    contentType: MediaType(
                                                        "image", "jpg"),
                                                  );

                                                  files.add(multipartFile);
                                                }
                                              }

                                              FormData formData =
                                                  FormData.fromMap({
                                                // 后端接口的参数名称
                                                'token': token,
                                                'ProjectName': projectName,
                                                'WorkPosition':
                                                    projectProgressProvide
                                                        .workPositionValue,
                                                'ComponentName':
                                                    projectProgressProvide
                                                        .componentValue,
                                                'ComponentCode':
                                                    projectProgressProvide
                                                        .componentCode,
                                                'ComponentState':
                                                    componentStateDropdownValue,
                                                'StartTime': selectedDate,
                                                'Description': description,
                                                "imgs": files,
                                              });

                                              addProjectProgress(formData)
                                                  .then((value) {
                                                projectProgressProvide
                                                    .resultList = []; //清空缓存照片
                                                Application.router.navigateTo(
                                                    context, "/tabs"); //路由跳转
                                              });
                                            },
                                            child: Text("确定")),
                                      ],
                                    );
                                  });
                            },
                          )),
                        ],
                      ),
                    )
                  ])));
            }));
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
    if (picked != null && picked != selectedDate) {
      if (mounted) {
        setState(() {
          selectedDate = picked;
          print(selectedDate);
        });
      }
    }
  }
}
