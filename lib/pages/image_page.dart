import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class ImagePage extends StatelessWidget {

  Gank gank;

  ImagePage(this.gank);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(gank.who),),
      body: Container(
        child: new Stack(
          children: <Widget>[
            Center(
              child: new PhotoHolder(gank.url, tag: gank.id,),
            ),
            new Positioned(
              child: new Container(
                padding: EdgeInsets.all(10.0),
                color: Color.fromARGB(100, 0, 0, 0),
                child: new Text(gank.desc),
              ),
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
            )
          ],
        ),
      ),
    );
  }
}
