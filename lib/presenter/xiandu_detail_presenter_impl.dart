import 'dart:async';
import 'dart:io';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:path_provider/path_provider.dart';

class XianduDetailPresenterImpl implements XianduDetailPresenter {

  static const String fileName = 'xiandu_content.html';

  XianduDetailView view;
  Xiandu xiandu;

  XianduDetailPresenterImpl(this.view, this.xiandu) {
    view.setPresenter(this);
  }

  @override
  void start() {
    view.showDialog(true);
    saveFile().then((path) {
      view.showDialog(false);
      view.setUrl(Uri.file(path).toString());
    }, onError: (error) {
      print(error);
      view.showDialog(false);
    });
  }

  Future<File> _getFile() async {
    Directory directory = await getTemporaryDirectory();
    String dir = directory.path;
    print(directory);
    return new File('$dir/$fileName');
  }

  Future<String> saveFile() async {
    File file = await _getFile();
    file.writeAsString(xiandu.content);
    return file.path;
  }
}
