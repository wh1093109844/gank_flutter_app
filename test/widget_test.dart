// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gank_flutter_app/entry/gank.dart';
import 'dart:convert';
import 'dart:math';
import 'package:gank_flutter_app/main.dart';

void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(new MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });
  var str = {"error":false,"results":[{"_id":"5b850d2c9d21227c78fb002f","createdAt":"2018-09-18T23:51:10.400Z","desc":"\u8c08\u8c08\u5495\u549a\u548c\u7f8e\u56e2\u7684\u9762\u8bd5\u9898~","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u778e\u63a8\u8350","url":"https://mp.weixin.qq.com/s/UgncTqZJD33kD6lJ3su3bA","used":true,"who":"LiuShilin"},{"_id":"5b8679359d21225cdb085f67","createdAt":"2018-09-18T23:26:17.384Z","desc":"RxJava2 \u5168\u9762\u6559\u7a0b","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u62d3\u5c55\u8d44\u6e90","url":"https://github.com/nanchen2251/RxJava2Examples/blob/master/README.md","used":true,"who":"LiuShilin"},{"_id":"5b8679839d2122470245762f","createdAt":"2018-09-18T23:26:49.137Z","desc":"\u624b\u628a\u624b\u6559\u4f60\u5199\u4e00\u4e2a Kotlin APP (\u6709 Java \u5206\u652f\u5bf9\u6bd4\uff0c\u6570\u636e\u6765\u6e90\u4e8e\u5e72\u8d27\u96c6\u4e2d\u8425)","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u62d3\u5c55\u8d44\u6e90","url":"https://github.com/nanchen2251/AiYaGirl/tree/kotlin","used":true,"who":"LiuShilin"},{"_id":"5b878f049d2122014e6aabcd","createdAt":"2018-09-18T23:27:30.654Z","desc":"\u5e72\u8d27\u96c6\u4e2d\u8425Android app\uff0c\u4f7f\u7528MVP + RxJava2 + Dagger2 + Retrofit \u6784\u5efa","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcgovzzj30k00zk761","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexch11e8j30k00zkgrr","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexch6odxj30k00zk41p"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"App","url":"https://github.com/zeleven/scallop","used":true,"who":"zeleven"},{"_id":"5b977a759d212206c1b383d3","createdAt":"2018-09-11T08:19:01.268Z","desc":"\u624b\u628a\u624b\u6559\u4f60\u5b9e\u73b0\u6296\u97f3\u89c6\u9891\u7279\u6548","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"Android","url":"https://www.jianshu.com/p/5bb7f2a0da90","used":true,"who":"xue5455"},{"_id":"5b97b8819d212206c73cd726","createdAt":"2018-09-18T23:28:53.139Z","desc":"AppBarLayout\u5404\u7248\u672c\u95ee\u9898\u63a2\u7a76\u53ca\u89e3\u51b3","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u62d3\u5c55\u8d44\u6e90","url":"https://blog.csdn.net/qq_17766199/article/details/82561216","used":true,"who":"\u552f\u9e7f"},{"_id":"5b98b9f59d212206c73cd727","createdAt":"2018-09-12T07:02:13.931Z","desc":" LogCollector\uff1a\u4e00\u4e2a\u6536\u96c6 app \u8f93\u51fa\u65e5\u5fd7\u7684\u5de5\u5177","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexchbaadj30u01hcta5","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexchjeypj30u01hc0y3","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexchpj7bj30tv1h9q5y","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexchw320j30u01hcgow"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"Android","url":"https://github.com/ljuns/LogCollector","used":true,"who":"ljuns"},{"_id":"5b98be089d212206cae44993","createdAt":"2018-09-12T07:19:36.23Z","desc":"\u4e00\u4e2a\u7b80\u5355\u4eff\u5fae\u4fe1\u670b\u53cb\u5708\u7684\u56fe\u7247\u67e5\u770b\u5668","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcixf0yg30go0tnb2b","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcjxstyg30go0tn4qs"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"Android","url":"https://github.com/wanglu1209/PhotoViewer","used":true,"who":"wanglu1209"},{"_id":"5b9a0a829d212206c4385c31","createdAt":"2018-09-18T23:30:06.720Z","desc":"Android App \u542f\u52a8\u901f\u5ea6\u4f18\u5316\u5b9e\u73b0\u6f14\u7ec3","publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u62d3\u5c55\u8d44\u6e90","url":"https://www.jianshu.com/p/c821f1fb90d1","used":true,"who":"\u7f57\u5360\u4f1f"},{"_id":"5b9b699b9d212206c1b383d9","createdAt":"2018-09-14T07:56:11.709Z","desc":"LLDebugTool - \u4fbf\u6377\u7684IOS\u8c03\u8bd5\u5de5\u5177\uff08\u652f\u6301Swift\uff09","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcla4m3g307i0dwhdw","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcmlkcyg307g0dwu0z"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"iOS","url":"https://github.com/HDB-Li/LLDebugToolSwift","used":true,"who":"HDB-Li"},{"_id":"5b9ca6679d212206c1b383dc","createdAt":"2018-09-15T06:27:51.165Z","desc":"\u57fa\u65bcpython\u7684\u4e2d\u6587\u5c0f\u8bf4/\u6587\u4ef6tf-idf\u5b9e\u73b0","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcmwiubj310i0iydhz","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcn112hj30tp0jemz1"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u778e\u63a8\u8350","url":"https://github.com/Jasonnor/tf-idf-python","used":true,"who":"Jason Wu"},{"_id":"5b9cc8fe9d212206c4385c34","createdAt":"2018-09-15T08:55:26.301Z","desc":"\u4e0d\u7528\u91cd\u65b0\u6253\u5305\uff0c\u5e94\u7528\u5185\u4e00\u952e\u5207\u6362\u6b63\u5f0f/\u6d4b\u8bd5\u73af\u5883","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcosopxg30f00qo48e"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"Android","url":"https://github.com/CodeXiaoMai/EnvironmentSwitcher","used":true,"who":"\u5c0f\u8fc8"},{"_id":"5b9f471d9d212206c73cd72f","createdAt":"2018-09-18T23:31:38.100Z","desc":"\u8bfb\u53d6\u5fae\u4fe1\u6570\u636e\u5e93\u804a\u5929\u8bb0\u5f55\u5907\u4efd","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcozzudj30sn03sglp","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcp4an1j30ud05eglw"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"\u778e\u63a8\u8350","url":"https://github.com/l123456789jy/WxDatabaseDecryptKey","used":true,"who":"Lazy"},{"_id":"5b9f6cd49d212206c73cd730","createdAt":"2018-09-17T08:59:00.366Z","desc":"\u9ad8\u4eff\u95f2\u9c7c\u3001\u8f6c\u8f6c\u3001\u4eac\u4e1c\u3001\u4e2d\u592e\u5929\u6c14\u9884\u62a5\u7b49\u4e3b\u6d41APP\u5217\u8868\u5e95\u90e8\u5206\u9875\u6eda\u52a8\u89c6\u56fe","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcq0jw6g309j0h3tz4","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcq7r5sg309j0h3kat","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcqf3xeg309j0h3nhg"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"iOS","url":"https://github.com/pujiaxin33/JXPageListView","used":true,"who":"\u66b4\u8d70\u7684\u946b\u946b"},{"_id":"5b9f9cb79d212206c4385c37","createdAt":"2018-09-17T12:23:19.536Z","desc":"\u725b\u903c\u6846\u67b6FlexLib","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcql885j30ek0s2mzc","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcqresxj30ek0s2q3s","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcqv0ecj30ek0s275q"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"web","type":"iOS","url":"https://xiaohuicoding.github.io/2018/08/15/%E4%BD%BF%E7%94%A8%20FlexLib%20%E5%B8%83%E5%B1%80iOS%E9%A1%B5%E9%9D%A2/","used":true,"who":"zhenglibao"},{"_id":"5ba18bc19d2122031ebe97fa","createdAt":"2018-09-18T23:35:29.687Z","desc":"\u4eff\u7b80\u4e66\u7f51\u9875\uff0c\u7f51\u7edc\u52a0\u8f7d\u8fc7\u6e21\u52a8\u753b\u3002","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcr9zb0g308z0iau0x"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"chrome","type":"iOS","url":"https://github.com/tigerAndBull/LoadAnimatedDemo-ios","used":true,"who":"lijinshanmx"},{"_id":"5ba18be79d21220316f09f58","createdAt":"2018-09-18T23:36:07.339Z","desc":"\u7ed8\u5236K\u7ebf\u652f\u6491\u6a2a\u7ad6\u5c4f\u5207\u6362\u3001\u5237\u65b0\u3001\u957f\u6309\u3001\u7f29\u653e\u3001masonry\u9002\u914d\uff0c\u5b8c\u7f8e\u652f\u6301\u91d1\u878d\u4ea7\u54c1\u3002","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcrlshdj31bi0sowo4","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcs0lqpj31700peaf2"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"chrome","type":"iOS","url":"https://github.com/AbuIOSDeveloper/KLine","used":true,"who":"lijinshanmx"},{"_id":"5ba18d009d2122031ebe97fc","createdAt":"2018-09-18T23:40:48.207Z","desc":"\u663e\u793a\u7b49\u5f85\u52a0\u8f7d\u72b6\u6001\u7684View\u3002","publishedAt":"2018-09-19T00:00:00.0Z","source":"chrome","type":"Android","url":"https://github.com/ImKarl/WaitView","used":true,"who":"lijinshanmx"},{"_id":"5ba18dae9d21220316f09f5c","createdAt":"2018-09-18T23:43:42.411Z","desc":"\u91cd\u5199LinearLayout\uff0c\u4eff\u6dd8\u5b9d\u5546\u54c1\u8be6\u60c5\u9875\uff0c\u4e0a\u62c9\u67e5\u770b\u66f4\u591a\u8be6\u60c5\u3002","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcts33ag308x0fxb2h"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"chrome","type":"Android","url":"https://github.com/LineChen/TwoPageLayout","used":true,"who":"lijinshanmx"},{"_id":"5ba18e1a9d2122031c8cde68","createdAt":"2018-09-18T23:45:30.53Z","desc":"\u5feb\u901f\u5b9e\u73b0\u5706\u89d2\uff0c\u8fb9\u6846\uff0cState\u5404\u4e2a\u72b6\u6001\u7684UI\u6837\u5f0f\u3002","images":["https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcupieqg30a60i6e4n","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcuubrfj30a70g40wh","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcuz05hg30a80g440v","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcv4koej30aa0g6gmf","https://ww1.sinaimg.cn/large/0073sXn7ly1fvexcv8jznj30a50g2n11"],"publishedAt":"2018-09-19T00:00:00.0Z","source":"chrome","type":"Android","url":"https://github.com/RuffianZhong/RWidgetHelper","used":true,"who":"lijinshanmx"}]};
  var list = (str['results'] as List).map((json) => Gank.fromJson(json)).toList();
  print(list);
  var s = json.encode(list[0], toEncodable: (gank) => gank.toString());
  print(s);
  var jsonStr = json.encode(list);
  print(jsonStr);
}

void testBlock() {
  int i = 0;
  var block = 0;
  Random random = Random();
  List<List<int>> blocks = [[0, 0, 0], [0, 0, 0]];
  List<List<int>> temp = initBlock(3, 3);
  while(i < 100) {
    Point p = getStart(temp);
    if (p.x == temp[0].length && p.y == temp.length) {
      print('===============');
      temp = initBlock(3, 3);
      p = getStart(temp);
    }
    int maxWidth = getMaxWidth(temp, p);
    int maxHeight = temp.length - p.y;
    if (maxWidth == 3 && maxHeight < 2) {
      maxWidth = 1;
    }
    int width = random.nextInt(maxWidth) + 1;
    int height = width == 3 ? 2 : random.nextInt(maxHeight) + 1;
    for (int j = p.y; j < p.y + height; j++) {
      List<int> row = temp[j];
      for (int k = p.x; k < p.x + width; k++) {
        row[k] = 1;
      }
    }
    print(Point(width, height));
    i++;
  }
}

List<List<int>> initBlock(int width, int height) {
  List<List<int>> list = [];
  for (int i = 0; i < height; i++) {
    List<int> row = [];
    for (int j = 0; j < width; j++) {
      row.add(0);
    }
    list.add(row);
  }
  return list;
}

Point<int> getStart(List<List<int>> blocks) {
  int w = 0;
  int h = 0;
  for (h = 0; h < blocks.length; h++) {
    List<int> row = blocks[h];
    for (w = 0; w < row.length; w++) {
      if (row[w] == 0) {
        break;
      }
    }
    if (w < row.length) {
      break;
    }
  }
  return Point(w, h);
}

int getMaxWidth(List<List<int>> blocks, Point<int> point) {
  int maxW = 1;
  for (int i = point.x + 1; i < blocks[point.y].length; i++) {
    if (blocks[point.y][i] == 0) {
      maxW += 1;
    } else {
      break;
    }
  }
  return maxW;
}
