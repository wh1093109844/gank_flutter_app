import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter_app/presenter/xiandu_detail_presenter_impl.dart';

class XianduDetail extends StatefulWidget {

  Xiandu xiandu;

  XianduDetail(@required this.xiandu);

  @override
  XianduDetailState createState() {
    XianduDetailState state = new XianduDetailState();
    XianduDetailPresenterImpl(state, xiandu);
    return state;
  }
}

class XianduDetailState extends State<XianduDetail> implements XianduDetailView{
  String url = '';
  bool isShow = false;
  FlutterWebviewPlugin _webviewPlugin;
  Rect _rect = null;
  ScrollController _controller;
  Timer timer;
  double scrolledY = 0.0;
  Stream<double> _onScrollYChanged;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (_rect == null) {
      if (url != null && url != '') {
        _rect = _buildRect(context);
        _webviewPlugin.launch(
          url,
          rect: _rect,
          withJavascript: true,
          withLocalStorage: true,
          withLocalUrl: true,
        );
      }
    } else {
      _rect = _buildRect(context);
      if (_rect != null) {
        _webviewPlugin.resize(_rect);
      }
      timer?.cancel();
      timer = Timer(Duration(milliseconds: 300), () {
        _webviewPlugin.resize(_rect);
      });
    }
    if (isShow) {
      list.add(Center(child: CircularProgressIndicator(),));
    }

    return new Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              child: SliverAppBar(
                primary: true,
                floating: false,
                elevation: 5.0,
                forceElevated: true,
                expandedHeight: 300.0,
                automaticallyImplyLeading: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: PhotoHolder(widget.xiandu.cover ?? '', fit: BoxFit.cover),
                  title: Text(widget.xiandu.title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,),
                ),
              ),
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: Stack(
            children: list,
          ),
//          child: Builder(
//            builder: (context) {
//              return CustomScrollView(
//                slivers: [
//                  SliverOverlapInjector(
//                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                  ),
//                  SliverList(
//                    delegate: SliverChildListDelegate(
//                      <Widget>[
//                        HtmlTextView(data: widget.xiandu.content),
//                      ],
//                    ),
//                  ),
//                ]
//              );
//            },
//          ),
        ),
        controller: _controller,
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webviewPlugin = FlutterWebviewPlugin();
    _controller = ScrollController();
    _controller.addListener(handlerScroller);
    _onScrollYChanged = _webviewPlugin.onScrollYChanged;
    _webviewPlugin.close();
    presenter.start();
    _onScrollYChanged.listen(handleScrollYChanged);
  }

  void handlerScroller() {
    print(_controller.position.pixels);
    setState(() {
      scrolledY = _controller.position.pixels;
    });
  }

  void handleScrollYChanged(double y) {
    print('scrollY\t$y');
  }

  Rect _buildRect(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final top = 300.0 - scrolledY + mediaQuery.padding.top;

    var height = mediaQuery.size.height - top;

    if (height < 0.0) {
      height = 0.0;
    }

    return new Rect.fromLTWH(0.0, top, mediaQuery.size.width, height);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    _webviewPlugin.close();
    _webviewPlugin.dispose();
    _controller.removeListener(handlerScroller);
    _controller.dispose();
  }

  @override
  void didUpdateWidget(XianduDetail oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  XianduDetailPresenter presenter;

  @override
  void setPresenter(XianduDetailPresenter presenter) {
    this.presenter = presenter;
  }

  @override
  void setUrl(String url) {
    print(url);
    if (mounted) {
      setState(() {
        this.url = url;
      });
    } else {
      this.url = url;
    }
  }

  @override
  void showDialog(bool isShow) {
    if (mounted) {
      setState(() {
        this.isShow = isShow;
      });
    } else {
      this.isShow = isShow;
    }
  }

  @override
  void showMessage(String message) {
    // TODO: implement showMessage
  }
}
