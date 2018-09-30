import 'dart:collection';

import 'package:gank_flutter_app/entry/gank.dart';

class ClassifyPage {

  int _pageNum = 1;
  String type;
  List<Gank> _gankList;

  ClassifyPage(this.type);

  int get pageNum => _pageNum;
  UnmodifiableListView<Gank> get gankList => UnmodifiableListView(_gankList);
}
