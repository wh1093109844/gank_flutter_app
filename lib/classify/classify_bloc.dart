import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/classify/measure.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';

class ClassifyBloc {

  static const pageSize = 20;

  final _loadClassifysController = BehaviorSubject<String>();
  final _measure = Measure();

  var _classifyPages = <String, ClassifyPage>{};
  var _gankSubject = <String, PublishSubject<ClassifyPage>>{};
  var _pageIndexSubject = <String, PublishSubject<int>>{};
  var _scrollChangedSubject = <String, PublishSubject<double>>{};
  var _shouldShowProgressSubject = <String, PublishSubject<bool>>{};
  var _measureSubject = BehaviorSubject<Measure>();

  var _classifys = PublishSubject<ClassifyWrapper>();
  var _classifysChangeSubject = PublishSubject<int>();

  final ClassifyService _service;
  ClassifyWrapper _classifyWrapper;

  Stream<ClassifyWrapper> get classifys => _classifys.stream;

  Sink<String> get loadClassifys => _loadClassifysController.sink;
  Sink<int> get classifyChanged => _classifysChangeSubject.sink;

  Stream<ClassifyPage> gankStream(String type) => _getGankSubject(type);

  Sink<int> loadGankListIndex(type) => _getPageNumSubject(type).sink;
  Stream<Measure> get measure => _measureSubject.stream;
  Sink<double> scrolledChanged(type) => handleScrolledChangedSubject(type);
  Stream<bool> shouldShowProgress(type) => _handleShouldShowProgressSubject(type);

  var listeners = <StreamSubscription>[];

  bool isLoading = false;

  ClassifyBloc(ClassifyService service): _service = service {
    _classifyWrapper = ClassifyWrapper(categoryList: service.classifys, index: 0);
    listeners.add(_classifysChangeSubject.stream.listen((index) => _classifyWrapper.index = index));
    listeners.add(_loadClassifysController.stream.listen((str) => _classifys.add(_classifyWrapper)));
  }

  void dispose() {
    listeners.forEach((subscription) => subscription.cancel());
  }

  void _measureSize(int length) {
    int total = _measure.total;
    if (length < total) {
      return;
    }
    for (int i = total; i < length; i++) {
      Block block = _measure.getBlock(i);
      if (block.isComplete()) {
        block = Block();
        _measure.add(block);
      }
      block.next();
    }
  }

  Subject<ClassifyPage> _getGankSubject(String type) {
    PublishSubject<ClassifyPage> subject = _gankSubject[type];
    if (subject == null) {
      subject = PublishSubject<ClassifyPage>();
      _gankSubject[type] = subject;
    }
    return subject;
  }

  Subject<int> _getPageNumSubject(String type) {
    PublishSubject<int> subject = _pageIndexSubject[type];
    if (subject == null) {
      subject = PublishSubject();
      _pageIndexSubject[type] = subject;
      listeners.add(subject.stream.listen((pageNum) {
        if (_service.hasNext && !isLoading) {
          _handleLoadGankList(type, pageNum);
        }
      }));
    }
    return subject;
  }

  void _handleLoadGankList(String type, int pageNum) async {
    isLoading = true;
    ClassifyPage page = _classifyPages[type];
    int current = page == null ? 0 : page.pageNum;
    if (pageNum > current) {
      _handleShouldShowProgress(type, true);
      List<Gank> list = await _service.queryGankList(type, pageSize, current + 1);
      if (page != null) {
        list.insertAll(0, page.gankList);
      }
      if (type == Const.welfare.code) {
        _measureSize(list.length);
      }
      page = ClassifyPage(type: type, pageNum: current + 1, gankList: list, measure: _measure, scrollY: page?.scrollY);
    }
    _handleShouldShowProgress(type, false);
    _classifyPages[type] = page;
    _getGankSubject(type).sink.add(page);
    isLoading = false;
  }

  Subject<bool> _handleShouldShowProgressSubject(type) {
    Subject<bool> subject = _shouldShowProgressSubject[type];
    if (subject == null) {
      subject = PublishSubject<bool>();
      _shouldShowProgressSubject[type] = subject;
    }
    return subject;
  }

  void _handleShouldShowProgress(type, show) {
    _handleShouldShowProgressSubject(type).sink.add(show);
  }

  Subject<double> handleScrolledChangedSubject(type) {
    Subject<double> subject = _scrollChangedSubject[type];
    if (subject == null) {
      subject = PublishSubject<double>();
      _scrollChangedSubject[type] = subject;
      listeners.add(subject.stream.listen((scrollY) => _handleScrolledChangedListener(type, scrollY)));
    }
    return subject;
  }

  void _handleScrolledChangedListener(type, scrollY) {
    ClassifyPage page = _classifyPages[type];
    if (page == null) {
      page = ClassifyPage(type: type, scrollY: scrollY);
      _classifyPages[type] = page;
    } else {
      page.scrollY = scrollY;
    }
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

class ClassifyWrapper {
  final List<Category> categoryList;
  int index;

  ClassifyWrapper({this.categoryList, this.index = 0});
}

