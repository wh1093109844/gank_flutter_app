import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/abs_list_page_state.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';

class ImageListPage extends AbsListPage {

  ValueChanged<Gank> onTapCallback;

  ImageListPage(String type, {this.onTapCallback}) : super(type);


  @override
  AbsListPageState<AbsListPage> createListPageState() {
    return _ImageListPageState();
  }
}

class _ImageListPageState extends AbsListPageState<ImageListPage> {

  @override
  Widget buildBody(BuildContext context) {
    return new ListView.builder(itemBuilder: (context, index) {
      var child;
      Gank gank = gankList[index];
      if (gank.type == Const.typeWelfare) {
        child = new ImageCard(gank);
      } else {
        child = new TextCard(gank);
      }
      return new InkWell(child: child, onTap: () {
        if (widget.onTapCallback != null) {
          widget.onTapCallback(gank);
        }
      });
    }, itemCount: gankList.length, controller: scrollController,);
  }
}
