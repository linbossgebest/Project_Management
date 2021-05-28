import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/component_model.dart';
import 'package:thzz_project_management/models/quality_model.dart';
import 'package:thzz_project_management/models/return_model.dart';
import 'package:thzz_project_management/models/swiperimage_model.dart';
import 'package:thzz_project_management/models/userinfo_model.dart';
import 'package:thzz_project_management/models/workposition_model.dart';
import 'package:thzz_project_management/provide/current_index.dart';
import 'package:thzz_project_management/provide/projectprogress_provide.dart';
import 'package:thzz_project_management/provide/qualitysum_provide.dart';
import 'package:thzz_project_management/provide/swiperimagelist_provide.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/getswiperimages_service.dart';
import 'package:thzz_project_management/services/projectfile_service.dart';
import 'package:thzz_project_management/services/user_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = FocusNode();
  FocusNode _focusNodePassWord = FocusNode();

  //用户名输入框控制器，监听用户名输入框操作
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //轮播图列表
  SwiperImageListModel swiperImageList = SwiperImageListModel([]);

  var _username = ""; //用户名
  var _password = ""; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);

    _userNameController.addListener(() {
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
    });

    _passWordController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    //移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    // _userNameController.dispose();
    // _passWordController.dispose();

    super.dispose();
  }

  //监听焦点
  Future _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      _focusNodeUserName.unfocus();
    }
  }

  //用户名验证
  String validateUserName(value) {
    if (value.isEmpty) {
      return "用户名不能为空";
    }
    return null;
  }

  //密码验证
  String validatePassWord(value) {
    if (value.isEmpty) {
      return "密码不能为空";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
          appBar: AppBar(
            title: Text("用户登录"),
            automaticallyImplyLeading: false, //设置没有返回按钮
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                _focusNodeUserName.unfocus();
                _focusNodePassWord.unfocus();
              },
              child: Column(children: <Widget>[
                inputTextArea(context),
                loginArea(context),
              ]),
            ),
          )),
    );
  }

  //输入文本框区域
  Widget inputTextArea(context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入用户名",
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _userNameController.clear();
                    }),
              ),
              validator: validateUserName,
              onSaved: (value) {
                _username = value;
              },
            ),
            TextFormField(
              controller: _passWordController,
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _passWordController.clear();
                            }),
                        IconButton(
                            icon: Icon(_isShowPwd
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isShowPwd = !_isShowPwd;
                              });
                            })
                      ])),
              obscureText: !_isShowPwd, //是否是密文
              validator: validatePassWord,
              onSaved: (value) {
                _password = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  //登录区域
  Widget loginArea(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      height: ScreenUtil().setHeight(60),
      width: double.infinity,
      child: RaisedButton(
          child: Text("登录",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  letterSpacing: ScreenUtil().setSp(30))),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            _focusNodeUserName.unfocus();
            _focusNodePassWord.unfocus();
            _formKey.currentState.save();
            if (_formKey.currentState.validate()) {
              //用户登录校验
              userLoginCheck(_username.trim(), _password.trim()).then((value) {
                if (value != null) {
                  if (mounted) {
                    setState(() {
                      ReturnModel returnModel =
                          ReturnModel.fromJson(value.data);
                      if (returnModel.type == 3 || returnModel.type == 2) {
                        //3失败 2警告
                        _showMessageDialog(returnModel.message);
                      } else if (returnModel.type == 1) {
                        Provider.of<CurrentIndexProvide>(context, listen: false)
                            .changeIndex(0); //退出index重置为0

                        var userInfo =
                            UserInfoModel.fromJson(returnModel.resultdata);
                        var token = userInfo.token; //签名
                        var userRealName = userInfo.realName; //用户真实姓名
                        var userIcon = userInfo.headIcon; //用户图标
                        var projectName = userInfo.projectName; //项目名称
                        var projectDescribe = userInfo.projectDescribe; //项目描述
                        //获取首页展示的质量问题报表数据
                        // getQualitySumList(token).then((value) {
                        //   var resultData = value.data["resultdata"];
                        //   if (resultData != null) {
                        //     var data = QualityListModel.fromJson(resultData);
                        //     Provider.of<QualityListProvide>(context,
                        //             listen: false)
                        //         .setQualityList(data.data);
                        //   }
                        // });
                        //登录成功查询轮播图list
                        querySwiperImageList(token).then((value) {
                          var resultData = value.data["resultdata"];
                          if (resultData != null) {
                            var data =
                                SwiperImageListModel.fromJson(resultData);
                            swiperImageList = data;
                            Provider.of<SwiperImageListProvide>(context,
                                    listen: false)
                                .setImageList(swiperImageList.data);

                            //本地持久化
                            addSharedPreferences("username", _username);
                            addSharedPreferences("userrealname", userRealName);
                            addSharedPreferences("token", token);
                            addSharedPreferences("usericon", userIcon);
                            addSharedPreferences("projectName", projectName);
                            addSharedPreferences(
                                "projectDescribe", projectDescribe);
                            //print(returnModel.resultdata["token"]);
                            initProjectFileList(this.context);

                            return Application.router.navigateTo(
                                context, "/tabs",
                                replace: true); //路由跳转
                          }
                        });
                      }
                    });
                  }
                }
              });
            }
          }),
    );
  }

  //登录按钮提示框
  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            '提示',
            textAlign: TextAlign.center,
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "确定",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
