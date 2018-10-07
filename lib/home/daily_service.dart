import 'dart:async';

import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/repository/remote_repository_impl.dart';

class DailyService {
  var _respository = GankRepositoryImpl();
  var _dailyMap = <String, Daily>{};

  Future<Daily> requestDaily(int year, int month, int day) async {
    var key = _buildKey(year, month, day);
    Daily daily = null;
    if (_dailyMap.containsKey(key)) {
      daily = _dailyMap[key];
    } else {
      daily = await _respository.fetchDataByDate(year, month, day);
    }
    return daily;
  }

  String _buildKey(int year, int month, int day) {
    return '$year-$month-$day';
  }
}
