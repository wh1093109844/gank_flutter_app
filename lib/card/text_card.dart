import 'package:flutter/material.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class TextCard extends StatefulWidget {
  Gank gank;
  VoidCallback onTap;

  TextCard(this.gank);

  @override
  TextCardState createState() {
    return new TextCardState();
  }
}

class TextCardState extends State<TextCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> contentList = [
      new Expanded(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: new Text(
                widget.gank.who ?? '',
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, wordSpacing: 2.0),
              ),
            ),
            new Text(
              widget.gank.desc ?? '',
              maxLines: 2,
            ),
            new Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: new BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5.0)),
              child: new Text(widget.gank.type, style: new TextStyle(fontSize: 12.0, color: Colors.white),),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    ];
    if (widget.gank.images != null && widget.gank.images?.isNotEmpty) {
      contentList.add(
        new Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: new Image.network(
            widget.gank.images[0],
            width: 120.0,
            height: 60.0,
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    }
    return new InkWell(
	    onTap: widget.onTap,
      child: new Card(
        child: new Container(
          color: Colors.white,
          child: new Row(
            children: contentList,
          ),
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
