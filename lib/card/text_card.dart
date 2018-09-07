import 'package:flutter/material.dart';
import '../entry/gank.dart';

class TextCard extends StatelessWidget {

    Gank gank;

    TextCard(this.gank);

  @override
  Widget build(BuildContext context) {
      List<Widget> contentList = [new Expanded(child: new Text(gank.desc))];
      if (gank.images != null && gank.images?.isNotEmpty) {
          contentList.add(new Image.network(gank.images[0], width: 120.0, height: 60.0, fit: BoxFit.cover,));
      }
    return new Card(
        child: new Column(
            children: <Widget>[
                new Row(
                    children: <Widget>[
                        new Text(gank.who),
                    ],
                ),
                new Row(
                    children: contentList,
                )
            ],
        ),);
  }

}