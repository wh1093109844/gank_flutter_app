// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
