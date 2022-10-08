import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import '../../debug/rk_debug_util.dart';
import '../../string_util.dart';
import '../../toast_util.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import '../../base_dependency.dart';

extension StringExt on String {
  static const DEBUG_PREFIX = "DEBUG >>>";

  void successToast({bool crossPage: false}) {
    ToastUtil.showSuccessToast(this, crossPage: crossPage);
  }

  void errorToast({bool crossPage: false}) {
    ToastUtil.showErrorToast(this, crossPage: crossPage);
  }

  void infoToast({bool crossPage: false}) {
    ToastUtil.showInfoToast(this, crossPage: crossPage);
  }

  void debugSuccessToast({bool crossPage: false}) {
    "$DEBUG_PREFIX ${this}".d();
    if (!isDebug) return;
    "$DEBUG_PREFIX ${this}".successToast(crossPage: crossPage);
  }

  void debugErrorToast({bool crossPage: false}) {
    "$DEBUG_PREFIX ${this}".e();
    if (!isDebug) return;
    "$DEBUG_PREFIX ${this}".errorToast(crossPage: crossPage);
  }

  void debugInfoToast({bool crossPage: false}) {
    "$DEBUG_PREFIX ${this}".d();
    if (!isDebug) return;
    "$DEBUG_PREFIX ${this}".infoToast(crossPage: crossPage);
  }

  void debugToast({bool crossPage: false}) {
    debugInfoToast(crossPage: crossPage);
  }

  /// 国际化转换，通过ID拿国际化翻译
  String intlMessage() {
    return Intl.message(this);
  }

  Uint8List decodeBase64() {
    var data = this.replaceAll('\n', '');
    return base64.decode(data);
  }

  String md5() {
    var content = new Utf8Encoder().convert(this);
    var digest = crypto.md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// 对String中间1/3加上星号
  String indemnify() {
    return StringUtil.indemnifyString(this);
  }

  void d([String? tag]) {
    if (isDebug) log("${DateTime.now()} DEBUG >>> ${tag ?? ""} ${this}");
  }

  void i([String? tag]) {
    if (isDebug) log("${DateTime.now()} INFO >>> ${tag ?? ""} ${this}");
  }

  void e([String? tag]) {
    if (isDebug) log("${DateTime.now()} ERROR >>> ${tag ?? ""} ${this}");
  }

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      "toInt exception $e".e();
      return 0;
    }
  }
}
