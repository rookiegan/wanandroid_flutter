import 'package:get/get.dart';
import 'package:wanandroid_flutter/modules/_test/test_index.dart';

import '_home/home_page.dart';

class RouterManager {
  static final List<GetPage> routers = [
    GetPage(name: HomePage.routeName, page: () => HomePage()),
    ...TestIndex.routers,
  ];
}
