import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/rk_utils/rk_utils.dart';

class NetLogInterceptor extends Interceptor {
  final String tag = "NETWORK";
  final Map<String, RequestOptions> reqMaps = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (reqMaps.length > 100) {
      reqMaps.clear();
    }

    reqMaps[options.hashCode.toString()] = options;
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    saveError(err);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    saveResponse(response);
    handler.next(response);
  }

  String saveRequest(RequestOptions options) {
    StringBuffer str = StringBuffer("");
    str.writeln("$tag - REQUEST -------------------------");
    str.writeln("\t\t ${options.method}");
    str.writeln("\t\t ${options.uri.toString()}");

    final requestHeaders = {};
    requestHeaders.addAll(options.headers);
    requestHeaders['contentType'] = options.contentType?.toString();
    requestHeaders['responseType'] = options.responseType.toString();
    requestHeaders['followRedirects'] = options.followRedirects;
    requestHeaders['connectTimeout'] = options.connectTimeout;
    requestHeaders['receiveTimeout'] = options.receiveTimeout;
    str.writeln("request headers: ");

    str.writeln("\t\t{");
    requestHeaders.forEach((key, value) {
      str.writeln("\t\t\t$key : $value");
    });
    str.writeln("\t\t}");

    if (options.method != 'GET') {
      str.writeln("request body: ");
      str.writeln("\t\t{");
      final data = options.data;
      if (data != null) {
        if (data is Map) {
          data.forEach((key, value) {
            str.writeln("\t\t\t$key : $value");
          });
          // prettyPrintJsonFromObject(data);
        } else if (data is FormData) {
          final formDataMap = Map()
            ..addEntries(data.fields)
            ..addEntries(data.files);
          formDataMap.forEach((key, value) {
            str.writeln("\t\t\t$key : $value");
          });
        } else {
          options.data.toString().split('\n').forEach((element) {
            str.writeln("\t\t\t$element");
          });
        }
      }
      str.writeln("\t\t}");
    }

    return str.toString();
  }

  void saveResponse(Response response) {
    if (!reqMaps.containsKey(response.requestOptions.hashCode.toString())) {
      return;
    }

    RequestOptions? options = reqMaps.remove(response.requestOptions.hashCode.toString());

    StringBuffer str = StringBuffer(saveRequest(options!));

    str.writeln("response: ");
    str.writeln("\t\t${response.requestOptions.method}");
    str.writeln("\t\t${response.statusCode} - ${response.statusMessage}");
    str.writeln("\t\t${response.requestOptions.uri.toString()}");
    str.writeln("response headers: ");
    str.writeln("\t\t{");
    response.headers.toString().split('\n').forEach((element) {
      if (element.isNotEmpty) str.writeln("\t\t\t$element");
    });
    str.writeln("\t\t}");
    str.writeln("response data: ");

    if (response.data != null) {
      if (response.data is Map) {
        _printPrettyMap(str, response.data);
      } else if (response.data is List) {
        str.writeln("${_indent()}[");
        _printList(str, response.data);
        str.writeln("${_indent()}[");
      } else {
        _printBlock(str, response.data.toString());
      }
    }
    str.toString().i();
  }

  void saveError(DioError err) {
    if (!reqMaps.containsKey(err.requestOptions.hashCode.toString())) {
      return;
    }

    RequestOptions? options = reqMaps.remove(err.requestOptions.hashCode.toString());
    StringBuffer str = StringBuffer(saveRequest(options!));

    str.writeln("error: ");
    if (err.type == DioErrorType.response) {
      if (err.response != null) {
        str.writeln("\t\t${err.response!.requestOptions.uri.toString()}");
        str.writeln("\t\t${err.response!.statusCode}");
        str.writeln("\t\t${err.response!.statusMessage}");
      } else {
        str.writeln("\t\t${err.requestOptions.uri.toString()}");
      }

      if (err.response != null && err.response?.data != null) {
        str.writeln("\t\t${err.type.toString()}");
        err.response.toString().split('\n').forEach((element) {
          str.writeln("\t\t$element");
        });
      }
    } else {
      str.writeln("\t\t${err.type}");
      if (err.response != null) {
        str.writeln("\t\t${err.response!.requestOptions.uri.toString()}");
        str.writeln("\t\t${err.response!.statusCode}");
        str.writeln("\t\t${err.response!.statusMessage}");
      } else {
        str.writeln("\t\t${err.requestOptions.uri.toString()}");
      }

      str.writeln("\t\t${err.message}");
    }

    str.toString().e();
  }

  static const int initialTab = 2;
  static const String tabStep = "\t";
  final bool compact = true;
  final int maxWidth = 90;

  String _indent([int tabCount = initialTab]) => tabStep * tabCount;

  bool _canFlattenMap(Map map) {
    return map.values.where((val) => val is Map || val is List).isEmpty && map.toString().length < maxWidth;
  }

  bool _canFlattenList(List list) {
    return (list.length < 10 && list.toString().length < maxWidth);
  }

  void _printPrettyMap(StringBuffer str, Map data,
      {int tabs = initialTab, bool isListItem = false, bool isLast = false}) {
    final bool isRoot = tabs == initialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) str.writeln("$initialIndent{");

    data.keys.toList().asMap().forEach((index, key) {
      final isLast = index == data.length - 1;
      var value = data[key];
      if (value is String) value = '\"$value\"';
      if (value is Map) {
        if (compact && _canFlattenMap(value))
          str.writeln("${_indent(tabs)} $key: $value${!isLast ? ',' : ''}");
        else {
          str.writeln("${_indent(tabs)} $key: {");
          _printPrettyMap(str, value, tabs: tabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value))
          str.writeln("${_indent(tabs)} $key: ${value.toString()}");
        else {
          str.writeln("${_indent(tabs)} $key: [");
          _printList(str, value, tabs: tabs);
          str.writeln("${_indent(tabs)} ]${isLast ? '' : ','}");
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          int lines = (msg.length / linWidth).ceil();
          for (int i = 0; i < lines; ++i) {
            str.writeln(
                "${_indent(tabs)} ${msg.substring(i * linWidth, min<int>(i * linWidth + linWidth, msg.length))}");
          }
        } else
          str.writeln("${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}");
      }
    });

    str.writeln("$initialIndent}${isListItem && !isLast ? ',' : ''}");
  }

  void _printList(StringBuffer str, List list, {int tabs = initialTab}) {
    list.asMap().forEach((i, e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e))
          str.writeln("${_indent(tabs)}  $e${!isLast ? ',' : ''}");
        else
          _printPrettyMap(str, e, tabs: tabs + 1, isListItem: true, isLast: isLast);
      } else
        str.writeln("${_indent(tabs + 2)} $e${isLast ? '' : ','}");
    });
  }

  void _printBlock(StringBuffer str, String msg) {
    int lines = (msg.length / maxWidth).ceil();
    for (int i = 0; i < lines; ++i) {
      str.writeln(msg.substring(i * maxWidth, min<int>(i * maxWidth + maxWidth, msg.length)));
    }
  }

  static JsonDecoder decoder = const JsonDecoder();
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static void prettyPrintJsonFromString(String input) {
    var object = decoder.convert(input);
    var prettyString = encoder.convert(object);
    prettyString.split('\n').forEach((element) => element.i());
  }

  static void prettyPrintJsonFromObject(Object map) {
    var prettyString = encoder.convert(map);
    prettyString.split('\n').forEach((element) => element.i());
  }
}
