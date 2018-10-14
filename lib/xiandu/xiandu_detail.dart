import 'package:flutter/material.dart';
import 'package:gank_flutter_app/bloc_provider.dart';
import 'package:gank_flutter_app/entry/xiandu.dart';
import 'package:gank_flutter_app/pages/webview_page.dart';
import 'package:gank_flutter_app/xiandu/xiandu_detail_bloc.dart';

class XianduDetail extends StatefulWidget {

  XianduDetail();

  @override
  XianduDetailState createState() {
    return new XianduDetailState();
  }
}

class XianduDetailState extends State<XianduDetail> {
  @override
  Widget build(BuildContext context) {
    XianduDetailBloc bloc = BlocProvider.of<XianduDetailBloc>(context);
    return StreamBuilder<Xiandu>(
      stream: bloc.outTitle,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator(),);
        } else if (snapshot.data?.url?.isEmpty ?? true) {
          return Scaffold(
            appBar: AppBar(title: Text(snapshot.data?.title ?? ''),),
            body: Center(child: CircularProgressIndicator(),),
          );
        } else {
          return WebviewPage(snapshot.data?.title ?? '', snapshot.data?.url ?? '');
        }

      },
    );
  }

  @override
  void dispose() {
    BlocProvider.of<XianduDetailBloc>(context).dispose();
    super.dispose();
  }
}
