import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/card/text_card.dart';
import 'package:gank_flutter_app/const.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'package:gank_flutter_app/pages/image_page.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/home_presenter_impl.dart';

class HomeDemo extends StatefulWidget {
    @override 
    _HomeDemoState createState() {
        _HomeDemoState state = _HomeDemoState();
        HomePresenterImpl(state);
        return state;
    }
}

class _HomeDemoState extends State<HomeDemo> implements HomeView {
    
    List<Gank> _bannerList = [];
    List<Gank> _dataList = [];
    bool _showProgress = false;
    PageController _pageController;

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
        listViewChildren.insert(0, _buildBanner());
        var listView = ListView(children: listViewChildren,);
        var stackChildren = <Widget>[];
        if (_showProgress) {
            stackChildren.add(Center(child: CircularProgressIndicator()));
        }
        stackChildren.add(listView);
        return Scaffold(
            appBar: AppBar(
                title: Text('首页'),
            ),
            body: Container(
                child: Stack(
                    children: stackChildren,
                ),
            ),
        );
    }
    
    Widget _buildBanner() {
        if (_bannerList.isEmpty ?? true) {
            return SizedBox();
        }
        Widget widget = AspectRatio(
            aspectRatio: 2.0,
          child: PageView.builder(
              itemBuilder: _pageItemBuilder,
              controller: _pageController,
              itemCount: _bannerList.length,),
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
                child: PhotoHolder(gank.url, fit: BoxFit.cover,),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImagePage(gank)))
            );
        } else {
            return InkWell(
                child: TextCard(gank),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewPage(gank))),
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
}
