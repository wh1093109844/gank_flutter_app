import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';

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