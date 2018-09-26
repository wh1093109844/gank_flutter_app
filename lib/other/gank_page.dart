import 'package:flutter/material.dart';
import 'package:gank_flutter_app/contrack.dart';
import 'package:gank_flutter_app/entry/gank_content.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/presenter/gank_center_presenter_impl.dart';
import 'package:intl/intl.dart';

class GankCenterPage extends StatefulWidget {
  @override
  _GankCenterPageState createState() {
    _GankCenterPageState state = _GankCenterPageState();
    GankCenterPresenterImpl(state);
    return state;
  }
}

class _GankCenterPageState extends State<GankCenterPage> implements GankCenterView {
  bool _showProgress = false;
  List<Content> contentList = [];
  DateFormat format = DateFormat('yyyy-MM-dd');
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _controller.addListener(scrollListener);
    presenter.start();
  }

  void scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      presenter.fatchGankCenterList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    if (contentList == null || contentList.isEmpty) {
      list.add(Center(child: Text('暂时没有数据~')));
    } else {
      List<Widget> children = [];
      contentList.forEach((content) {
        children.add(buildItem(content));
        children.add(Divider(
          height: 1.0,
        ));
      });
      list.add(ListView(
        children: children,
        controller: _controller,
      ));
    }
    if (_showProgress) {
      list.add(Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('干货集中营'),
      ),
      body: Container(
        child: Stack(
          children: list,
        ),
      ),
    );
  }

  Widget buildItem(Content content) {
    return InkWell(
      onTap: () {
        presenter.onItemClick(content);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                content.title,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(content.updated_at == null ? '' : format.format(content.updated_at)),
            )
          ],
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
        this.contentList.addAll(contentList);
      });
    } else {
      this.contentList.addAll(contentList);
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
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void openWebview(String title, String url) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebviewPage(title, url)));
  }
}
