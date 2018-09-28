import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
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
  double margin = 0.0;
  int rowNum = 12;
  int columnNum = 3;
  int maxItemSize = 3;

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      children: buildListItems(),
      controller: scrollController,
    );
  }

  List<Widget> buildListItems() {
    double width = MediaQuery.of(context).size.width;
    double itemWidth = (width - ((columnNum + 1) * margin)) / columnNum;
    double height = itemWidth * rowNum + margin * rowNum;
    List<List<int>> blocks = initBlock(columnNum, rowNum);
    List<Widget> list = [];
    List<Widget> children = [];
    for (int i = 0; i < gankList.length; i++) {
      Gank gank = gankList[i];
      Position position = null;
      if (i < positionList.length) {
        position = positionList[i];
      } else {
        position = getPosition(blocks);
        positionList.add(position);
      }
      fillBlocks(blocks, position);
      double left = margin * (position.left + 1) + position.left * itemWidth;
      double top = position.top * itemWidth + position.top * margin;
      double imageWidth = position.width * itemWidth + (position.width - 1) * margin;
      double imageHeight = position.height * itemWidth + (position.height - 1) * margin;
      children.add(
        Positioned(
          child: InkWell(
            child: PhotoHolder(
              gank.url,
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
        )
      );
      if (isComplete(blocks)) {
        blocks = initBlock(columnNum, rowNum);
        list.add(
          Container(
            constraints: BoxConstraints(maxHeight: height),
            padding: EdgeInsets.only(bottom: margin),
            child: Stack(
              children: children
            ),
          )
        );
        children = [];
      }
    }
    if (children.isNotEmpty) {
      list.add(
        Container(
          constraints: BoxConstraints(maxHeight: height),
          padding: EdgeInsets.only(bottom: margin),
          child: Stack(
            children: children
            ),
          )
      );
    }
    return list;
  }

  Position getPosition(List<List<int>> blocks) {
    Point p = getStart(blocks);
    Point size = getSizePoint(blocks, p);
    return Position(left: p.x, top: p.y, width: size.x, height: size.y);
  }

  Point getSizePoint(List<List<int>> blocks, Point p) {
    Random random = Random();
    int maxWidth = getMaxWidth(blocks, p);
    int maxHeight = min(maxItemSize, blocks.length - p.y);
    if (maxWidth == 3 && maxHeight < 2) {
      maxWidth = 1;
    }
    int width = random.nextInt(maxWidth) + 1;
    int height = width == 3 ? 2 : random.nextInt(maxHeight) + 1;
    return Point(width, height);
  }

  void fillBlocks(List<List<int>> blocks, Position position) {
    for (int j = position.top; j < position.top + position.height; j++) {
      List<int> row = blocks[j];
      for (int k = position.left; k < position.left + position.width; k++) {
        row[k] = 1;
      }
    }
  }

  bool isComplete(List<List<int>> blocks) {
    bool result = true;
    for (int i = 0; i < blocks.length; i++) {
      List<int> row = blocks[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] == 0) {
          result = false;
          break;
        }
      }
      if (!result) {
        break;
      }
    }
    return result;
  }

  List<List<int>> initBlock(int width, int height) {
    List<List<int>> list = [];
    for (int i = 0; i < height; i++) {
      List<int> row = [];
      for (int j = 0; j < width; j++) {
        row.add(0);
      }
      list.add(row);
    }
    return list;
  }

  Point<int> getStart(List<List<int>> blocks) {
    int w = 0;
    int h = 0;
    for (h = 0; h < blocks.length; h++) {
      List<int> row = blocks[h];
      for (w = 0; w < row.length; w++) {
        if (row[w] == 0) {
          break;
        }
      }
      if (w < row.length) {
        break;
      }
    }
    return Point(w, h);
  }

  int getMaxWidth(List<List<int>> blocks, Point<int> point) {
    int maxW = 1;
    for (int i = point.x + 1; i < blocks[point.y].length; i++) {
      if (blocks[point.y][i] == 0) {
        maxW += 1;
      } else {
        break;
      }
    }
    return min(maxW, maxItemSize);
  }
}

class Position {
  int left;
  int top;
  int width;
  int height;

  Position({this.left, this.top, this.width, this.height});

  @override
  String toString() {
    // TODO: implement toString
    return 'Position(left: $left, top: $top, width: $width, height: $height)';
  }
}
