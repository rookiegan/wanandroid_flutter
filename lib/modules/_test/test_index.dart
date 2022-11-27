import 'package:get/get.dart';
import 'package:wanandroid_flutter/modules/_test/test_page.dart';

import 'getx/getx_test_page.dart';
import 'inherited_widget/inherited_widget_test_page.dart';
import 'media_query/media_query_test_page.dart';

export 'package:wanandroid_flutter/modules/_test/getx/getx_test_page.dart';

export '../_test/test_page.dart';

class TestIndex {
  static final routers = [
    GetPage(name: TestPage.routeName, page: () => const TestPage()),
    GetPage(name: GetxTestPage.routeName, page: () => const GetxTestPage()),
    GetPage(name: MediaQueryTestPage.routeName, page: () => MediaQueryTestPage()),
    GetPage(name: InheritedWidgetTestPage.routeName, page: () => const InheritedWidgetTestPage()),
  ];
}
