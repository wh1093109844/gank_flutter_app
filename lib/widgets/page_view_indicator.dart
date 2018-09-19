import 'package:flutter/material.dart';
import 'dart:math';
class PageViewIndicator extends StatefulWidget {

    PageController controller;
    int count;
    double size;
    Color color;
    Color indicatorColor;

    PageViewIndicator({
        @required this.controller,
        @required this.count,
        this.size = 5.0,
        this.color = Colors.white,
        this.indicatorColor = Colors.white
    });

  @override
  _PageViewIndicatorState createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<PageViewIndicator> {

    double page = 0.0;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(handleListener);
  }

  void handleListener() {
        double pixels = widget.controller.position.pixels;
        double page = widget.controller.page;
        setState(() {
          this.page = page;
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.removeListener(handleListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: _buildChild(),
            mainAxisAlignment: MainAxisAlignment.center,
        ),
    );
  }

  List<Widget> _buildChild() {
      List<Widget> list = [];
      for (int i = 0; i < widget.count; i++) {
          var paddingRight = i == widget.count - 1 ? 0.0 : widget.size;
          double size = getCurrentSize(i);
          Color color = getCurrentColor(i);
          list.add(Padding(
            padding: EdgeInsets.only(right: paddingRight),
            child: CircleAvatar(
                backgroundColor: color,
                radius: size / 2.0,
            ),
          ));
      }
      return list;
  }

  double getCurrentSize(int i) {
      double size = widget.size;
      double index = i.toDouble();
      if (index <= page && index + 1.0 > page) {
          size = size + size * 0.5 * (1.0 + index - page);
      } else if (index >= page && index - 1.0 < page) {
          size = size + size * 0.5 * (page - index + 1.0);
      }
      return size;
  }

  Color getCurrentColor(int i) {
        double startAlpha = widget.color.alpha.toDouble();
        double startRed = widget.color.red.toDouble();
        double startGreen = widget.color.green.toDouble();
        double startBlue = widget.color.blue.toDouble();
        double endAlpha = widget.indicatorColor.alpha.toDouble();
        double endRed = widget.indicatorColor.red.toDouble();
        double endGreen = widget.indicatorColor.green.toDouble();
        double endBlue = widget.indicatorColor.blue.toDouble();
        double index = i.toDouble();
        double ratio = 0.0;
        if (index <= page && index + 1.0 > page) {
            ratio = (1.0 + index - page);
        } else if (index >= page && index - 1.0 < page) {
            ratio = (page - index + 1.0);
        }
        double offsetAlpha = (endAlpha - startAlpha) * ratio;
        double offsetRed = (endRed - startRed) * ratio;
        double offsetGreen = (endGreen - startGreen) * ratio;
        double offsetBlue = (endBlue - startBlue) * ratio;
        Color color = Color.fromARGB((startAlpha + offsetAlpha).toInt(), (startRed + offsetRed).toInt(), (startGreen + offsetGreen).toInt(), (startBlue + offsetBlue).toInt());
        return color;
  }
}
