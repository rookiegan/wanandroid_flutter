library rk_utils;

import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'dart:io';

export 'src/ext/index.dart';
export 'src/rk_kv.dart';
export 'package:wanandroid_flutter/generated/l10n.dart';
export 'dart:io';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'src/constant/index.dart';
export 'src/base/rk_object.dart';

get statusBarHeight => MediaQueryData.fromWindow(window).padding.top;

bool get isAndroid => Platform.isAndroid;

bool get isIOS => Platform.isIOS;

bool get isMacOS => Platform.isMacOS;

bool get isLinux => Platform.isLinux;

bool get isWindows => Platform.isWindows;
