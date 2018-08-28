import 'dart:async';
import 'dart:io';
import 'dart:convert';
import '../entry/gank.dart';

import 'remote_repository.dart';
import '../entry/gank_response.dart';

class GankRepositoryImpl extends GankRepository {

  static const String host = "http://gank.io/api/data/";

  @override
  Future<List<Gank>> fetch(String type, int pageSize, int pageNum) async {
    String url = "$host/$type/$pageSize/$pageNum";
    var response = await _send(url);
    var list = response.results.map((gank) => Gank.fromJson(gank)).toList();
    return list;
  }

  Future<GankResponse> _send(String url) async {
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
}
