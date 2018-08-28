import 'package:flutter/material.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'contrack.dart';
import 'presenter/home_presenter_impl.dart';
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
  
  @override
  void initState() {
      _tabController = new TabController(length: typeList?.length ?? 0, vsync: this);
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
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        bottom: new TabBar(tabs: tabWidgets, controller: _tabController, isScrollable: true, ),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
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
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  }
}

class _ListPageState extends State<ListPage> implements MainView {

  bool showProgressBar;
  List<Gank> gankList = [];
  BuildContext context;

  @override
  MainPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(itemBuilder: (context, index) {
        return new Card(child: new Text(gankList[index].who),);
      }),
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
