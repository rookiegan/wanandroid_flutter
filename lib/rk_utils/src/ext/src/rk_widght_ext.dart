import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetExt on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget padding({num left = 0.0, num top = 0.0, num right = 0.0, num bottom = 0.0}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left = left.toDouble(),
        top = top.toDouble(),
        right = right.toDouble(),
        bottom = bottom.toDouble(),
      ),
      child: this,
    );
  }

  Widget paddingHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(value, 0, value, 0),
      child: this,
    );
  }

  Widget paddingVertical(double value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, value, 0, value),
      child: this,
    );
  }

  Widget container({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      child: this,
    );
  }

  Widget click(GestureTapCallback onTap) {
    return InkWell(
      child: this,
      onTap: onTap,
    );
  }

  Widget visibility(bool visible) {
    return Visibility(
      child: this,
      visible: visible,
    );
  }
}
