class StringUtil {
  static String indemnifyString(String? originStr) {
    if (originStr == null) {
      return "";
    }
    int start;
    int end;
    if (originStr.length == 11) {
      start = 3;
      end = 7;
    } else {
      start = originStr.length ~/ 3;
      end = originStr.length * 2 ~/ 3;
    }

    var str = originStr.substring(0, start);
    for (int i = start; i < end; i++) {
      str += "*";
    }
    str += originStr.substring(end, originStr.length);
    return str;
  }
}
