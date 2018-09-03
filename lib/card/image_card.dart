import 'package:flutter/material.dart';
import '../entry/gank.dart';

class ImageCard extends StatelessWidget {
  Gank gank;

  ImageCard(this.gank);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(new FadeInImage.assetNetwork(
        placeholder: '../res/images/place_holder.jpg', image: gank.url));
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
          constraints: new BoxConstraints(),
          child: new Stack(
            children: widgetList,
          )),
    );
  }
}
