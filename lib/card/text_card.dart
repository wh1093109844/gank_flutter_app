import 'package:flutter/material.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class TextCard extends StatelessWidget {

    Gank gank;

    TextCard(this.gank);

  @override
  Widget build(BuildContext context) {
      List<Widget> contentList = [
          new Expanded(
                  child: new Column(
                      children: <Widget>[
                          new Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: new Text(
                                      gank.who,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          wordSpacing: 2.0
                                      ),
                                  ),
                          ),
                          new Text(
                              gank.desc,
                              maxLines: 2,
                              ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                  ),
      ];
      if (gank.images != null && gank.images?.isNotEmpty) {
          contentList.add(new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Image.network(
                      gank.images[0],
                      width: 120.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                      ),
                  ),
                          );
      }
    return new Card(
        child: new Container(
            child: new Row(children: contentList,),
            padding: EdgeInsets.all(10.0),),
        );
  }

}