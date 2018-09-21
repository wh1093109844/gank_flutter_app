import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/entry/daily.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/entry/gank_response.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/repository/remote_repository.dart';

class GankRepositoryImpl extends GankRepository {

  static const String host = "http://gank.io/api/";

  @override
  Future<List<Gank>> fetch(String type, int pageSize, int pageNum) async {
    String url = "$host/data/$type/$pageSize/$pageNum";
    var response = await send(url);
    List<Gank> list = [];
    var temp = (response.results as List).map((gank) => Gank.fromJson(gank));
    list.addAll(temp);
    return list;
  }

  Future<GankResponse> send(String url) async {
    HttpClient client = new HttpClient();
    print(url);
    Uri uri = Uri.parse(url);
    var request = await client.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print(responseBody);
    var result = json.decode(responseBody);
    return new GankResponse.fromJson(result);
  }

  @override
  Future<Daily> fetchDataByDate(int year, int month, int day) async {
      String url = _isToday(year, month, day) ? '$host/today' :'$host/day/$year/$month/$day';
      var response = await send(url);
      List bannerListMap = response.results[Const.typeWelfare];
      List<Gank> banner = [];
      if (bannerListMap != null) {
          banner = (response.results[Const.typeWelfare] as List).map((gank) =>
              Gank.fromJson(gank)).toList();
      }
      print(banner);
      List<Gank> list = [];
      response.results.forEach((key, value) {
          print('key = $key\tvalue=$value');
          if (key != Const.typeWelfare) {
              var temp = (value as List).map((json) => Gank.fromJson(json)).toList();
              list.addAll(temp);
          }
      });
      Daily daily = Daily(banner, list);
      return daily;
  }

  bool _isToday(int year, int month, int day) {
      DateTime dateTime = DateTime(year, month, day);
      DateTime today = DateTime.now();
      return dateTime.year == today.year && dateTime.month == today.month && dateTime.day == today.day;
  }

  @override
  Future<List<XianduChildType>> fetchXianduChildType(String parent) async {
    String url = '$host/xiandu/category/$parent';
    var response = await send(url);
    List jsonMapList = response.results as List;
    List<XianduChildType> list = null;
    if (jsonMapList != null) {
      list = jsonMapList.map((json) => XianduChildType.fromJson(json)).toList();
    }
    return list;
  }

  @override
  Future<List<Xiandu>> fetchXianduList(String id, int pageSize, int pageNum) async {
    String url = '$host/xiandu/data/id/$id/count/$pageSize/page/$pageNum';
    var response = await send(url);
    List jsonMapList = response.results as List;
    List<Xiandu> list = null;
    if (jsonMapList != null) {
      list = jsonMapList.map((json) => Xiandu.formJson(json)).toList();
    }
    return list;
  }

  @override
  Future<List<XianduMainType>> fetchXianduMainType() async {
    String url = '$host/xiandu/categories';
    var response = await send(url);
    List jsonMapList = response.results as List;
    List<XianduMainType> list = null;
    if (jsonMapList != null) {
      list = jsonMapList.map((json) => XianduMainType.fromJson(json)).toList();
    }
    return list;
  }
}
