import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gank_flutter_app/entry/gank.dart';
class WebviewPage extends StatefulWidget {

	String title;
	String url;

	WebviewPage(this.title, this.url);

  @override
  WebviewPageState createState() {
    return new WebviewPageState();
  }
}

class WebviewPageState extends State<WebviewPage> {

	String url;

	final flutterWebviewPlugin = new FlutterWebviewPlugin();

	StreamSubscription _onDestroy;
	StreamSubscription<String> _onUrlChanged;
	StreamSubscription<WebViewStateChanged> _onStateChanged;
	StreamSubscription<WebViewHttpError> _onHttpError;

	final _urlCtrl = new TextEditingController(text: "");
	final _codeCtrl = new TextEditingController(text: 'window.navigator.userAgent');
	final _scaffoldKey = new GlobalKey<ScaffoldState>();

	final _history = [];

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterWebviewPlugin.close();
	_urlCtrl.addListener(() => url = _urlCtrl.text);
	_onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
		if (mounted) {
			print('onDestroy\t$url');
		}
		Navigator.of(context).pop();
	});
	_onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
		if (mounted) {
			this.url = url;
			print('onUrlChanged\t$url');
		}
	});

	_onStateChanged = flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
		if (mounted) {
			print('onStateChanged: ${state.type}\t${state.url}');
		}
	});
	_onHttpError = flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
		if (mounted) {
			print('onHttpError: ${error.code}\t${error.url}');
		}
	});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title,),
        automaticallyImplyLeading: true,
      ),
	    withJavascript: true,
	    url: widget.url,
	    withZoom: true,
	    withLocalStorage: true,
	    withLocalUrl: true,
      enableAppScheme: true,
    );
  }
}
