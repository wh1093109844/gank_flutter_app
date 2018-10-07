import 'dart:collection';
import 'package:gank_flutter_app/classify/measure.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class ClassifyPage {

  final int _pageNum;
  final String type;
  final List<Gank> _gankList = [];
  Measure measure;
  double scrollY;

  ClassifyPage({this.type, pageNum = 0, gankList = const <Gank>[], this.measure, this.scrollY = 0.0}): _pageNum = pageNum {
    _gankList.addAll(gankList);
  }

  int get pageNum => _pageNum;
  UnmodifiableListView<Gank> get gankList => UnmodifiableListView(_gankList);
}
