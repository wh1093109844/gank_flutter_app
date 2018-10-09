import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/classify/classify_bloc.dart';
import 'package:gank_flutter_app/classify/classify_page.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/presenter/classify_list_presenter_impl.dart';

abstract class AbsListPage extends StatefulWidget {

  String type;

  AbsListPage(this.type);

  @override
  State<StatefulWidget> createState() {
    var state = createListPageState();
    return state;
  }

  AbsListPageState createListPageState();
}

abstract class AbsListPageState<T extends AbsListPage> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  bool showProgressBar;
  ScrollController scrollController;
  ClassifyPage _page;

  Widget buildBody(BuildContext context, ClassifyPage page);

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    ClassifyBloc bloc = BlocProvider.of<ClassifyBloc>(context);
    return StreamBuilder<ClassifyPage>(
      stream: bloc.outGankStream(widget.type),
      builder: (context, snapshot) {
        var list = <Widget>[];
        if (snapshot.connectionState == ConnectionState.waiting) {
          list.add(Center(child: Stack(
            children: <Widget>[
              Text('empty'),
            ],
          )));
        } else if (snapshot.connectionState == ConnectionState.active && snapshot.error != null) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(snapshot.error)));
          list.add(Center(
            child: Text('empty'),
          ));
        } else if (snapshot.connectionState == ConnectionState.active && snapshot.data != null){
          _page = snapshot.data;
          initScrollController();
          list.add(buildBody(context, snapshot.data));
        } else {
          list.add(Center(
            child: Text('empty'),
          ));
        }
        list.add(StreamBuilder(
          initialData: false,
          stream: bloc.outShouldShowProgress(widget.type),
          builder: (context, snapshot) {
            if (snapshot.data) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SizedBox(width: 0.0, height: 0.0,);
          }}));
        return Stack(
            children: list,
            );
      },
    );
  }

  void initScrollController() {
    ClassifyBloc bloc = BlocProvider.of<ClassifyBloc>(context);
    scrollController = new ScrollController(initialScrollOffset: _page == null || _page.scrollY == null ? 0.0 : _page.scrollY);
    scrollController.addListener(() {
      bloc.inScrolledChanged(widget.type).add(scrollController.position.pixels);
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bloc.inLoadGankList(widget.type).add(_page?.pageNum + 1);
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
