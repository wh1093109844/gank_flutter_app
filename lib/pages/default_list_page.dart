import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/abs_list_page_state.dart';

class DefaultListPage extends AbsListPage {

  ValueChanged<Gank> onTapCallback;

  DefaultListPage(String type, {this.onTapCallback}) : super(type);


  @override
  AbsListPageState<AbsListPage> createListPageState() {
    return _DefaultListPageState();
  }
}

class _DefaultListPageState extends AbsListPageState<DefaultListPage> {

  @override
  Widget buildBody(BuildContext context, ClassifyPage classifyPage) {
    List<Gank> gankList = classifyPage.gankList;
    return new ListView.builder(itemBuilder: (context, index) {
      var child;
      Gank gank = gankList[index];
      if (gank.type == Const.typeWelfare) {
        child = new ImageCard(gank);
      } else {
        child = new TextCard(gank);
      }
      return new InkWell(child: child, onTap: (){
        if (widget.onTapCallback != null) {
          widget.onTapCallback(gank);
        }
      },);
    }, itemCount: gankList.length, controller: scrollController,);
  }

  void handleTap(Gank gank) {
    if (widget.onTapCallback != null) {
      widget.onTapCallback(gank);
    }
  }
}
