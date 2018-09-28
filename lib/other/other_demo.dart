import 'package:flutter/material.dart';
import 'package:gank_flutter_app/other/gank_page.dart';

class OtherDemo extends StatelessWidget {

  OtherDemo({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ObjectKey('other'),
      appBar: AppBar(
        title: Text('其他'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('干货集中营'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GankCenterPage()));
            },
          ),
          Divider(height: 1.0,),
          ListTile(
            title: Text('更新历史'),
          ),
          Divider(height: 1.0,),
          ListTile(
            title: Text('我的收藏'),
          ),
          Divider(height: 1.0,)
        ],
      ),
    );
  }
}
