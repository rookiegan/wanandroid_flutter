import 'dart:async';

import 'package:wanandroid_flutter/dependency.dart';

import '../_main/main_page.dart';

class SplashLogic extends GetxController {
  final logoOpacity = 1.0.obs;
  late StreamSubscription _subscription;
  int _sign = 1;

  @override
  void onReady() {
    super.onReady();
    _subscription = Stream.periodic(Duration(milliseconds: 20)).map((event) {
      if (logoOpacity.value >= 1.1) {
        _sign = -1;
      } else if (logoOpacity.value <= 0.7) {
        _sign = 1;
      }
      return logoOpacity.value;
    }).commit((event) {
      logoOpacity.value += 0.01 * _sign;
      "event ${logoOpacity.value}".d();
    });

    Future.delayed(Duration(seconds: 2)).then((value) {
      Get.offAllNamed(MainPage.routeName);
    });
  }

  @override
  void onClose() {
    super.onClose();
    _subscription.cancel();
  }
}
