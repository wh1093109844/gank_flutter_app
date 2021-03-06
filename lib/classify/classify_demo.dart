import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/classify/classify_service.dart';
import 'package:gank_flutter_app/const.dart' as Const;
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/default_list_page.dart';
import 'package:gank_flutter_app/pages/image_list_page.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/classify_presenter_impl.dart';

class ClassifyDemo extends StatefulWidget {

  Const.Category category;

  ClassifyDemo({@required this.category, Key key}): super(key: key);

  @override
  _ClassifyDemoState createState() {
    var state = _ClassifyDemoState();
    return state;
  }
}

class _ClassifyDemoState extends State<ClassifyDemo> with TickerProviderStateMixin<ClassifyDemo>, AutomaticKeepAliveClientMixin<ClassifyDemo> {

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 0, vsync: this);

  }

  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ClassifyBloc bloc = BlocProvider.of<ClassifyBloc>(context);
    return StreamBuilder(
        stream: bloc.outClassifys,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.data != null) {
            _tabController = new TabController(length: snapshot.data.categoryList.length, initialIndex: snapshot.data.index, vsync: this);
            _tabController.addListener(() {
              bloc.inClassifyChanged.add(_tabController.index);
            });
          }
          return new Scaffold(
            key: ObjectKey('clasify'),
            appBar: new AppBar(
              title: new Text(widget.category.name),
              bottom: snapshot.data == null || snapshot.data.categoryList.isEmpty ? null : new TabBar(tabs: buildTabItem(snapshot.data.categoryList), controller: _tabController, isScrollable: true, ),
              ),
            body: buildBody(snapshot), // This trailing comma makes auto-formatting nicer for build methods.
            );
        },
      );
  }

  List<Widget> buildTabItem(List<Category> data) {
    return data.map((tab) => new Container(child: new Center(child: new Text(tab.code)), height: 48.0,)).toList();
  }

  List<Widget> buildTabContent(List<Category> data) {
    List<Widget> viewPages = data?.map((tab){
      if (tab == Const.Const.welfare) {
        return new ImageListPage(tab.code, onTapCallback: handleTap,);
      } else {
        return new DefaultListPage(tab.code, onTapCallback: handleTap,);
      }
    }).toList();
    return viewPages;
  }

  Widget buildBody(snapshot) {
    if (snapshot.error != null) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(snapshot.error)));
      return Container(
        constraints: BoxConstraints.expand(),
      );
    } else if (snapshot.data == null || snapshot.data.categoryList.isEmpty) {
      return Center(child: CircularProgressIndicator(),);
    } else {
      return new TabBarView(children: buildTabContent(snapshot.data.categoryList), controller: _tabController,);
    }
  }

  void handleTap(Gank gank) {
    if (gank == null) {
      return;
    }
    BuildContext buildContext = context;
    buildContext.visitChildElements(visitor);
    MaterialPageRoute route = null;
    if (gank.type == Const.Const.typeWelfare) {
      route = new MaterialPageRoute(builder: (context) => new ImagePage(gank));
    } else {
      route = new MaterialPageRoute(builder: (context) => new WebviewPage(gank.desc, gank.url));
    }
    Navigator.of(context).push(route);
  }

  void visitor(Element element) {
    if (element.widget is Hero) {
      Hero hero = element.widget;
      print('hero = $hero\ttag = ${hero.tag}');
    } else {
      element.visitChildElements(visitor);
    }
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

}
