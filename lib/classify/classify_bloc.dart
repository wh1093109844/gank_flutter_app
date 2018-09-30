import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';

class ClassifyBloc {

  static const pageSize = 20;

  final _loadClassifysController = BehaviorSubject<String>();
  final _loadGankListControlller = BehaviorSubject<String>();

  var _classifyPages = <String, ClassifyPage>{};
  var _gankSubject = <String, PublishSubject<List<Gank>>>{};

  var _classifys = PublishSubject<List<Category>>();

  final ClassifyService _service;

  Stream<List<Category>> get classifys => _classifys.stream;

  Sink<String> get loadClassifys => _loadClassifysController.sink;

  Stream<List<Gank>> gankStream(String type) => _getGankSubject(type);

  Sink<String> get loadGankList => _loadGankListControlller.sink;

  StreamSubscription<List<Category>> _subscription;

  ClassifyBloc(ClassifyService service): _service = service {
    _subscription = _classifys.stream.listen(handleAddCategory);
    _loadClassifysController.stream.listen((str) => _classifys.add(service.classifys));
    _loadGankListControlller.stream.listen(_handleLoadGankList);
  }

  void dispose() {
    _subscription?.cancel();
  }

  void handleAddCategory(List<Category> categoryList) {
    categoryList.forEach((category) {
      if (!_classifyPages.containsKey(category.code) && _classifyPages[category.code] == null) {
        _classifyPages[category.code] = ClassifyPage(type: category.code);
      }
    });
  }

  void _handleLoadGankList(String type) async {
    ClassifyPage page = _classifyPages[type];
    if (page == null) {
      page = ClassifyPage(type: type);
    }
    List<Gank> list = await _service.queryGankList(type, pageSize, page.pageNum + 1);
    list.insertAll(0, page.gankList);
    page = ClassifyPage(type: type, pageNum: page.pageNum + 1, gankList: list);
    _classifyPages[type] = page;
    _getGankSubject(type).sink.add(page.gankList);
  }

  Subject<List<Gank>> _getGankSubject(String type) {
    PublishSubject<List<Gank>> subject = _gankSubject[type];
    if (subject == null) {
      subject = PublishSubject<List<Gank>>();
      _gankSubject[type] = subject;
    }
    return subject;
  }

}

class ClassifyProvider extends InheritedWidget {

  final ClassifyBloc bloc;

  ClassifyProvider({
            Key key,
            @required this.bloc,
            @required Widget child,
          })
    : assert(child != null),
      super(key: key, child: child);

  static ClassifyBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ClassifyProvider) as ClassifyProvider).bloc;
  }

  @override
  bool updateShouldNotify(ClassifyProvider old) => true;
}

