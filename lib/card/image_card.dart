import 'package:flutter/material.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class ImageCard extends StatelessWidget {
  Gank gank;

  GestureTapCallback onTap;

  ImageCard(this.gank, this.onTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> widgetList = [];
    widgetList.add(new PhotoHolder(gank.url, onTap));
    if (gank.who != null && gank.who.isNotEmpty) {
      widgetList.add(new Positioned(
        child: new Container(
            color: Color.fromARGB(100, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
            width: 500.0,
            child: new Text(
              gank.who,
              style: new TextStyle(color: Colors.white),
            )),
        bottom: 0.0,
      ));
    }
    return new Card(
      child: new Container(
          constraints: new BoxConstraints(minHeight: 100.0),
          child: new Stack(
            children: widgetList,
          )),
    );
  }

}

class PhotoHolder extends StatelessWidget {

  String photo;
  VoidCallback onTap;

  PhotoHolder(this.photo, this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print(photo);
              this.onTap();
            },
            child: FadeInImage.assetNetwork(placeholder: 'res/images/place_holder.jpg', image: photo),
          ),
        ));
  }
}
