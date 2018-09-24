import 'package:flutter/material.dart';

class OtherDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('其他'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('干货集中营'),
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
