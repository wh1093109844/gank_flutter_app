import 'package:gank_flutter_app/entry/gank.dart';

class Daily {
	List<Gank> bannerList;
	List<Gank> dataList;

	Daily(this.bannerList, this.dataList);

	factory Daily.empty() => Daily([], []);

	void addData(List<Gank> list) {
		if (dataList == null) {
			dataList = [];
		}
		dataList.addAll(list);
	}

	void _comp
}