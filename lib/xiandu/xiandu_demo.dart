import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/xiandu_presenter_impl.dart';
import 'package:gank_flutter_app/xiandu/xiandu_bloc.dart';
import 'package:gank_flutter_app/xiandu/xiandu_detail.dart';
import 'dart:convert';

import 'package:gank_flutter_app/xiandu/xiandu_detail_bloc.dart';

class XianduDemo extends StatefulWidget {

  XianduDemo({Key key}): super(key: key);

  @override
  XianduDemoState createState() {
    XianduDemoState state = XianduDemoState();
//    XianduPresenterImpl(state);
    return state;
  }
}

class XianduDemoState extends State<XianduDemo> with AutomaticKeepAliveClientMixin<XianduDemo> {

  ScrollController _controller;
  bool shouldHandleBackEvent = false;

  @override
  Widget build(BuildContext context) {
    XianduBloc bloc = BlocProvider.of<XianduBloc>(context);
    return WillPopScope(
      key: ObjectKey('xiandu'),
      onWillPop: handlePopScope,
      child: StreamBuilder<TypeWrapper>(
        stream: bloc.outCurrent,
        builder: (context, snapshot) {
          return new Scaffold(
            appBar: buildAppBar(snapshot.data),
            body: Container(
              child: Stack(
                children: <Widget>[
                  StreamBuilder<List>(
                    stream: bloc.outList,
                    builder: (context, snapshot) {
                      if (snapshot.data?.isEmpty ?? true) {
                        return Text('empty');
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) => buildItem(snapshot.data[index]),
                        itemCount: snapshot.data?.length ?? 0,
                        controller: _controller,
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: bloc.outShouldShowProgress,
                    initialData: false,
                    builder: (context, snapshot) {
                      if (snapshot.data) {
                        return Center(child: CircularProgressIndicator(),);
                      } else {
                        return SizedBox(width: 0.0, height: 0.0,);
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> handlePopScope() async {
    if (shouldHandleBackEvent) {
      BlocProvider
        .of<XianduBloc>(context)
        .inPop
        .add(null);
      return false;
    }
    return true;
  }

  AppBar buildAppBar(TypeWrapper wrapper) {
    if (wrapper == null) {
      return null;
    }
    shouldHandleBackEvent = true;
    if (wrapper.mainType == null) {
      shouldHandleBackEvent = false;
      return AppBar(
        title: Text('闲读'),
      );
    } else if (wrapper.childType == null){
      return AppBar(
        title: Text(wrapper.mainType.name ?? ''),
        leading: _leading(),
      );
    } else {
      return AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(wrapper.childType.title ?? ''),
            Text(wrapper.mainType.name ?? '', style: TextStyle(fontSize: 10.0),)
          ],
        ),
        leading: _leading(),
      );
    }
  }

  Widget _leading() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white,),
      onPressed: () => handlePopScope(),
    );
  }

  Widget buildItem(type) {
    if (type is XianduMainType) {
      return buildMainTypeItem(type);
    } else if (type is XianduChildType) {
      return buildChildTypeItem(type);
    } else if (type is Xiandu) {
      return buildXianduItem(type);
    } else {
      return SizedBox();
    }
  }

  Widget buildMainTypeItem(XianduMainType type) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(type.name),
          onTap: () {
            BlocProvider.of<XianduBloc>(context).inLoadChild.add(type);
          }
        ),
        Divider(height: 1.0,)
      ],
    );
  }

  Widget buildChildTypeItem(XianduChildType type) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(type.title),
          leading: Image.network(type.icon, height: 60.0, width: 60.0,),
          subtitle: Text(type.id),
          onTap: () {
            BlocProvider.of<XianduBloc>(context).inLoadChild.add(type);
          },
        ),
        Divider(height: 1.0,)
      ],
    );
  }

  Widget buildXianduItem(Xiandu xiandu) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(xiandu.title),
          subtitle: Text(xiandu.site.name),
          contentPadding: EdgeInsets.all(5.0),
          trailing: (xiandu.cover == null || xiandu.cover == '' || xiandu.cover == 'none') ? null : Image.network(xiandu.cover, height: 60.0, width: 100.0,),
          isThreeLine: true,
          onTap: () {
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) =>
                BlocProvider<XianduDetailBloc>(
                  bloc: XianduDetailBloc(xiandu: xiandu),
                  child: XianduDetail(),
                )));
          },
        ),
        Divider(height: 1.0,)
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(handleScroll);
//    presenter.start();
  }

  void handleScroll() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      BlocProvider.of<XianduBloc>(context).inLoadList.add(0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(XianduDemo oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
