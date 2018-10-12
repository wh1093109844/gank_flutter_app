import 'dart:collection';

import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class XianduService {
  var _mainTypeList = <XianduMainType>[];
  var _childTypeList = <String, List<XianduChildType>>{};
  var _xianduList = <String, <int, List<Xiandu>>>{};
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

  Future<UnmodifiableListView<Xiandu>> requestXianduList(String parent, int pageSize, int pageNum) async {
    if ()
  }

  bool _pageIndex(String parent, int pageSize) {
    var map =_xianduList[parent];
    return map.co
  }
}

class _XianduMap {
  var _xianduListMap = <int, List<Xiandu>>{};

}
