
import 'dart:io';

import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank_content.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';
import 'package:gank_flutter_app/utils/file_tools.dart';

class GankCenterPresenterImpl implements GankCenterPresenter {

  static const String fileName = 'gank_content_';
  static const int pageSize = 20;
  int pageNum = 1;

  GankCenterView view;
  bool _isLoading = false;
  GankRepository repository = GankRepositoryImpl();

  GankCenterPresenterImpl(this.view){
    view.setPresenter(this);
  }

  @override
  void fatchGankCenterList() {
    if (_isLoading) {
      return;
    }
    _isLoading = true;
    view.showDialog(true);
    repository.fetchGankContentList(pageSize, pageNum).then((List<Content> list) {
      view.setGankContentList(list);
      view.showDialog(false);
      _isLoading = false;
      pageNum++;
    }, onError: (error) {
      print(error);
      view.showDialog(false);
      view.showMessage('加载失败');
      _isLoading = false;
    });
  }

  @override
  void start() {
    pageNum = 1;
    fatchGankCenterList();
  }

  @override
  void onItemClick(Content content) {
    view.showDialog(true);
    FileTools.getOrSaveFile('$fileName${content.id}.html', content.content).then((File file) {
      view.showDialog(false);
      var uri = Uri.file(file.path);
      view.openWebview(content.title, uri.toString());
    }, onError: (error) {
      print(error);
      view.showDialog(false);
      view.showMessage('打开失败');
    });
  }
}
