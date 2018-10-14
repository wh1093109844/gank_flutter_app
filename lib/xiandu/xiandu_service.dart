import 'dart:async';
import 'dart:collection';

import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class XianduService {
  static const int pageSize = 20;

  var _mainTypeList = <XianduMainType>[];
  var _childTypeList = <String, List<XianduChildType>>{};
  var _xianduList = Map<String, Map<int, List<Xiandu>>>();
  var _repository = GankRepositoryImpl();

  Future<UnmodifiableListView<XianduMainType>> requestMainTypeList() async {
    if (_mainTypeList.isEmpty) {
      _mainTypeList = await _repository.fetchXianduMainType();
    }
    return UnmodifiableListView(_mainTypeList);
  }

  Future<UnmodifiableListView<XianduChildType>> requestChildTypeList(String parent) async {
    List<XianduChildType> list = _childTypeList[parent];
    if (list == null) {
      list = await _repository.fetchXianduChildType(parent);
      _childTypeList[parent] = list;
    }
    return UnmodifiableListView(list);
  }

  Future<UnmodifiableListView<Xiandu>> requestXianduList(String parent, int pageNum) async {
    if (!_isRequested(parent, pageNum)) {
      List<Xiandu> list = await _repository.fetchXianduList(parent, pageSize, pageNum);
      var map = _xianduList[parent];
      if (map == null) {
        map = <int, List<Xiandu>>{};
        _xianduList[parent] = map;
      }
      map[pageNum] = list;
    }
    return UnmodifiableListView(_getXianduList(parent, pageNum));
  }

  bool _isRequested(String parent, int pageNum) {
    var map =_xianduList[parent];
    return map?.containsKey(pageNum) ?? false;
  }

  List<Xiandu> _getXianduList(String parent, int pageNum) {
    var map = _xianduList[parent];
    var keyList = map.keys.where((i) => i <= pageNum).toList();
    keyList.sort((a, b) => a - b);
    var list = <Xiandu>[];
    keyList.map((index) => map[index]).forEach((xianduList) => list.addAll(xianduList));
    return list;
  }
}
