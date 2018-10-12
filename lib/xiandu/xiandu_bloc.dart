import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';

import 'package:rxdart/rxdart.dart';
class XianduBloc extends BlocBase {

  var _xianduListSubject = BehaviorSubject<List>(seedValue: []);
  var _loadXianduChildSubject = PublishSubject<String>();
  var _loadxianduListSubject = PublishSubject<int>();

  var _mainType = null;
  var _childType = null;

  var _childTypeListMap = <String, List<XianduChildType>>{};
  var _xianduListMap = <String, List<Xiandu>>{};

  Stream get outList => _xianduListSubject.stream;
  Sink get _inList => _xianduListSubject.sink;

  XianduBloc();

  @override
  void dispose() {
    _xianduListSubject.close();
    _loadXianduChildSubject.close();
    _loadxianduListSubject.close();
  }
}
