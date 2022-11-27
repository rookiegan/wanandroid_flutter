import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'media_query_test_logic.dart';

class MediaQueryTestPage extends StatelessWidget {
  static final routeName = "/MediaQueryTestPage";

  final logic = Get.put(MediaQueryTestLogic());

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    final screenSize = mediaQueryData.size;
    final devicePixelRatio = mediaQueryData.devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text("MediaQueryTestPage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 屏幕大小
            ListTile(
              title: Text("屏幕大小  $screenSize dp"),
              subtitle: Text("MediaQuery.of(context).size"),
            ),

            /// 屏幕密度
            ListTile(
              title: Text("屏幕密度  $devicePixelRatio"),
              subtitle: Text("MediaQuery.of(context).devicePixelRatio"),
            ),

            /// 设备像素
            ListTile(
              title: Text(
                "设备像素 (${devicePixelRatio * screenSize.width} px, ${devicePixelRatio * screenSize.height} px)",
              ),
              subtitle: Text("MediaQuery.of(context).devicePixelRatio * MediaQuery.of(context).size.width"),
            ),

            /// 上下边距(刘海、内置导航键)
            ListTile(
              title: Text("上下边距 刘海:${mediaQueryData.padding.top}, 内置导航键:${mediaQueryData.padding.bottom}"),
              subtitle: Text("MediaQuery.of(context).padding"),
            ),

            /// textScaleFactor
            ListTile(
              title: Text("文字缩放系数 ${MediaQuery.of(context).textScaleFactor}"),
              subtitle: Text("MediaQuery.of(context).textScaleFactor"),
            ),

            /// platformBrightness
            ListTile(
              title: Text("文字缩放系数 ${MediaQuery.of(context).platformBrightness}"),
              subtitle: Text("MediaQuery.of(context).platformBrightness"),
            ),

            /// viewInsets
            ListTile(
              title: Text("完全被系统UI(如键盘)遮挡的显示部分 ${MediaQuery.of(context).viewInsets}"),
              subtitle: Text("MediaQuery.of(context).viewInsets"),
            ),

            /// alwaysUse24HourFormat
            ListTile(
              title: Text("是否使用24小时格式格式化 ${MediaQuery.of(context).alwaysUse24HourFormat}"),
              subtitle: Text("MediaQuery.of(context).alwaysUse24HourFormat"),
            ),

            /// accessibleNavigation
            ListTile(
              title: Text("是否使用辅助功能进行交互 ${MediaQuery.of(context).accessibleNavigation}"),
              subtitle: Text("MediaQuery.of(context).accessibleNavigation"),
            ),

            /// invertColors
            ListTile(
              title: Text("是否反转平台的颜色 ${MediaQuery.of(context).invertColors}"),
              subtitle: Text("MediaQuery.of(context).invertColors"),
            ),

            /// disableAnimations
            ListTile(
              title: Text("平台是否要求尽可能禁用或减少动画 ${MediaQuery.of(context).disableAnimations}"),
              subtitle: Text("MediaQuery.of(context).disableAnimations"),
            ),

            /// boldText
            ListTile(
              title: Text("平台是否请求使用粗体字体重绘制文本 ${MediaQuery.of(context).boldText}"),
              subtitle: Text("MediaQuery.of(context).boldText"),
            ),
          ],
        ),
      ),
    );
  }
}
