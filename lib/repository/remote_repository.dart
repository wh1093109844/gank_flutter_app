import 'dart:async';

import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/entry/gank.dart';

abstract class GankRepository {

	/// 请求分类数据
	///
	/// [type] 请求的数据类型，
	/// [pageSize] 每页加载的数量，
	/// [pageNum] 请求的第几页的数据
	Future<List<Gank>> fetch(String type, int pageSize, int pageNum);
	Future<Daily> fetchDataByDate(int year, int month, int day);
}
