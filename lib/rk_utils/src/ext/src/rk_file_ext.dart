import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

extension FileExt on File {
  String md5() {
    var digest = crypto.md5.convert(this.readAsBytesSync());
    return hex.encode(digest.bytes);
  }
}
