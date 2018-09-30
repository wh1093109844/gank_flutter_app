import 'package:flutter/material.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/presenter/classify_list_presenter_impl.dart';

abstract class AbsListPage extends StatefulWidget {

  String type;

  AbsListPage(this.type);

  @override
  State<StatefulWidget> createState() {
    var state = createListPageState();
//    new ClassifyListPresenterImpl(state, type);
    return state;
  }

  AbsListPageState createListPageState();
}

abstract class AbsListPageState<T extends AbsListPage> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  bool showProgressBar;
  ScrollController scrollController;

  Widget buildBody(BuildContext context, List<Gank> gankList);

  @override
  void initState() {
    super.initState();
//    presenter.start();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
//        presenter.fetch();
        ClassifyProvider.of(context).loadGankList.add(widget.type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Gank>>(
      stream: ClassifyProvider.of(context).gankStream(widget.type),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          ClassifyProvider.of(context).loadGankList.add(widget.type);
          return Center(child: Stack(
            children: <Widget>[
              Text('empty'),
              CircularProgressIndicator(),
            ],
          ));
        } else if (snapshot.connectionState == ConnectionState.active && snapshot.error != null) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(snapshot.error)));
          return Center(
            child: Text('empty'),
          );
        } else if (snapshot.connectionState == ConnectionState.active && snapshot.data != null){
          return buildBody(context, snapshot.data);
        } else {
          return Center(
            child: Text('empty'),
          );
        }
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
