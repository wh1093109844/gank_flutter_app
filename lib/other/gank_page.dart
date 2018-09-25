import 'package:flutter/material.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank_content.dart';

class GankCenterPage extends StatefulWidget {
  @override
  _GankCenterPageState createState() => _GankCenterPageState();
}

class _GankCenterPageState extends State<GankCenterPage> implements GankCenterView{

  bool _showProgress = false;
  List<Content> contentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('干货集中营'),
      ),
      body: Container(
        child: Stack(

        ),
      ),
    );
  }

  @override
  GankCenterPresenter presenter;

  @override
  void setGankContentList(List<Content> contentList) {
    if (mounted) {
      setState(() {
        this.contentList = contentList;
      });
    } else {
      this.contentList = contentList;
    }
  }

  @override
  void setPresenter(GankCenterPresenter presenter) {
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
    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
  }
}
