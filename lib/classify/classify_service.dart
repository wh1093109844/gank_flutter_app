import 'dart:async';
import 'dart:collection';

import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';
class ClassifyService {

  bool _isLast = false;

  GankRepository repository = GankRepositoryImpl();

  UnmodifiableListView<Category> get classifys => UnmodifiableListView(Const.classification.subCategory);

  Future<List<Gank>> queryGankList(String type, int pageSize, int pageNum) async {
    var list = await repository.fetch(type, pageSize, pageNum);
    _isLast = list.isEmpty;
    return list;
  }

  bool get hasNext => !_isLast;
}
