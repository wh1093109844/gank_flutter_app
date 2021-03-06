import 'package:flutter/material.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/reduxes.dart';
import 'package:gank_flutter_app/utils/date_tools.dart';
import 'package:intl/intl.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
    return new InkWell(
	    onTap: widget.onTap,
      child: new Card(
        child: new Container(
          color: Colors.white,
          child: new Column(
            children: [
                _buildTopWidget(),
                _buildContentWidget(),
                _buildBottomWidget()
            ],
          ),
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget _buildContentWidget() {
      List<Widget> contentList = [
          Expanded(
              child: Text(
                  widget.gank.desc ?? '',
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                  ),
              ),
          ),
      ];
      if (widget.gank.images != null && widget.gank.images?.isNotEmpty) {
          contentList.add(
              new Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: new Image.network(
                      widget.gank.images[0],
                      width: 100.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                  ),
              ),
          );
      }
      return Container(
          constraints: BoxConstraints(maxHeight: 60.0, ),
          child: Row(
              children: contentList,
          ),
      );
  }

  Widget _buildTopWidget() {
      DateTime now = DateTime.now();
      DateTime publishedAt = widget.gank.publishedAt;
      Duration duration = now.difference(publishedAt);
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      TextStyle style = TextStyle(fontSize: 11.0, color: Colors.grey);
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              Text('${widget.gank.who ?? ''}@${dateFormat.format(publishedAt)}', style: style,),
              Text(DateTools.duration(DateTime.now(), widget.gank.publishedAt), style: style,),
          ],
      );
  }

  Widget _buildBottomWidget() {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.only(
                    top: 2.0,
                    bottom: 2.0,
                    right: 5.0,
                    left: 5.0),
                  decoration: new BoxDecoration(
                    color: tagColor[widget.gank.type] ?? Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: new Text(
                    widget.gank.type,
                    style: new TextStyle(
                      fontSize: 10.0,
                      color: Colors.white
                    ),
                  ),
                ),
                Expanded(
                  child: new Text(
                    widget.gank.source ?? '',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  )
                ),
                StoreConnector<ReduxStoreState, bool>(
                  converter: (Store<ReduxStoreState> store) => isFavorited(widget.gank, store.state.favorites),
                  builder: (context, isFavorited) => InkWell(
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 15.0,
                    ),
                    onTap: () {
                      var action;
                      if (isFavorited) {
                        action = UnFavoriteGankAction(widget.gank);
                      } else {
                        action = FavoriteGankAction(widget.gank);
                      }
                      StoreProvider.of<ReduxStoreState>(context).dispatch(action);
                    },
                  )
                ),
            ],
        ),
      );
  }
}
