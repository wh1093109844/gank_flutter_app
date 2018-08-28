import '../contrack.dart';

class MainPresenterImpl extends MainPresenter {

	static const pageSize = 20;
	int pageNum = 0;

	MainView view;

	MainPresenterImpl(this.view);

    @override
    void start() {
    // TODO: implement start
    }

    @override
    void fetch(String type, {refresh: false}) {
        pageNum = refresh ? 0 : pageNum + 1;
    }

    void fetchGankList(String type, int pageNum) {
    	view.showProgress(true);

    }

}