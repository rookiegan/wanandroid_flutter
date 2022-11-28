import 'package:get/get.dart';
import 'package:wanandroid_flutter/modules/_main/main_page.dart';
import 'package:wanandroid_flutter/modules/_test/test_index.dart';
import 'package:wanandroid_flutter/modules/splash/splash_view.dart';

class RouterManager {
  static final List<GetPage> routers = [
    GetPage(name: MainPage.routeName, page: () => MainPage()),
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    ...TestIndex.routers,
  ];
}
