import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/entry/xiandu_child_type.dart';
import 'package:gank_flutter_app/entry/xiandu_main_type.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/xiandu_presenter_impl.dart';
import 'package:gank_flutter_app/xiandu/xiandu_detail.dart';
import 'dart:convert';

class XianduDemo extends StatefulWidget {

  XianduDemo({Key key}): super(key: key);

  @override
  XianduDemoState createState() {
    XianduDemoState state = XianduDemoState();
    XianduPresenterImpl(state);
    return state;
  }
}

class XianduDemoState extends State<XianduDemo> with AutomaticKeepAliveClientMixin<XianduDemo> implements XianduTypeView {

  bool _isShow = false;
  List<XianduMainType> _mainTypeList = [];
  List<XianduChildType> _childTypeList = [];
  List<Xiandu> _xianduList = [];
  XianduMainType mainType;
  XianduChildType childType;
  Xiandu xiandu;

  ScrollController _controller;

  @override
  XianduPresenter presenter;

  @override
  Widget build(BuildContext context) {
    List<Widget> stackWidgets = [buildListView()];
    if (_isShow) {
      stackWidgets.add(Center(child: CircularProgressIndicator()));
    }
    return WillPopScope(
      key: ObjectKey('xiandu'),
      onWillPop: handlePopScope,
      child: new Scaffold(
        appBar: buildAppBar(),
        body: Container(
          child: Stack(
            children: stackWidgets,
          ),
        ),
      ),
    );
  }

  Future<bool> handlePopScope() async {
    if (mainType == null) {
      return true;
    } else if (childType == null){

      setState(() {
        mainType = null;
      });
      return false;
    } else {
      setState(() {
        childType = null;
      });
    }
  }

  AppBar buildAppBar() {
    if (mainType == null) {
      return AppBar(
        title: Text('闲读'),
      );
    } else if (childType == null){
      return AppBar(
        title: Text(mainType.name ?? ''),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
          setState(() {
            _childTypeList = [];
            mainType = null;
          });
        }),
      );
    } else {
      return AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(childType.title ?? ''),
            Text(mainType.name ?? '', style: TextStyle(fontSize: 10.0),)
          ],
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {
          setState(() {
            childType = null;
            _xianduList = [];
          });
        }),
      );
    }
  }

  Widget buildListView() {
    return ListView(
      children: buildWidgetList(mainType == null ? _mainTypeList : childType == null ? _childTypeList : _xianduList),
      controller: _controller,
    );
  }

  List<Widget> buildWidgetList(List list) {
    List<Widget> widgetList = [];
    if (list == null || list.isEmpty) {
      return widgetList;
    }
    final int length = list.length;
    for (int i = 0; i < length; i++) {
      widgetList.add(buildItem(list[i]));
      if (i != length - 1) {
        widgetList.add(Divider(height: 1.0,));
      }
    }
    return widgetList;
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
    return ListTile(
      title: Text(type.name),
      onTap: () {
        mainType = type;
        _childTypeList = [];
        presenter.fetchChildTypeList(mainType.en_name);
      }
    );
  }

  Widget buildChildTypeItem(XianduChildType type) {
    return ListTile(
      title: Text(type.title),
      leading: Image.network(type.icon, height: 60.0, width: 60.0,),
      subtitle: Text(type.id),
      onTap: () {
        childType = type;
        presenter.fetchXianduList(type.id);
      },
    );
  }

  Widget buildXianduItem(Xiandu xiandu) {
    return ListTile(
      title: Text(xiandu.title),
      subtitle: Text(xiandu.site.name),
      contentPadding: EdgeInsets.all(5.0),
      trailing: (xiandu.cover == null || xiandu.cover == '' || xiandu.cover == 'none') ? null : Image.network(xiandu.cover, height: 60.0, width: 100.0,),
      isThreeLine: true,
      onTap: () {
//        Navigator.of(context).push(MaterialPageRoute(builder: (context) => XianduDetail(xiandu)));
        this.xiandu = xiandu;
        if (xiandu.content == null || xiandu.content == '') {
          setUrl(xiandu.url);
        } else {
          presenter.saveHtml(xiandu.content ?? '');
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(handleScroll);
    presenter.start();
  }

  void handleScroll() {
    if (childType != null && _controller.position.pixels == _controller.position.maxScrollExtent) {
      presenter.fetchXianduList(childType.id);
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

  @override
  void setMainTypeList(List<XianduMainType> list) {
    if (mounted) {
      setState(() {
        _mainTypeList = list;
      });
    } else {
      _mainTypeList = list;
    }
  }

  @override
  void setPresenter(XianduPresenter presenter) {
    this.presenter = presenter;
  }

  @override
  void showDialog(bool isShow) {
    if (mounted) {
      setState(() {
        _isShow = isShow;
      });
    }
  }

  @override
  void showMessage(String message) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void setChildTypeList(List<XianduChildType> list) {
    if (mounted) {
      setState(() {
        _childTypeList = list;
      });
    } else {
      _childTypeList = list;
    }
  }

  @override
  void setXianduList(List<Xiandu> list) {
    setState(() {
      _xianduList = list;
    });
  }

  @override
  void setUrl(String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewPage(xiandu.title, url)));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
