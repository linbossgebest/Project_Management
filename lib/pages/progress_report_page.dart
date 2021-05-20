import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/projectprocess_model.dart';
import 'package:thzz_project_management/models/workposition_model.dart';
import 'package:thzz_project_management/provide/projectprogress_provide.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/untils/common.dart';
import 'package:thzz_project_management/models/control_type_enum.dart';
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
  WorkPositionListModel list = WorkPositionListModel([]);
  
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(
          Duration.zero,
          () => setState(() {
                querySharedPerferences("projectName")
                    .then((value) => projectName = value);
                querySharedPerferences("token").then((value) => token = value);
                //获取工程部位列表
                getWorkPositionList(token).then((value) {
                  var resultData = value.data["resultdata"];

                  if (resultData != null) {
                    var data = WorkPositionListModel.fromJson(resultData);
                    list = data;
                  }
                });
              }));
    }
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
                  generateControl("项目名称", "$projectName", ControlType.text,
                      isEnabled: false),
                  generateControl("工程部位", null, ControlType.select),
                  generateControl("构件名称", null, ControlType.select),
                  generateControl("构件编号", "xxx构建编号", ControlType.text,
                      isEnabled: false),
                  generateControl("构件状态", null, ControlType.select),
                  generateControl("开始日期", null, ControlType.datetime),
                  generateControl("施工描述", "施工描述", ControlType.text,
                      isEnabled: true),
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
                          onPressed: () {},
                        )),
                        Container(
                            child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue[500],
                          child: Text("提交"),
                          onPressed: () async {
                            resultList = projectProgressProvide.resultList;
                            ProjectProcessModel projectProcessModel =
                                projectProgressProvide.projectProcessModel;

                            if (resultList.length != 0) {
                              List<MultipartFile> files = List();
                              for (int i = 0; i < resultList.length; i++) {
                                // 获取 ByteData
                                ByteData byteData =
                                    await resultList[i].getByteData(); //图片byte
                                List<int> imageData =
                                    byteData.buffer.asUint8List();
                                String fileName = resultList[i].name; //图片名称

                                MultipartFile multipartFile =
                                    MultipartFile.fromBytes(
                                  imageData,
                                  // 文件名
                                  filename: fileName,
                                  // 文件类型
                                  contentType: MediaType("image", "jpg"),
                                );

                                files.add(multipartFile);
                              }

                              FormData formData = FormData.fromMap({
                                // 后端接口的参数名称
                                'token': token,
                                // 'ProjectName': "123",
                                // 'WorkPosition': "123",
                                // 'ComponentName': "123",
                                // 'ComponentCode': "123",
                                // 'ComponentState': "123",
                                // 'StartTime': "2021-05-20",
                                // 'Description': "123",
                                'ProjectName': projectProcessModel.projectName,
                                'WorkPosition':
                                    projectProcessModel.workPosition,
                                'ComponentName':
                                    projectProcessModel.componentName,
                                'ComponentCode':
                                    projectProcessModel.componentCode,
                                'ComponentState':
                                    projectProcessModel.componentState,
                                'StartTime': projectProcessModel.startTime,
                                'Description': projectProcessModel.description,
                                "imgs": files,
                              });

                              addProjectProgress(formData);
                            }
                          },
                        )),
                      ],
                    ),
                  )
                ])),
              );
            }));
  }
}
