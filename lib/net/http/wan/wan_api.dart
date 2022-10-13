import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:wanandroid_flutter/dependency.dart';
import 'package:wanandroid_flutter/net/http/wan/common_response.dart';

import 'model/model.dart';

part 'wan_api.g.dart';

final wanApi = WanRestClient(_initDio());

Dio _initDio() {
  final Dio dio = Dio();
  dio.options..contentType = 'application/json';
  dio.options..connectTimeout = 20000;
  dio.options..receiveTimeout = 20000;
  dio.options..sendTimeout = 20000;

  dio.interceptors.add(
    InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        "onResponse: ${response}".d();
        handler.next(response);
      },
    ),
  );
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
