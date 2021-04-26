import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CustomImagesPickControl extends StatefulWidget {
  CustomImagesPickControl({Key key}) : super(key: key);

  @override
  _CustomImagesPickControlState createState() =>
      _CustomImagesPickControlState();
}

class _CustomImagesPickControlState extends State<CustomImagesPickControl> {
  List<Asset> images = <Asset>[];

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#2196F3",
          actionBarTitle: "上传照片",
          allViewTitle: "所有照片",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
           //未选择图片时提示
          textOnNothingSelected:'没有选择照片',

        ),
      );
    }on Exception catch (e) {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 1),
        //边框圆角设置
        borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(4, 4), bottom: Radius.elliptical(4, 4)),
      ),
      margin: EdgeInsets.all(5),
      height: 200,
      child: Column(
        children: <Widget>[
          RaisedButton.icon(
            textColor: Colors.white,
                  color: Colors.blue[500],
            icon: Icon(Icons.add),
            label: Text('添加现场照片'),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildGridView(),
          )
        ],
      ),
    );
  }
}
