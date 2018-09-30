import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';

class ClassifyBloc {
  final _loadNextController = BehaviorSubject<String>();

  var _classifyPages = <String, ClassifyPage>{};

  var _classifys = PublishSubject<List<Category>>();

  final ClassifyService _service;

  Stream<List<Category>> get classifys => _classifys.stream;

  Sink<String> get loadNextPage => _loadNextController.sink;

  StreamSubscription<List<Category>> _subscription;

  ClassifyBloc(ClassifyService service): _service = service {
    _subscription = _classifys.stream.listen(handleAddCategory);
    _classifys.add(service.classifys);
  }

  void dispose() {
    _subscription?.cancel();
  }

  void handleAddCategory(List<Category> categoryList) {
    categoryList.forEach((category) {
      if (!_classifyPages.containsKey(category.code) && _classifyPages[category.code] == null) {
        _classifyPages[category.code] = ClassifyPage(category.code);
      }
    });
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

