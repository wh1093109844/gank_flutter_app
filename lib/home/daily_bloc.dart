import 'dart:async';

import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/home/daily_service.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class DailyBloC {
  var _dateSubject = PublishSubject<DateTime>();
  var _dailySubject = PublishSubject<DailyWrapper>();
  var _shouldShowProgress = PublishSubject<bool>();
  var _scrollYChangedSubject = PublishSubject<double>();
  var _listeners = <StreamSubscription>[];
  var _scrollY = 0.0;

  Sink<DateTime> get date => _dateSubject.sink;
  Stream<DailyWrapper> get daily => _dailySubject.stream;
  Stream<bool> get shouldShowProgress => _shouldShowProgress.stream;
  Sink<double> get scrollChanged => _scrollYChangedSubject.sink;

  var dateFormat = DateFormat('yyyy-MM-dd');

  final DailyService _service;
  DailyBloC({DailyService service}):
      assert(service != null),
      _service = service {
    _listeners.add(_dateSubject.stream.listen(_handleDateChanged));
    _listeners.add(_scrollYChangedSubject.stream.listen((scroll) => this._scrollY = scroll));
  }

  void _handleDateChanged(DateTime dateTime) async {
    _shouldShowProgress.sink.add(true);
    Daily daily = await _service.requestDaily(dateTime.year, dateTime.month, dateTime.day);
    _dailySubject.sink.add(DailyWrapper(date: dateFormat.format(dateTime), daily: daily, scrollY: _scrollY));
    _shouldShowProgress.sink.add(false);
  }

  void dispose() {
    _listeners.forEach((subscription) => subscription.cancel());
  }
}

class DailyWrapper {
  final String date;
  final Daily daily;
  final double scrollY;
  DailyWrapper({this.date, this.daily, this.scrollY = 0.0});
}
