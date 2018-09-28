import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/home_presenter_impl.dart';
import 'package:gank_flutter_app/widgets/page_view_indicator.dart';
import 'package:intl/intl.dart' as Intl;
import 'dart:math' as math;

class HomeDemo extends StatefulWidget {

  HomeDemo({Key key}): super(key: key);

  @override
  _HomeDemoState createState() {
    _HomeDemoState state = _HomeDemoState();
    HomePresenterImpl(state);
    return state;
  }
}

class _HomeDemoState extends State<HomeDemo> with AutomaticKeepAliveClientMixin<HomeDemo> implements HomeView {
  List<Gank> _bannerList = [];
  List<Gank> _dataList = [];
  bool _showProgress = false;
  PageController _pageController;
  DateTime time = DateTime.now();
  bool reverse = false;

  @override
  HomePresenter presenter;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    if (presenter != null) {
      presenter.start();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listViewChildren = _dataList.map((gank) => _buildItemWidget(gank)).toList();
    var stackChildren = <Widget>[];
    if (_showProgress) {
      stackChildren.add(Center(child: CircularProgressIndicator()));
    }
    Intl.DateFormat dateFormat = Intl.DateFormat('yyyy-MM-dd');
    stackChildren.add(Builder(builder: (context) {
      return CustomScrollView(
        slivers: <Widget>[
          new SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverList(
            delegate: SliverChildListDelegate(listViewChildren),
          ),
        ],
      );
    }));
    return Scaffold(
      key: ObjectKey('home'),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                  centerTitle: true,
                  title: new Text(dateFormat.format(time)),
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
                          time = date;
                          presenter.fetch(date.year, date.month, date.day);
                        });
                      },
                    ),
                ],
              ),
            ),
          ];
        },
        body: Container(
          child: Stack(
            children: stackChildren,
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    if (_bannerList.isEmpty ?? true) {
      return SizedBox();
    }
    List<Widget> children = [
      Container(
        height: 400.0,
        child: PageView.builder(
          itemBuilder: _pageItemBuilder,
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

  Widget _pageItemBuilder(BuildContext context, int index) {
    if (_bannerList == null) {
      return null;
    }
    return _buildItemWidget(_bannerList[index]);
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

  @override
  void setBannerList(List<Gank> bannerList) {
    if (mounted) {
      setState(() {
        this._bannerList = bannerList;
      });
    } else {
      this._bannerList = bannerList;
    }
  }

  @override
  void setDataList(List<Gank> dataList) {
    if (mounted) {
      setState(() {
        this._dataList = dataList;
      });
    } else {
      this._dataList = dataList;
    }
  }

  @override
  void setPresenter(HomePresenter presenter) {
    this.presenter = presenter;
  }

  @override
  void showDialog(bool isShow) {
    if (mounted) {
      setState(() {
        this._showProgress = isShow;
      });
    } else {
      this._showProgress = isShow;
    }
  }

  @override
  void showMessage(String message) {
    if (!mounted) {
      return;
    }
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}

class TopRightFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    print('TopRightFloatingActionButtonLocation\toffset');
    double fabX;
    assert(scaffoldGeometry.textDirection != null);
    switch (scaffoldGeometry.textDirection) {
      case TextDirection.rtl:
        // In RTL, the end of the screen is the left.
        final double endPadding = scaffoldGeometry.minInsets.left;
        fabX = kFloatingActionButtonMargin + endPadding;
        break;
      case TextDirection.ltr:
        // In LTR, the end of the screen is the right.
        final double endPadding = scaffoldGeometry.minInsets.right;
        fabX = scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width -
            kFloatingActionButtonMargin -
            endPadding;
        break;
    }

    // Compute the y-axis offset.
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight - kFloatingActionButtonMargin;
    if (snackBarHeight > 0.0)
      fabY = math.min(fabY, contentBottom - snackBarHeight - fabHeight - kFloatingActionButtonMargin);
    if (bottomSheetHeight > 0.0) fabY = math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    return new Offset(fabX, scaffoldGeometry.contentTop);
  }
}
