import 'package:flutter/material.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank.dart';

class HomeDemo extends StatefulWidget {
    @override 
    _HomeDemoState createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> implements HomeView {
    
    List<Gank> _bannerList;
    List<Gank> _dataList;
    bool _showProgress = false;

    @override
    HomePresenter presenter;
    
    @override 
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('首页'),
            ),
            body: ListView(),
        );
    }
    
    Widget _buildBanner() {
        PageView pageView = PageView.builder(itemBuilder: null);
    }
    
    Widget _pageItemBuilder(BuildContext context, int index) {
        return InkWell(
            child: PhotoHolder(_bannerList[index].url),
            onTap: () {
//                Navigator.of(context).push()
            },
        );
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
