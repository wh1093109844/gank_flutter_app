import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/home/daily_bloc.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/widgets/page_view_indicator.dart';
import 'package:intl/intl.dart' as Intl;
import 'dart:math' as math;

class HomeDemo extends StatefulWidget {

  HomeDemo({Key key}): super(key: key);

  @override
  _HomeDemoState createState() {
    _HomeDemoState state = _HomeDemoState();
//    HomePresenterImpl(state);
    return state;
  }
}

class _HomeDemoState extends State<HomeDemo> with AutomaticKeepAliveClientMixin<HomeDemo>, SingleTickerProviderStateMixin<HomeDemo> {
  PageController _pageController;
  ScrollController _scrollController;
  DateTime time = DateTime.now();
  bool reverse = false;

  DailyWrapper _wrapper;

  @override
  HomePresenter presenter;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    var listViewChildren = _dataList.map((gank) => _buildItemWidget(gank)).toList();
//    var stackChildren = <Widget>[];
//    if (_showProgress) {
//      stackChildren.add(Center(child: CircularProgressIndicator()));
//    }
//    Intl.DateFormat dateFormat = Intl.DateFormat('yyyy-MM-dd');
//    stackChildren.add(Builder(builder: (context) {
//      return CustomScrollView(
//        slivers: <Widget>[
//          new SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
//          SliverList(
//            delegate: SliverChildListDelegate(listViewChildren),
//          ),
//        ],
//      );
//    }));
    return Scaffold(
      body: StreamBuilder<DailyWrapper>(
        initialData: DailyWrapper(),
        stream: BlocProvider.of<DailyBloC>(context).outDaily,
        builder: (context, snapshot) {
          bool showSnackBar = false;
          if (snapshot.data != null && snapshot.data.daily != null && snapshot.data.daily.bannerList != null && snapshot.data?.daily?.bannerList?.isNotEmpty && snapshot.data?.daily?.dataList?.isNotEmpty) {
            _wrapper = snapshot.data;
          } else if (snapshot.connectionState == ConnectionState.active) {
            showSnackBar = true;
          }
          var children = <Widget>[];
          var count = _wrapper?.daily?.dataList?.length ?? 0;
          if (count > 0) {
            children.add(Builder(builder: (context) {
              return CustomScrollView(
                slivers: <Widget>[
                  new SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _buildItemWidget(_wrapper?.daily?.dataList[index]);
                    },
                                                           childCount: _wrapper?.daily?.dataList?.length ?? 0),
                    )
                ],
                );
            },));
          } else {
            children.add(Text('empty'));
          }
          if (_wrapper != null && _scrollController == null) {
            initScroller(_wrapper.scrollY);
          }
          return NestedScrollView(
            controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrollled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    child: SliverAppBar(
                      floating: false,
                      pinned: true,
                      primary: true,
                      forceElevated: true,
                      elevation: 5.0,
                      expandedHeight: 200.0,
                      title: Text('每日数据'),
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(_wrapper?.date ?? ""),
                        background: _buildBanner(),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            var today = DateTime.now();
                            var last = DateTime.parse('1970-01-01');
                            showDatePicker(context: context, initialDate: today, firstDate: last, lastDate: today)
                              .then((DateTime date) {
                              if (date == null) {
                                return;
                              }
                              BlocProvider.of<DailyBloC>(context).inDate.add(date);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ];
              },
              body: StreamBuilder<bool>(
                stream: BlocProvider.of<DailyBloC>(context).outShouldShowProgress,
                initialData: false,
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    children.add(Center(child: CircularProgressIndicator()));
                  }
                  return Stack(
                    children: children,
                  );
                }
              ));
        },
      ),
    );
  }

  void initScroller(scrollY) {
    _scrollController = ScrollController(initialScrollOffset: scrollY,);
    _scrollController.addListener(() => BlocProvider.of<DailyBloC>(context).inScrollChanged.add(_scrollController.position.pixels));
  }
  
  Widget _buildBanner() {
    if ((_wrapper?.daily == null || _wrapper?.daily?.bannerList == null || _wrapper?.daily?.bannerList?.isEmpty) ?? true) {
      return SizedBox();
    }
    var _bannerList = _wrapper.daily.bannerList;
    List<Widget> children = [
      Container(
        height: 400.0,
        child: PageView.builder(
          itemBuilder: (context, index) => _buildItemWidget(_bannerList[index]),
          controller: _pageController,
          itemCount: _bannerList.length,
        ),
      ),
    ];
    if (_bannerList.length > 1) {
      children.add(Positioned(
        child: Container(
          child: Center(
              child: PageViewIndicator(
            controller: _pageController,
            count: _bannerList.length,
            size: 5.0,
            color: Colors.white,
            indicatorColor: Colors.blue,
          )),
          width: MediaQuery.of(context).size.width,
        ),
        bottom: 5.0,
      ));
    }
    Widget widget = Stack(
      children: children,
    );
    return widget;
  }

  Widget _buildItemWidget(Gank gank) {
    if (gank.type == Const.typeWelfare) {
      return InkWell(
          child: PhotoHolder(
            gank.url,
            fit: BoxFit.cover,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImagePage(gank))));
    } else {
      return InkWell(
        child: TextCard(gank),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewPage(gank.desc, gank.url))),
      );
    }
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
