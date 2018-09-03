import '../contrack.dart';
import '../repository/remote_repository.dart';
import '../repository/remote_repository_impl.dart';
class MainPresenterImpl extends MainPresenter {

	static const pageSize = 100;
	int pageNum = 0;

	MainView view;
	GankRepository repository = new GankRepositoryImpl();
    String type;
	MainPresenterImpl(this.view, this.type) {
	    view.setPresenter(this);
    }

    @override
    void start() {
        fetch();
    }

    @override
    void fetch({refresh: false}) {
        pageNum = refresh ? 0 : pageNum + 1;
        fetchGankList(type, pageNum);
    }

    void fetchGankList(String type, int pageNum) {
    	view.showProgress(true);
    	repository.fetch(type, pageSize, pageNum).then((list){
    	    view.setGankList(list);
    	    view.showProgress(false);
        }, onError: (e) {
    	    view.showMessage(e.toString());
    	    view.showProgress(false);
        });

    }

}