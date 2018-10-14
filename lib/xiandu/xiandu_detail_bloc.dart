import 'dart:async';
import 'dart:io';

import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/utils/file_tools.dart';
import 'package:rxdart/rxdart.dart';

class XianduDetailBloc extends BlocBase {

  static const String fileName = 'xiandu_content.html';
  Xiandu _xiandu;

  var _urlSubject = BehaviorSubject<String>(seedValue: null);
  var _detailSubject = BehaviorSubject<Xiandu>(seedValue: null);

  Sink<String> get _inUrl => _urlSubject.sink;
  Stream<String> get outUrl => _urlSubject.stream;

  Sink<Xiandu> get _inTitle => _detailSubject.sink;
  Stream<Xiandu> get outTitle => _detailSubject.stream;

  XianduDetailBloc({Xiandu xiandu}): assert(xiandu != null), this._xiandu = xiandu {
    _inTitle.add(xiandu);
    if (xiandu?.content?.isEmpty ?? true) {
      _inUrl.add(xiandu.url);
    } else {
      _saveXianduContent();
    }
  }

  void _saveXianduContent() async {
    File file = await FileTools.getOrSaveFile(fileName, _xiandu.content);
    _xiandu.url = file.path;
    _inTitle.add(_xiandu);
  }

  @override
  void dispose() {
    _urlSubject.close();
  }
}
