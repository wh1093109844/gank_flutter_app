
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/entry/gank_content.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';

abstract class BasePresenter {
	void start();
}
abstract class BaseView<T extends BasePresenter> {
	T presenter;
	void setPresenter(T presenter) {
		this.presenter = presenter;
	}

  void showDialog(bool isShow);
  void showMessage(String message);
}

abstract class ClassifyListPresenter extends BasePresenter {
	void fetch({refresh: false});
}

abstract class ClassifyListView extends BaseView<ClassifyListPresenter> {
	void setGankList(List<Gank> gankList);
}

abstract class ClassifyPrsenter extends BasePresenter {}
abstract class ClassifyView extends BaseView<ClassifyPrsenter> {
	void setTabList(List<Category> list);
}

abstract class HomePresenter extends BasePresenter {
    void fetch(int year, int month, int day);
}

abstract class HomeView extends BaseView<HomePresenter> {

    void setBannerList(List<Gank> bannerList);
    void setDataList(List<Gank> dataList);
}

abstract class XianduPresenter extends BasePresenter {
  void fetchMainTypeList();
  void fetchChildTypeList(String parent);
  void fetchXianduList(String id);
  void saveHtml(String content);
}

abstract class XianduTypeView extends BaseView<XianduPresenter> {
  void setMainTypeList(List<XianduMainType> list);
  void setChildTypeList(List<XianduChildType> list);
  void setXianduList(List<Xiandu> list);
  void setUrl(String url);
}

abstract class XianduView extends BaseView<XianduPresenter> {
  void setXianduList(List<Xiandu> list);
}

abstract class XianduDetailPresenter extends BasePresenter {}
abstract class XianduDetailView extends BaseView<XianduDetailPresenter> {
  void setUrl(String url);
}

abstract class GankCenterPresenter extends BasePresenter {
  void fatchGankCenterList();
}

abstract class GankCenterView extends BaseView<GankCenterPresenter> {
  void setGankContentList(List<Content> contentList);
}
