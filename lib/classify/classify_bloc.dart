import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/classify/measure.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';

class ClassifyBloc extends BlocBase {

  static const pageSize = 20;

  final _measure = Measure();

  var _classifyPages = <String, ClassifyPage>{};
  var _gankSubject = <String, BehaviorSubject<ClassifyPage>>{};
  var _pageIndexSubject = <String, BehaviorSubject<int>>{};
  var _scrollChangedSubject = <String, PublishSubject<double>>{};
  var _shouldShowProgressSubject = <String, BehaviorSubject<bool>>{};

  var _classifys = BehaviorSubject<ClassifyWrapper>();
  var _classifysChangeSubject = PublishSubject<int>();

  final ClassifyService _service;
  ClassifyWrapper _classifyWrapper;

  ///分类数据类型
  Stream<ClassifyWrapper> get outClassifys => _classifys.stream;
  Sink<ClassifyWrapper> get _inClassifys => _classifys.sink;

  ///tab切换
  Sink<int> get inClassifyChanged => _classifysChangeSubject.sink;
  Stream<int> get _outClassifyChanged => _classifysChangeSubject.stream;

  ///分类数据
  Stream<ClassifyPage> outGankStream(String type) => _getGankSubject(type);
  Sink<ClassifyPage> _inGankStream(String type) => _getGankSubject(type);

  ///加载分类数据
  Sink<int> inLoadGankList(type) => _getPageNumSubject(type).sink;
  Stream<int> outLoadGankList(type) => _getPageNumSubject(type).stream;

  ///滚动变化
  Sink<double> inScrolledChanged(type) => handleScrolledChangedSubject(type);

  ///是否显示加载中
  Stream<bool> outShouldShowProgress(type) => _handleShouldShowProgressSubject(type);

  var listeners = <StreamSubscription>[];

  bool isLoading = false;

  ClassifyBloc(ClassifyService service): _service = service {
    _classifyWrapper = ClassifyWrapper(categoryList: service.classifys, index: 0);
    listeners.add(_outClassifyChanged.listen((index) => _classifyWrapper.index = index));
    _inClassifys.add(_classifyWrapper);
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
    BehaviorSubject<ClassifyPage> subject = _gankSubject[type];
    if (subject == null) {
      subject = BehaviorSubject<ClassifyPage>(seedValue: ClassifyPage(type: type, measure: Measure()));
      _gankSubject[type] = subject;
      inLoadGankList(type).add(1);
    }
    return subject;
  }

  Subject<int> _getPageNumSubject(String type) {
    BehaviorSubject<int> subject = _pageIndexSubject[type];
    if (subject == null) {
      subject = BehaviorSubject(seedValue: 1);
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
    _inGankStream(type).add(page);
    isLoading = false;
  }

  Subject<bool> _handleShouldShowProgressSubject(type) {
    Subject<bool> subject = _shouldShowProgressSubject[type];
    if (subject == null) {
      subject = BehaviorSubject<bool>(seedValue: false);
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

class ClassifyWrapper {
  final List<Category> categoryList;
  int index;

  ClassifyWrapper({this.categoryList, this.index = 0});
}

