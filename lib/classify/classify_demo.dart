import 'package:flutter/material.dart';
import 'package:gank_flutter_app/const.dart' as Const;
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/default_list_page.dart';
import 'package:gank_flutter_app/pages/image_list_page.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/classify_presenter_impl.dart';

class ClassifyDemo extends StatefulWidget {

  Const.Category category;

  ClassifyDemo({@required this.category});

  @override
  _ClassifyDemoState createState() {
    var state = _ClassifyDemoState();
    new ClassifyPresenterImpl(state);
    return state;
  }
}

class _ClassifyDemoState extends State<ClassifyDemo> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<ClassifyDemo> implements ClassifyView {

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: typeList?.length ?? 0, vsync: this);
  }

  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabWidgets = typeList?.map((tab) => new Container(child: new Center(child: new Text(tab.code)), height: 48.0,)).toList() ?? [];
    List<Widget> viewPages = typeList?.map((tab){
      if (tab == Const.Const.welfare) {
        return new ImageListPage(tab.code, onTapCallback: handleTap,);
      } else {
        return new DefaultListPage(tab.code, onTapCallback: handleTap,);
      }
    }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.category.name),
        bottom: new TabBar(tabs: tabWidgets, controller: _tabController, isScrollable: true, ),
      ),
      body: new TabBarView(children: viewPages, controller: _tabController,), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void handleTap(Gank gank) {
    if (gank == null) {
      return;
    }
    MaterialPageRoute route = null;
    if (gank.type == Const.Const.typeWelfare) {
      route = new MaterialPageRoute(builder: (context) => new ImagePage(gank));
    } else {
      route = new MaterialPageRoute(builder: (context) => new WebviewPage(gank));
    }
    Navigator.of(context).push(route);
  }

  @override
  ClassifyPrsenter presenter;
  List<Const.Category> typeList;

  @override
  void setPresenter(ClassifyPrsenter presenter) {
    this.presenter = presenter;
    presenter.start();
  }

  @override
  void setTabList(List<Const.Category> list) {
    this.typeList = list;
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
