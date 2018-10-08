import 'dart:async';

import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/home/daily_service.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class DailyBloC extends BlocBase {
  var _dateSubject = PublishSubject<DateTime>();
  var _dailySubject = BehaviorSubject<DailyWrapper>(seedValue: DailyWrapper(date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
  var _shouldShowProgress = BehaviorSubject<bool>(seedValue: false);
  var _scrollYChangedSubject = PublishSubject<double>();
  var _listeners = <StreamSubscription>[];
  var _scrollY = 0.0;

  Sink<DateTime> get inDate => _dateSubject.sink;
  Stream<DateTime> get _outDate => _dateSubject.stream;
  Stream<DailyWrapper> get outDaily => _dailySubject.stream;
  Sink<DailyWrapper> get _inDaily => _dailySubject.sink;
  Stream<bool> get outShouldShowProgress => _shouldShowProgress.stream;
  Sink<bool> get _inShouldShowProgress => _shouldShowProgress.sink;
  Sink<double> get inScrollChanged => _scrollYChangedSubject.sink;
  Stream<double> get _outScrollChanged => _scrollYChangedSubject.stream;

  final dateFormat = DateFormat('yyyy-MM-dd');

  final DailyService _service;
  DailyBloC({DailyService service}):
      assert(service != null),
      _service = service {
    _listeners.add(_outDate.listen(_handleDateChanged));
    _listeners.add(_outScrollChanged.listen((scroll) => this._scrollY = scroll));
    _handleDateChanged(DateTime.now());
  }

  void _handleDateChanged(DateTime dateTime) async {
    _inShouldShowProgress.add(true);
    Daily daily = await _service.requestDaily(dateTime.year, dateTime.month, dateTime.day);
    _inDaily.add(DailyWrapper(date: dateFormat.format(dateTime), daily: daily, scrollY: _scrollY));
    _inShouldShowProgress.add(false);
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
