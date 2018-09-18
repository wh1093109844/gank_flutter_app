import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';

class ClassifyPresenterImpl extends ClassifyPrsenter {
  ClassifyView view;

  ClassifyPresenterImpl(this.view) {
    view.setPresenter(this);
  }

  @override
  void start() {
    view.setTabList(Const.classification.subCategory);
  }
}
