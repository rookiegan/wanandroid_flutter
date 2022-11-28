export 'package:wanandroid_flutter/net/http/wan/common_response.dart';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/adapter.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/net/http/wan/common_response.dart';

import '../interceptors/net_log_interceptor.dart';
import '../interceptors/token_interceptor.dart';
import 'model/model.dart';

part 'wan_api.g.dart';

final wanApi = WanRestClient(_initDio());

Dio _initDio() {
  final Dio dio = Dio();
  dio.options..contentType = 'application/json';
  dio.options..connectTimeout = 20000;
  dio.options..receiveTimeout = 20000;
  dio.options..sendTimeout = 20000;

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback = (cert, host, port) => true;
  };

  dio.interceptors.add(TokenInterceptor());
  dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
  dio.interceptors.add(NetLogInterceptor());
  dio.interceptors.add(DioLogInterceptor());
  return dio;
}

@RestApi(baseUrl: "https://www.wanandroid.com")
abstract class WanRestClient {
  factory WanRestClient(Dio dio, {String baseUrl}) = _WanRestClient;

  @GET("/banner/json")
  Future<CommonResponse<List<BannerData>>> getBannerArticles();

  @GET("/article/list/0/json")
  Future<CommonResponse<PageResponse<ArticleData>>> getArticleList();
}
