import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/home/daily_bloc.dart';

class GankProvider extends InheritedWidget {
  final DailyBloC dailyBloC;
  final ClassifyBloc classifyBloC;
  const GankProvider ({
    Key key,
    @required Widget child,
    this.dailyBloC,
    this.classifyBloC,
  })  : assert(child != null),
        super(key: key, child: child);

  static GankProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(GankProvider) as GankProvider;
  }

  @override
  bool updateShouldNotify(GankProvider old) {
    return true;
  }
}
