import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/components/photo_view_gallery_screen.dart';
import 'package:thzz_project_management/provide/projectimageinfo_provide.dart';
import 'package:thzz_project_management/routers/fade_route.dart';

class ComponentQueryDetailCommentPage extends StatefulWidget {
  ComponentQueryDetailCommentPage({Key key}) : super(key: key);

  @override
  _ComponentQueryDetailCommentPageState createState() =>
      _ComponentQueryDetailCommentPageState();
}

class _ComponentQueryDetailCommentPageState
    extends State<ComponentQueryDetailCommentPage> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
          appBar: AppBar(
            title: Text("现场照片描述查看"),
          ),
          body: Consumer<ProjectImageInfoProvide>(
              builder: (context, projectImageInfoProivide, child) {
            return projectImageInfoProivide.projectImageInfo == null
                ? Center(
                    child: CircularProgressIndicator(), //加载等待动画
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: projectImageInfoProivide.projectImageInfo.description == null
                                ? Text("施工描述：")
                                : Text("施工描述：" + projectImageInfoProivide.projectImageInfo.description)),
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: GridView.builder(
                            shrinkWrap: true, //解决 listview 嵌套报错
                            physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    //横轴元素个数
                                    crossAxisCount: 3,
                                    //纵轴间距
                                    mainAxisSpacing: 10.0,
                                    //横轴间距
                                    crossAxisSpacing: 10.0,
                                    //子组件宽高长度比例
                                    childAspectRatio: 1.0),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(new FadeRoute(
                                      page: PhotoViewGalleryScreen(
                                    images: projectImageInfoProivide
                                        .projectImageInfo.imgPaths, //传入图片list
                                    index: index, //传入当前点击的图片的index
                                    heroTag: projectImageInfoProivide
                                            .projectImageInfo.imgPaths[
                                        index], //传入当前点击的图片的hero tag （可选）
                                  )));
                                },
                                child: Image.network(
                                  projectImageInfoProivide
                                      .projectImageInfo.imgPaths[index],
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                            itemCount: projectImageInfoProivide
                                .projectImageInfo.imgPaths.length,
                          ),
                        )
                      ],
                    ),
                  );
          })),
    );
  }
}
