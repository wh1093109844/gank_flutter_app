import 'dart:async';
import 'dart:io';

import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';
import 'package:path_provider/path_provider.dart';

class XianduPresenterImpl extends XianduPresenter {

  static const String fileName = 'xiandu_content.html';

  XianduTypeView mainTypeView;
  XianduView xianduView;

  GankRepository repository = new GankRepositoryImpl();

  Map<String, List<XianduChildType>> map = Map();

  static const int pageSize = 20;
  int pageNum = 1;

  bool isLoading = false;

  XianduPresenterImpl(this.mainTypeView) {
    this.mainTypeView.setPresenter(this);
  }

  @override
  void fetchChildTypeList(String parent) {
    mainTypeView.showDialog(true);
    if (map.containsKey(parent)) {
      mainTypeView.setChildTypeList(map[parent]);
      mainTypeView.showDialog(false);
    } else {
      repository.fetchXianduChildType(parent).then((List<XianduChildType> list) {
        map[parent] = list;
        mainTypeView.setChildTypeList(list);
        mainTypeView.showDialog(false);
      }, onError: (error) {
        print(error);
        mainTypeView.showDialog(false);
      });
    }
  }

  @override
  void fetchMainTypeList() {
    mainTypeView.showDialog(true);
    repository.fetchXianduMainType().then((List<XianduMainType> list) {
      mainTypeView.showDialog(false);
      mainTypeView.setMainTypeList(list);
    }, onError: (error) {
      print(error);
      mainTypeView.showDialog(false);
    });
  }

  @override
  void fetchXianduList(String id) {
    if (isLoading) {
      return;
    }
    isLoading = true;
    mainTypeView.showDialog(true);
    repository.fetchXianduList(id, pageSize, pageNum).then((List<Xiandu> list) {
      pageNum++;
      mainTypeView.showDialog(false);
      mainTypeView.setXianduList(list);
      isLoading = false;
    }, onError: (error) {
      isLoading = false;
      print(error);
      mainTypeView.showDialog(false);
    });
  }

  @override
  void start() {
    fetchMainTypeList();
  }

  @override
  void saveHtml(String content) {
    print('content\t$content');
    mainTypeView.showDialog(true);
    saveFile(content).then((path) {
      mainTypeView.showDialog(false);
      mainTypeView.setUrl(Uri.file(path).toString());
    }, onError: (error) {
      print(error);
      mainTypeView.showDialog(false);
    });
  }

  Future<File> _getFile() async {
    Directory directory = await getTemporaryDirectory();
    String dir = directory.path;
    print(directory);
    return new File('$dir/$fileName');
  }

  Future<String> saveFile(String content) async {
    File file = await _getFile();
    file.writeAsString(content);
    return file.path;
  }
}
