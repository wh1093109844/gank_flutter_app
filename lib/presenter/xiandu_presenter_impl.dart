import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class XianduPresenterImpl extends XianduPresenter {

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
}
