import 'package:gank_flutter_app/entry/gank.dart';
import 'package:redux/redux.dart';
enum Action {
  FAVORITE,
  UNFAVORITE,
}

class ReduxStoreState {
  List<Gank> favorites;

  ReduxStoreState({this.favorites});

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
  return list;
}

List<Gank> favoriteGank(List<Gank> gankList, FavoriteGankAction action) {
  return favorite(action.gank, gankList);
}

List<Gank> unFavoriteGank(List<Gank> gankList, UnFavoriteGankAction action) {
  return unFavorite(action.gank, gankList);
}

class FavoriteGankAction {
  final Gank gank;
  FavoriteGankAction(this.gank);
}

class UnFavoriteGankAction {
  final Gank gank;
  UnFavoriteGankAction(this.gank);
}

final FavoriteRedux = combineReducers<List<Gank>>([
  TypedReducer<List<Gank>, FavoriteGankAction>(favoriteGank),
  TypedReducer<List<Gank>, UnFavoriteGankAction>(unFavoriteGank),
]);

ReduxStoreState storeStateRedux(ReduxStoreState state, action) {
  return ReduxStoreState(favorites: FavoriteRedux(state.favorites, action));
}
