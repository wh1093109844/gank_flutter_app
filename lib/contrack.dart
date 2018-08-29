import 'entry/gank.dart';

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

abstract class MainPresenter extends BasePresenter {
	void fetch({refresh: false});
}

abstract class MainView extends BaseView<MainPresenter> {
	void setGankList(List<Gank> gankList);
	void showMessage(String message);
	void showProgress(bool isShow);
}

abstract class HomePrsenter extends BasePresenter {}
abstract class HomeView extends BaseView<HomePrsenter> {
	void setTabList(List<String> list);
}