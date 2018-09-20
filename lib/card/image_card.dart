import 'package:flutter/material.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/utils/date_tools.dart';
import 'package:intl/intl.dart';

class ImageCard extends StatefulWidget {
  Gank gank;

  ImageCard(this.gank);

  @override
  ImageCardState createState() {
    return new ImageCardState();
  }

}

class ImageCardState extends State<ImageCard> {

  bool _favorites = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle style = new TextStyle(color: Colors.white, fontSize: 12.0);
    DateFormat format = DateFormat('yyyy-MM-dd');
    List<Widget> widgetList = [];
    widgetList.add(new PhotoHolder(widget.gank.url));
    if (widget.gank.who != null && widget.gank.who.isNotEmpty) {
      widgetList.add(new Positioned(
        child: new Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            color: Color.fromARGB(100, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Text(
                  '${widget.gank.who}@${format.format(widget.gank.publishedAt)}',
                  style: style,
                  maxLines: 1,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(DateTools.duration(DateTime.now(), widget.gank.publishedAt), style: style,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _favorites = !_favorites;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(_favorites ? Icons.favorite : Icons.favorite_border, color: Colors.pink, size: 15.0,),
                  ),
                ),
              ],
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
  BoxFit fit;
  PhotoHolder(this.photo, {this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return new Hero(
        tag: photo,
        child: Material(
            color: Colors.transparent,
            child: FadeInImage.assetNetwork(
                placeholder: 'res/images/place_holder.jpg',
                image: photo,
                fit: fit,),
            ),
        );
  }
}
