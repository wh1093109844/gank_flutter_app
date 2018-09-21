import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class ClassifyListPresenterImpl extends ClassifyListPresenter {

	static const pageSize = 50;
	int pageNum = 0;

	ClassifyListView view;
	GankRepository repository = new GankRepositoryImpl();
    String type;
    bool _isLoading = false;
	ClassifyListPresenterImpl(this.view, this.type) {
	    view.setPresenter(this);
    }

    @override
    void start() {
	    DateTime today = DateTime.now();
        fetch();
        repository.fetchDataByDate(today.year, today.month, today.day);
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
    	view.showDialog(true);
    	repository.fetch(type, pageSize, pageNum).then((list){
    	    _isLoading = false;
    	    view.setGankList(list);
    	    view.showDialog(false);
        }, onError: (e) {
    	    _isLoading = false;
    	    view.showMessage(e.toString());
    	    view.showDialog(false);
        });

    }
}
