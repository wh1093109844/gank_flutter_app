import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/abs_list_page_state.dart';

class ImageListPage extends AbsListPage {
  ImageListPage(String type) : super(type);


  @override
  AbsListPageState<AbsListPage> createListPageState() {
    return _ImageListPageState();
  }
}

class _ImageListPageState extends AbsListPageState {

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
      return new InkWell(child: child, onTap: (){
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(gank.type)));
      },);
    }, itemCount: gankList.length, controller: scrollController,);
  }
}
