import 'dart:async';
import 'package:mmkv/mmkv.dart';
import 'package:wanandroid_flutter/rk_utils/rk_utils.dart';

class RkKV {
  static late MMKV _mmkv;
  static const String _cryptKey = "1234321";

  static initialize() async {
    final rootDir = await MMKV.initialize();
    _mmkv = MMKV.defaultMMKV(cryptKey: _cryptKey);
    "MMKV for flutter with rootDir = $rootDir".d();
  }

  static void clear() {
    _mmkv.clearAll();
  }

  static String getString(String key, {String defaultValue = ""}) {
    String? value = _mmkv.decodeString(key);
    value ??= defaultValue;
    return value;
  }

  static bool putString(String key, String value) {
    return _mmkv.encodeString(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _mmkv.decodeBool(key, defaultValue: defaultValue);
  }

  static bool putBool(String key, bool value) {
    return _mmkv.encodeBool(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _mmkv.decodeInt(key, defaultValue: defaultValue);
  }

  static bool putInt(String key, int value) {
    return _mmkv.encodeInt(key, value);
  }

  static bool putDouble(String key, double value) {
    return _mmkv.encodeDouble(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _mmkv.decodeDouble(key, defaultValue: defaultValue);
  }
}
