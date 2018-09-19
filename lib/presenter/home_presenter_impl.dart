import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class HomePresenterImpl extends HomePresenter {

    HomeView view;
    GankRepository remoteRepository;

    HomePresenterImpl(this.view) {
        remoteRepository = GankRepositoryImpl();
        view.setPresenter(this);
    }

    @override
    void fetch(int year, int month, int day) {
        view.showDialog(true);
        remoteRepository.fetchDataByDate(year, month, day)
            .then((daily) {
                view.setBannerList(daily.bannerList);
                view.setDataList(daily.dataList);
                view.showDialog(false);
        }, onError: (error) {
                print(error);
                view.showDialog(false);
        });
    }

    @override
    void start() {
        DateTime today = DateTime.now();
        fetch(today.year, today.month, today.day);
    }
}
