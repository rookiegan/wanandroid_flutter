import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/rk_utils/rk_utils.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers["Authorization"] = RkKV.getString();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      "Token过期 $response".e();
      // Get.offAll(() => const LoginPage());
      handler.resolve(response);
      return;
    }

    handler.next(response);
  }
}
