import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thzz_project_management/components/custom_datetime_control.dart';
import 'package:thzz_project_management/components/custom_dropdown_control.dart';
import 'package:thzz_project_management/components/custom_imagespick_control.dart';
import 'package:thzz_project_management/components/custom_textbox_control.dart';
import 'package:thzz_project_management/models/component_model.dart';
import 'package:thzz_project_management/models/control_type_enum.dart';
import 'package:thzz_project_management/models/workposition_model.dart';
import 'package:thzz_project_management/provide/projectprogress_provide.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';

//通用方法
//梁段状态转换
formatBeamStatus(String status) {
  switch (status) {
    case "No-deal":
      return "空闲";
      break;
    case "Colligation":
      return "绑扎";
      break;
    case "RuMo":
      return "入膜";
      break;
    case "Pouring":
      return "浇筑";
      break;
    case "Pulling":
      return "张拉";
      break;
    case "Mudjacking":
      return "压浆";
      break;
    case "Saving":
      return "存梁";
      break;
    case "hoisting":
      return "吊装";
      break;
    case "AwaitBridge":
      return "等待移梁";
      break;
    default:
      return "无法识别的状态";
  }
}

//台座图片地址
formatPedestalStatusImage() {
  return "lib/images/pedestal_status.png";
}

//根据index获取state值
String getStateByIndex(int index) {
  String state = "";

  if (index == 0) {
    state = "No-deal"; //空闲
  } else if (index == 1) {
    state = "RuMo"; //入模
  } else if (index == 2) {
    state = "Pouring"; //浇筑
  } else if (index == 3) {
    state = "Pulling"; //张拉
  } else if (index == 4) {
    state = "Mudjacking"; //压浆
  }
  return state;
}

//新增本地持久化信息
void addSharedPreferences(String key, String value) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  prefs.setString(key, value);
}

//查询本地持久化信息
Future<String> querySharedPerferences(String key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  String result = prefs.getString(key);
  return result;
}

//移除本地持久化信息
void removeSharedPreferences(String key) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs = await _prefs;
  prefs.remove(key);
}

//通用组件
Widget generateControl(name, data, type, {isEnabled}) {
  return Container(
    margin: EdgeInsets.all(3),
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
        // border: new Border.all(width: 0.8, color: Colors.blue),
        //  //边框圆角设置
        //   borderRadius: BorderRadius.vertical(
        //       top: Radius.elliptical(4, 4), bottom: Radius.elliptical(4, 4)),
        // color: Colors.white,
        ),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "$name",
              style: TextStyle(fontSize: 16),
            )),
        Expanded(flex: 3, child: _custom(data, type, isEnabled: isEnabled)),
      ],
    ),
  );
}

Widget _custom(data, ControlType controlType, {isEnabled}) {
  // String type = controlType;
  switch (controlType) {
    case ControlType.text:
      return Container(
          child: CustomTextBoxControl(
        data: data,
        isEnabled: isEnabled,
      ));
      break;
    case ControlType.select:
      return Container(child: CustomDropDownControl(data: data));
      break;
    case ControlType.datetime: //日期控件
      return Container(child: CustomDateTimeControl());
      break;
    case ControlType.image: //上传图片
      return Container(child: CustomImagesPickControl());
      break;
    default:
      return Container(
        child: Text('暂不支持此控件'),
      );
  }
}

initProjectFileList(dynamic context) async {
  String token = await querySharedPerferences("token");
  getWorkPositionList(token).then((value) {
    //获取工程部位列表
    var resultData = value.data["resultdata"];
    //workPositionlist = WorkPositionListModel([]);
    if (resultData != null) {
      var data = WorkPositionListModel.fromJson(resultData);
      var workPositionValue = data.data[0].workPositionName;
      var workPositionCode = data.data[0].workPositionCode;
      Provider.of<ProjectProgressProvide>(context, listen: false)
          .setInitWorkPositionList(data.data);
      Provider.of<ProjectProgressProvide>(context, listen: false)
          .setWorkPositionValue(workPositionValue);
      Provider.of<ProjectProgressProvide>(context, listen: false)
          .setWorkPositionCode(workPositionCode);

      getComponentList(token, workPositionCode).then((value) {
        var resultData = value.data["resultdata"];
        if (resultData != null) {
          var data = ComponentListModel.fromJson(resultData);
          Provider.of<ProjectProgressProvide>(context, listen: false)
              .setInitComponentList(data.data);
          Provider.of<ProjectProgressProvide>(context, listen: false)
              .setComponentValue(data.data[0].componentName);
          Provider.of<ProjectProgressProvide>(context, listen: false)
              .setComponentCode(data.data[0].componentCode.toString());
        }
      });
    }
  });
}
