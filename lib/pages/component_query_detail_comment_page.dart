import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thzz_project_management/components/photo_view_gallery_screen.dart';
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
    List photoList = [
      {'image': 'lib/images/swip1.jpg', 'id': '1'},
      {'image': 'lib/images/swip2.jpg', 'id': '2'},
      {'image': 'lib/images/swip3.jpg', 'id': '3'},
      {'image': 'lib/images/swip4.jpg', 'id': '4'},
      {'image': 'lib/images/swip5.jpg', 'id': '5'},
    ];

    List imgs = [
      'lib/images/swip1.jpg',
      'lib/images/swip2.jpg',
      'lib/images/swip3.jpg',
      'lib/images/swip4.jpg',
      'lib/images/swip5.jpg',
    ];
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      builder: () => Scaffold(
        appBar: AppBar(
          title: Text("现场描述查看"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text("施工描述：xxxxxxxx")),
              Container(
                margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: GridView.builder(
                  shrinkWrap: true, //解决 listview 嵌套报错
                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          images: imgs, //传入图片list
                          index: index, //传入当前点击的图片的index
                          heroTag: imgs[index], //传入当前点击的图片的hero tag （可选）
                        )));
                      },
                      child: Image.asset(
                        photoList[index]['image'],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: photoList.length,
                ),
              )
              // Container(
              //     child: Wrap(
              //   children: <Widget>[
              //     Container(
              //         margin: EdgeInsets.all(5),
              //         width: ScreenUtil().setWidth(330),
              //         child: Image(
              //           image: AssetImage("lib/images/swip1.jpg"),
              //           fit: BoxFit.fill,
              //         )),
              //     Container(
              //         margin: EdgeInsets.all(5),
              //         width: ScreenUtil().setWidth(330),
              //         child: Image(
              //             image: AssetImage("lib/images/swip2.jpg"),
              //             width: ScreenUtil().setWidth(220))),
              //     Container(
              //         margin: EdgeInsets.all(5),
              //         width: ScreenUtil().setWidth(330),
              //         child: Image(
              //             image: AssetImage("lib/images/swip3.jpg"),
              //             width: ScreenUtil().setWidth(220))),
              //     Container(
              //         margin: EdgeInsets.all(5),
              //         width: ScreenUtil().setWidth(330),
              //         child: Image(
              //             image: AssetImage("lib/images/swip4.jpg"),
              //             width: ScreenUtil().setWidth(220))),
              //     Container(
              //         margin: EdgeInsets.all(5),
              //         width: ScreenUtil().setWidth(330),
              //         child: Image(
              //             image: AssetImage("lib/images/swip5.jpg"),
              //             width: ScreenUtil().setWidth(220))),
              //   ],
              // )),
            ],
          ),
        ),
      ),
    );
  }
}
