import 'package:wanandroid_flutter/dependency.dart';

abstract class RkObject extends Object {
  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  String toString() {
    try {
      return toJson().toString();
    } catch (error, stackTrace) {
      "$runtimeType#toString Error, $error".e();
      "    stackTrace, $stackTrace".e();
      return toString();
    }
  }
}
