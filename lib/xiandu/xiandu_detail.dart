import 'package:flutter/material.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:gank_flutter_app/card/image_card.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';

class XianduDetail extends StatefulWidget {

  Xiandu xiandu;

  XianduDetail(@required this.xiandu);

  @override
  XianduDetailState createState() => new XianduDetailState();
}

class XianduDetailState extends State<XianduDetail> {
  @override
  Widget build(BuildContext context) {
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
                  background: PhotoHolder(widget.xiandu.cover ?? '', fit: BoxFit.cover,),
                  title: Text(widget.xiandu.title ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,),
                ),
              ),
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        HtmlTextView(data: widget.xiandu.content),
                      ],
                    ),
                  ),
                ]
              );
            },
          ),
        )),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
}
