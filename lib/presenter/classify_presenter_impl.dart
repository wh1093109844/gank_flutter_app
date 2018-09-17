import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';

class HomePresenterImpl extends ClassifyPrsenter {

    ClassifyView view;

    HomePresenterImpl(this.view) {
        view.setPresenter(this);
    }

    @override
    void start() {
        view.setTabList(Const.classification.subCategory);
    }
}