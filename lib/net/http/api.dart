import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

final wanApi = WanRestClient(Dio());

@RestApi(baseUrl: "https://www.wanandroid.com")
abstract class WanRestClient {
  factory WanRestClient(Dio dio, {String baseUrl}) = _WanRestClient;

  @GET("/tasks")
  Future<dynamic> getTasks();
}
