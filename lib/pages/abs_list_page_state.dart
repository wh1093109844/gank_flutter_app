import 'package:flutter/material.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/presenter/classify_list_presenter_impl.dart';

abstract class AbsListPage extends StatefulWidget {

  String type;

  AbsListPage(this.type);

  @override
  State<StatefulWidget> createState() {
    var state = createListPageState();
    new ClassifyListPresenterImpl(state, type);
    return state;
  }

  AbsListPageState createListPageState();
}

abstract class AbsListPageState<T extends AbsListPage> extends State<T> with AutomaticKeepAliveClientMixin<T> implements ClassifyListView {
  bool showProgressBar;
  List<Gank> gankList = [];
  ScrollController scrollController;

  Widget buildBody(BuildContext context);

  @override
  void initState() {
    super.initState();
    presenter.start();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        presenter.fetch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (gankList.isEmpty) {
      body = new Center(child: new Text('empty'));
    } else {
      body = buildBody(context);
    }
    List<Widget> list = [body];
    if (showProgressBar) {
      list.add(new Center(child: new CircularProgressIndicator(),));
    }
    return new Container(
      child: new Stack(
        children: list,
      ),
    );
  }

  @override
  ClassifyListPresenter presenter;

  @override
  void setGankList(List<Gank> gankList) {
    setState(() {
      this.gankList.addAll(gankList);
    });
  }

  @override
  void setPresenter(ClassifyListPresenter presenter) {
    this.presenter = presenter;
  }

  @override
  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void showDialog(bool isShow) {
    if (!mounted) {
      showProgressBar = isShow;
    } else {
      setState((){
        showProgressBar = isShow;
      });
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
