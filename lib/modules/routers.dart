import 'package:get/get.dart';
import 'package:wanandroid_flutter/modules/_test/test_index.dart';
import 'package:wanandroid_flutter/modules/splash/splash_view.dart';

import '_home/home_page.dart';

class RouterManager {
  static final List<GetPage> routers = [
    GetPage(name: HomePage.routeName, page: () => HomePage()),
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    ...TestIndex.routers,
  ];
}
