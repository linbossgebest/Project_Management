import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:thzz_project_management/models/swiperimage_model.dart';
import 'package:thzz_project_management/provide/swiperimagelist_provide.dart';
import 'package:thzz_project_management/services/getswiperimages_service.dart';
import 'package:thzz_project_management/untils/common.dart';

class SwiperPage extends StatefulWidget {
  SwiperPage({Key key}) : super(key: key);

  @override
  _SwiperPageState createState() => _SwiperPageState();
}

class _SwiperPageState extends State<SwiperPage> {
  var swiperImagelist = [];
  getSwiperImageList() async {
    var token = await querySharedPerferences("token");
    querySwiperImageList(token).then((value) {
      var resultData = value.data["resultdata"];
      if (resultData != null) {
        var data = SwiperImageListModel.fromJson(resultData);

        Provider.of<SwiperImageListProvide>(context, listen: false)
            .setImageList(data.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getSwiperImageList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<SwiperImageListProvide>(
                builder: (context, swiperImageListProvide, child) {
              swiperImagelist = swiperImageListProvide.swiperImageList.data;
              return (swiperImagelist == null || swiperImagelist.length == 0)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Swiper(
                        key: UniqueKey(),
                        //轮播图
                        itemBuilder: (BuildContext context, int index) {
                          //print(swiperImagelist[index].filePath);
                          return Image.network(
                            //获取图片
                            swiperImagelist[index].filePath,
                            fit: BoxFit.fill,
                          );
                        },
                        autoplay: true,
                        itemCount: swiperImagelist.length,
                        pagination: new SwiperPagination(),
                        control: new SwiperControl(), //左右箭头
                      ));
            });
          } else {
            return Center(
              child: CircularProgressIndicator(), //加载等待动画
            );
          }
        },
      ),
    );
  }
}
