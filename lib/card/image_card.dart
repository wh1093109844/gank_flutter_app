import 'package:flutter/material.dart';
import '../entry/gank.dart';
import '../widgets/image_wrap.dart';

class ImageCard extends StatefulWidget {
  Gank gank;

  ImageCard(this.gank, {this.width, this.height});

  double width;
  double height;

  @override
  State<StatefulWidget> createState() {
    return new _ImageCradState();
  }


}

class _ImageCradState extends State<ImageCard> {
  GlobalKey _globalKey = new GlobalKey();
  double _height;
  double _width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _height = widget.height;
    _width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return new Card(child: new Container(
      key: _globalKey,
      width: _width,
      height: _height != null ? _height : 100.0,
      child: new GridTile(
        child: new WrapImage.network(widget.gank.url, imageListener: _handleImageLoad,),
        footer: new GridTileBar(
          backgroundColor: Color.fromARGB(100, 0, 0, 0),
          title: new Text(widget.gank.who),
        ),
      ),
    ),);
  }

void _handleImageLoad(ImageInfo imageInfo, bool aync) {
    print(imageInfo);
  double width = _globalKey.currentContext?.size.width;
  double height = imageInfo.image.height * width / imageInfo.image.width;
  print("width = $width\theight = $height");
  if (_height == null) {
    setState(() {
      _height = height;
    });
  }
}
}
