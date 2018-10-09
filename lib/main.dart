import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/classify/classify_demo.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/const.dart' as Const;
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/home/daily_bloc.dart';
import 'package:gank_flutter_app/home/daily_service.dart';
import 'package:gank_flutter_app/home/home_demo.dart';
import 'package:gank_flutter_app/other/other_demo.dart';
import 'package:gank_flutter_app/reduxes.dart';
import 'package:gank_flutter_app/xiandu/xiandu_demo.dart';
import 'package:redux/redux.dart';

void main() {
  final ClassifyService service = ClassifyService();
  final DailyService dailyService = DailyService();
  final ClassifyBloc bloc = ClassifyBloc(service);
  final DailyBloC dailyBloC = DailyBloC(service: dailyService);
  final store = Store<ReduxStoreState>(storeStateRedux, initialState: ReduxStoreState(favorites: []));
  debugInstrumentationEnabled = true;
  runApp(new MyApp(store: store, classifyBloc: bloc, dailyBloC: dailyBloC));
}

class MyApp extends StatefulWidget {

  Store<ReduxStoreState> store;
  ClassifyBloc classifyBloc;
  DailyBloC dailyBloC;

  MyApp({this.store, this.classifyBloc, this.dailyBloC});

  // This widget is the root of your application.
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReduxStoreState>(
      store: widget.store,
      child: BlocProvider<ClassifyBloc>(
        bloc: widget.classifyBloc,
        child: new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(primarySwatch: Colors.blue,),
          home: new MainPage(dailyBloc: widget.dailyBloC, classifyBloc: widget.classifyBloc,),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.classifyBloc.dispose();
    widget.dailyBloC.dispose();
    super.dispose();
  }
}

class MainPage extends StatefulWidget {
  DailyBloC dailyBloc;
  ClassifyBloc classifyBloc;

  MainPage({Key key, @required this.dailyBloc, @required this.classifyBloc}): super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class MainContentView {
  Widget content;

  AnimationController controller;
  Animation<double> _animation;

  MainContentView({@required this.content, TickerProvider vsync}) :
    controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: vsync) {
    _animation = CurvedAnimation(parent: controller, curve: Curves.linear);
  }


  FadeTransition transition() {
    return FadeTransition(
      opacity: _animation,
      child: content,
    );
  }
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin{

  int current = 0;
  List<MainContentView> widgets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavorites().then((List<Gank> list) {
      StoreProvider.of<ReduxStoreState>(context).dispatch(InitFavoritesAction(list));
    });
    widgets = [
      MainContentView(
        content: new HomeDemo(key: ObjectKey('home'),),
        vsync: this,
      ),
      MainContentView(
        content: new ClassifyDemo(category: Const.Const.classification, key: ObjectKey('class'),),
        vsync: this,
        ),
      MainContentView(
        content: new XianduDemo(key: ObjectKey('xiandu'),),
        vsync: this,
        ),
      MainContentView(
        content: new OtherDemo(key: ObjectKey('other'),),
        vsync: this,
        ),
    ];
    for(MainContentView view in widgets) {
      view.controller.addListener(_build);
    }
    widgets[current].controller.value = 1.0;
  }

  @override
  void dispose() {
    widgets.forEach((view) => view.controller.dispose());
    super.dispose();
  }

  void _build() {
    setState(() {

    });
  }

  Widget _buildContent() {
//    List<FadeTransition> list = widgets.map((view) => view.transition()).where((transition) => transition.opacity.value != 0).toList();
//    list.sort((FadeTransition a, FadeTransition b) {
//      final Animation<double> aAnimation = a.opacity;
//      final Animation<double> bAnimation = b.opacity;
//      final double aValue = aAnimation.value;
//      final double bValue = bAnimation.value;
//      return aValue.compareTo(bValue);
//    });
//    print(list);
//    return Stack(children: list,);
    return widgets[current].content;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyBloC>(
      bloc: widget.dailyBloc,
      child: Scaffold(
          body: _buildContent(),
          bottomNavigationBar: BottomNavigationBar(
            items: generBottomNavigationBarItems(),
            onTap: handleBottomTap,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
          ),),
    );
  }

  void handleBottomTap(int index) {
    setState(() {
//      widgets[current].controller.reverse();
      current = index;
//      widgets[current].controller.forward();
    });
  }

  List<BottomNavigationBarItem> generBottomNavigationBarItems() {
    ThemeData theme = Theme.of(context);
    Color selectColor = theme.textSelectionColor;
    Color unselectColor = Colors.black38;
    List<BottomNavigationBarItem> bottomNavigationBarItems = [
      new BottomNavigationBarItem(
          icon: new Icon(Icons.home, color: current == 0 ? selectColor : unselectColor),
          title: new Text('首页', style: new TextStyle(color: current == 0 ? selectColor : unselectColor),)
          ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.burst_mode, color: current == 1 ? selectColor : unselectColor),
          title: new Text('分类数据', style: new TextStyle(color: current == 1 ? selectColor : unselectColor),)
          ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.compare, color: current == 2 ? selectColor : unselectColor),
          title: new Text('闲读', style: new TextStyle(color: current == 2 ? selectColor : unselectColor),)
          ),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.all_inclusive, color: current == 3 ? selectColor : unselectColor),
          title: new Text('其他', style: new TextStyle(color: current == 3 ? selectColor : unselectColor),)
          )
    ];
    return bottomNavigationBarItems;
  }
}
