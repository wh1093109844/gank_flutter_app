import 'dart:async';

import 'package:gank_flutter_app/entry/gank.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
enum Action {
  FAVORITE,
  UNFAVORITE,
}

const String favoritesKey = 'FAVORITES';

class ReduxStoreState {
  List<Gank> favorites;

  ReduxStoreState({this.favorites});

}

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<List<Gank>> getFavorites() async {
  SharedPreferences prefs = await _prefs;
  String result = prefs.getString(favoritesKey);
  if (result == null || result == '') {
    return <Gank>[];
  }
  List mapList = json.decode(result);
  List<Gank> list = mapList.map((str) => json.decode(str)).map((json) => Gank.fromJson(json)).toList();
  return list;
}

void saveFavorites(List<Gank> gankList) {
  _prefs.then((SharedPreferences prefs) {
    prefs.setString(favoritesKey, json.encode(gankList, toEncodable: (gank) => gank.toString()));
  });
}

bool isFavorited(Gank gank, List<Gank> list) {
  bool isFavorted = false;
  if (gank == null || list == null || list.isEmpty) {
    return isFavorted;
  }
  for (Gank favorite in list) {
    if (favorite.id == gank.id) {
      isFavorted = true;
      break;
    }
  }
  return isFavorted;
}

List<Gank> favorite(Gank gank, List<Gank> list) {
  if (!isFavorited(gank, list)) {
    if (list == null) {
      list = [];
    }
    list.add(gank);
  }
  saveFavorites(list);
  return list;
}

List<Gank> unFavorite(Gank gank, List<Gank> list) {
  if (!isFavorited(gank, list)) {
    return list;
  }
  for (Gank item in list) {
    if (item.id == gank.id) {
      list.remove(item);
      break;
    }
  }
  saveFavorites(list);
  return list;
}

List<Gank> favoriteGank(List<Gank> gankList, FavoriteGankAction action) {

  return favorite(action.gank, gankList);
}

List<Gank> unFavoriteGank(List<Gank> gankList, UnFavoriteGankAction action) {
  return unFavorite(action.gank, gankList);
}

List<Gank> initFavorites(List<Gank> list, InitFavoritesAction action) {
  if (list == null) {
    list = [];
  }
  List<Gank> gankList = action.list;
  if (gankList == null) {
    gankList = [];
  }
  list.addAll(gankList);
  return list;
}

class FavoriteGankAction {
  final Gank gank;
  FavoriteGankAction(this.gank);
}

class UnFavoriteGankAction {
  final Gank gank;
  UnFavoriteGankAction(this.gank);
}

class InitFavoritesAction {
  final List<Gank> list;
  InitFavoritesAction(this.list);
}

final FavoriteRedux = combineReducers<List<Gank>>([
  TypedReducer<List<Gank>, FavoriteGankAction>(favoriteGank),
  TypedReducer<List<Gank>, UnFavoriteGankAction>(unFavoriteGank),
  TypedReducer<List<Gank>, InitFavoritesAction>(initFavorites),
]);

ReduxStoreState storeStateRedux(ReduxStoreState state, action) {
  return ReduxStoreState(favorites: FavoriteRedux(state.favorites, action));
}
