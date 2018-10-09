import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';
import 'package:gank_flutter_app/classify/measure.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/abs_list_page_state.dart';

class ImageListPage extends AbsListPage {

  ValueChanged<Gank> onTapCallback;

  ImageListPage(String type, {this.onTapCallback}) : super(type);


  @override
  AbsListPageState<AbsListPage> createListPageState() {
    return _ImageListPageState();
  }
}

class _ImageListPageState extends AbsListPageState<ImageListPage> {

  List<Position> positionList = [];
  double margin = 5.0;
  int rowNum = 3;
  int columnNum = 3;
  int maxItemSize = 3;

  Measure measure = Measure();

  @override
  Widget buildBody(BuildContext context, ClassifyPage page) {
    List<Gank> gankList = page.gankList;
    measure = page.measure;
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildListItem(context, gankList, index);
      },
      itemCount: measure.length,
      controller: scrollController,);
  }
  
  Widget buildListItem(context, List<Gank> gankList, index) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = (width - ((columnNum + 1) * margin)) / columnNum;
    int start = measure.blocks.sublist(0, max(0, index)).map((block) => block.size).fold(0, (a, b) => a + b);
    Block block = measure.blocks[index];
    List<Widget> list = [];
    int heightSpec = 0;
    for (int i = 0; i < block.size; i++) {
      var p = block.get(i);
      var gank = gankList[start + i];
      heightSpec = max(heightSpec, p.height + p.top);
      list.add(_buildImage(context, gank, p));
    }
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: heightSpec * itemWidth + heightSpec * margin),
      child: Stack(
        children: list,
      ),
    );
  }
  
  Widget _buildImage(context, gank, position) {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = (width - ((columnNum + 1) * margin)) / columnNum;
    double left = margin * (position.left + 1) + position.left * itemWidth;
    double top = position.top * itemWidth + position.top * margin;
    double imageWidth = position.width * itemWidth + (position.width - 1) * margin;
    double imageHeight = position.height * itemWidth + (position.height - 1) * margin;
    return Positioned(
      child: InkWell(
        child: PhotoHolder(
          gank.url,
          tag: gank.id,
          fit: BoxFit.cover,
          width: imageWidth,
          height: imageHeight,
        ),
        onTap: () {
          if (widget.onTapCallback != null) {
            widget.onTapCallback(gank);
          }
        },
      ),
      left: left,
      top: top,
    );
  }
}
