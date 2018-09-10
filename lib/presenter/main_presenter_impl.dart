import '../contrack.dart';
import '../repository/remote_repository.dart';
import '../repository/remote_repository_impl.dart';
class MainPresenterImpl extends MainPresenter {

	static const pageSize = 50;
	int pageNum = 0;

	MainView view;
	GankRepository repository = new GankRepositoryImpl();
    String type;
    bool _isLoading = false;
	MainPresenterImpl(this.view, this.type) {
	    view.setPresenter(this);
    }

    @override
    void start() {
        fetch();
    }

    @override
    void fetch({refresh: false}) {
	    if (_isLoading) {
	      return;
      }
        _isLoading = true;
        pageNum = refresh ? 0 : pageNum + 1;
        _fetchGankList(type, pageNum);
    }

    void _fetchGankList(String type, int pageNum) {
    	view.showProgress(true);
    	repository.fetch(type, pageSize, pageNum).then((list){
    	    _isLoading = false;
    	    view.setGankList(list);
    	    view.showProgress(false);
        }, onError: (e) {
    	    _isLoading = false;
    	    view.showMessage(e.toString());
    	    view.showProgress(false);
        });

    }

}