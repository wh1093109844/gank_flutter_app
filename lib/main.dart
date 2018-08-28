import 'package:flutter/material.dart';
import 'contrack.dart';
import 'presenter/home_presenter_impl.dart';
import 'presenter/main_presenter_impl.dart';
import 'entry/gank.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() {
    _MyHomePageState pageState = new _MyHomePageState();
    new HomePresenterImpl(pageState);
    return pageState;
  }
}
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin implements HomeView {
  int _counter = 0;
  
  TabController _tabController;
  PageController _pageController;
  
  @override
  void initState() {
      _tabController = new TabController(length: typeList?.length ?? 0, vsync: this);
      _pageController = new PageController();
  }

  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    List<Widget> tabWidgets = typeList?.map((tab) => new Container(child: new Center(child: new Text(tab)), height: 48.0,)).toList() ?? [];
    List<Widget> viewPages = typeList?.map((tab) => new ListPage(tab)).toList();
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        bottom: new TabBar(tabs: tabWidgets, controller: _tabController, isScrollable: true, ),
      ),
      body: new TabBarView(children: viewPages, controller: _tabController,),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      drawer: new Drawer(child: new ListView(children: <Widget>[
        new Text('今日干货')
      ],)),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  HomePrsenter presenter;
  List<String> typeList;

  @override
  void setPresenter(HomePrsenter presenter) {
    this.presenter = presenter;
    presenter.start();
  }

  @override
  void setTabList(List<String> list) {
      this.typeList = list;
  }
}

class ListPage extends StatefulWidget {
  String type;
  ListPage(this.type);
  @override
  State<StatefulWidget> createState() {
    _ListPageState state = new _ListPageState();
    new MainPresenterImpl(state, type);
    return state;
  }
}

class _ListPageState extends State<ListPage> implements MainView {

  bool showProgressBar;
  List<Gank> gankList = [];
  BuildContext context;

  @override
  MainPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter.start();
  }

  @override
  Widget build(BuildContext context) {
      Widget body;
      if (gankList.isEmpty) {
          body = new Text('empty');
      } else {
          body = new ListView.builder(itemBuilder: (context, index) {
              return new Card(child: new Text(gankList[index].who),);
          }, itemCount: gankList.length,);
      }
    return new Container(
      child: body,
    );
  }

  @override
  void setGankList(List<Gank> gankList) {
    setState(() {
      this.gankList.addAll(gankList);
    });
  }

  @override
  void setPresenter(MainPresenter presenter) {
    this.presenter = presenter;
  }

  @override
  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void showProgress(bool isShow) {
    if (!mounted) {
      showProgressBar = isShow;
    } else {
      setState((){
        showProgressBar = isShow;
      });
    }
  }

}
