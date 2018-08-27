import '../const.dart';
import '../contrack.dart';

class HomePresenterImpl extends HomePrsenter {

    HomeView view;

    HomePresenterImpl(this.view) {
        view.setPresenter(this);
    }

    @override
    void start() {
        view.setTabList(Const.types);
    }
}