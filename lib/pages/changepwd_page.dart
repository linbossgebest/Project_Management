import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thzz_project_management/models/return_model.dart';
import 'package:thzz_project_management/routers/application.dart';
import 'package:thzz_project_management/services/user_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class ChangePwdPage extends StatefulWidget {
  ChangePwdPage({Key key}) : super(key: key);

  @override
  _ChangePwdPageState createState() => _ChangePwdPageState();
}

class _ChangePwdPageState extends State<ChangePwdPage> {
  //焦点
  FocusNode _focusNodePassWord = FocusNode();
  //用户名输入框控制器，监听用户名输入框操作
  TextEditingController _passWordController = TextEditingController();
//表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ""; //密码
  var _isShowPwd = false; //是否显示密码

  @override
  void initState() {
    //设置焦点监听
    _focusNodePassWord.addListener(_focusNodeListener);
    _passWordController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    //移除焦点监听
    _focusNodePassWord.removeListener(_focusNodeListener);
    super.dispose();
  }

  //监听焦点
  Future _focusNodeListener() async {
    // if (_focusNodeUserName.hasFocus) {
    //   _focusNodePassWord.unfocus();
    // }
    // if (_focusNodePassWord.hasFocus) {
    //   _focusNodeUserName.unfocus();
    // }
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
            title: Text("修改密码"),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
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
              controller: _passWordController,
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入新的密码",
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

  Widget loginArea(context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      height: ScreenUtil().setHeight(60),
      width: double.infinity,
      child: RaisedButton(
          child: Text("修改密码",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  letterSpacing: ScreenUtil().setSp(30))),
          color: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            _focusNodePassWord.unfocus();
            _formKey.currentState.save();
            if (_formKey.currentState.validate()) {
                querySharedPerferences("token").then((token) => {
                  userRevisePassword(token,_password).then((value){
                      var resultData = value.data["resultdata"];
                      if (resultData != null) {
                         return Application.router
                                .navigateTo(context, "/login");//修改密码成功，路由跳转登录页面
                      }
                  })
                });
            }
          }),
    );
  }
}
