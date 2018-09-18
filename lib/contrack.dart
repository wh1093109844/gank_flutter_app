
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/gank.dart';

abstract class BasePresenter {
	void start();
}
abstract class BaseView<T extends BasePresenter> {
	T presenter;
	void setPresenter(T presenter) {
		this.presenter = presenter;
		presenter.start();
	}
}

abstract class ClassifyListPresenter extends BasePresenter {
	void fetch({refresh: false});
}

abstract class ClassifyListView extends BaseView<ClassifyListPresenter> {
	void setGankList(List<Gank> gankList);
	void showMessage(String message);
	void showProgress(bool isShow);
}

abstract class ClassifyPrsenter extends BasePresenter {}
abstract class ClassifyView extends BaseView<ClassifyPrsenter> {
	void setTabList(List<Category> list);
}

abstract class HomePresenter extends BasePresenter {
    void fetch(int year, int month, int day);
}

abstract class HomeView extends BaseView<HomePresenter> {
    void showDialog(bool isShow);
    void showMessage(String message);
    void setBannerList(List<Gank> bannerList);
    void setDataList(List<Gank> dataList);
}
