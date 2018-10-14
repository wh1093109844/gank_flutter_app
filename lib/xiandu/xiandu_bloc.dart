import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/xiandu/xiandu_service.dart';

import 'package:rxdart/rxdart.dart';
class XianduBloc extends BlocBase {

  var _xianduListSubject = BehaviorSubject<UnmodifiableListView>(seedValue: UnmodifiableListView([]));
  var _loadChildSubject = PublishSubject<Object>();
  var _loadxianduListSubject = PublishSubject<int>();
  var _currentSubject = BehaviorSubject<TypeWrapper>(seedValue: TypeWrapper());
  var _shouldShowProgressSubject = BehaviorSubject<bool>(seedValue: false);
  var _popSubject = PublishSubject();

  int _pageIndex = 1;

  XianduMainType _mainType = null;
  XianduChildType _childType = null;

  bool _isLoading = false;


  XianduService _xianduService;

  Stream<UnmodifiableListView> get outList => _xianduListSubject.stream;
  Sink<UnmodifiableListView> get _inList => _xianduListSubject.sink;

  Sink<Object> get inLoadChild => _loadChildSubject.sink;
  Stream<Object> get _outLoadChild => _loadChildSubject.stream;

  Sink<TypeWrapper> get _inCurrent => _currentSubject.sink;
  Stream<TypeWrapper> get outCurrent => _currentSubject.stream;

  Sink<int> get inLoadList => _loadxianduListSubject.sink;
  Stream<int> get _outLoadList => _loadxianduListSubject.stream;

  Sink<bool> get _inShouldShowProgress => _shouldShowProgressSubject.sink;
  Stream<bool> get outShouldShowProgress => _shouldShowProgressSubject.stream;

  Sink get inPop => _popSubject.sink;
  Stream get _outPop => _popSubject.stream;

  XianduBloc({@required XianduService service}): _xianduService = service {
    _loadMainTypeList();
    _outLoadChild.listen(_handleLoadChild);
    _outLoadList.listen((index) {
      if (_mainType != null && _childType != null) {
        _pageIndex++;
        _handleLoadXiandu();
      }
    });
    _outPop.listen(_handlePop);

  }

  void _loadMainTypeList() {
    _inShouldShowProgress.add(true);
    _xianduService.requestMainTypeList().then((list) {
      _inShouldShowProgress.add(false);
      _inList.add(list);
    }, onError: (error) {
      _inShouldShowProgress.add(false);
      print(error);
    });
  }

  void _handleLoadChild(obj) {
    if (obj == null) {
      return;
    }

    if (obj is XianduMainType) {
      _mainType = obj;
      _handleLoadChildType();
    } else if (obj is XianduChildType) {
      _childType = obj;
      _pageIndex = 1;
      _handleLoadXiandu();
    }
    _inCurrent.add(TypeWrapper(mainType: _mainType, childType: _childType));
  }

  void _handleLoadChildType() async {
    if (_mainType == null) {
      return;
    }
    _inShouldShowProgress.add(true);
    var childTypeList = await _xianduService.requestChildTypeList(_mainType.en_name);
    _inList.add(childTypeList);
    _inShouldShowProgress.add(false);
  }

  void _handleLoadXiandu() async {
    if (_childType == null && _isLoading) {
      return;
    }
    _isLoading = true;
    _inShouldShowProgress.add(true);
    var list = await _xianduService.requestXianduList(_childType.id, _pageIndex);
    _inList.add(list);
    _inShouldShowProgress.add(false);
    _isLoading = false;
  }

  void _handlePop(obj) {
    if (_childType != null) {
      _childType = null;
      _handleLoadChildType();
    } else if (_mainType != null) {
      _mainType = null;
      _loadMainTypeList();
    }
    _inCurrent.add(TypeWrapper(mainType: _mainType, childType: _childType));
  }

  @override
  void dispose() {
    _xianduListSubject.close();
    _loadChildSubject.close();
    _loadxianduListSubject.close();
  }
}

class TypeWrapper {
  XianduMainType mainType;
  XianduChildType childType;

  TypeWrapper({this.mainType, this.childType});
}
