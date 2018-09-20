import 'package:gank_flutter_app/entry/gank.dart';

class Daily {
	List<Gank> bannerList;
	List<Gank> dataList;

	Daily(this.bannerList, this.dataList) {
	    _dataSort();
    }

	factory Daily.empty() => Daily([], []);

	void addData(List<Gank> list) {
		if (dataList == null) {
			dataList = [];
		}
		dataList.addAll(list);
		_dataSort();
	}

	void _dataSort() {
	    if (dataList == null) {
	        return;
        }
	    dataList.sort(_sort);
    }

    int _sort(Gank gank1, Gank gank2) {
	    return gank1.publishedAt.compareTo(gank2.publishedAt);
    }
}
