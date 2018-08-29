import 'package:flutter/material.dart';
import '../entry/gank.dart';

class ImageCard extends StatelessWidget {
  Gank gank;

  ImageCard(this.gank);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Container(
        width: 500.0,
        child: new GridTile(
          child: new Image.network(gank.url),
          footer: new GridTileBar(
            backgroundColor: Color.fromARGB(100, 0, 0, 0),
            title: new Text(gank.who),
          ),
        ),
      ),
    );
  }
}
