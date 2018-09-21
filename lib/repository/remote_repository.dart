import 'dart:async';

import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';

abstract class GankRepository {

	/// 请求分类数据
	///
	/// [type] 请求的数据类型，
	/// [pageSize] 每页加载的数量，
	/// [pageNum] 请求的第几页的数据
	Future<List<Gank>> fetch(String type, int pageSize, int pageNum);
	Future<Daily> fetchDataByDate(int year, int month, int day);
	Future<List<XianduMainType>> fetchXianduMainType();
	Future<List<XianduChildType>> fetchXianduChildType(String parent);
	Future<List<Xiandu>> fetchXianduList(String id, int pageSize, int pageNum);
}
