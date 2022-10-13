import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CommonResponse<T> {
  T data;
  String errorMsg;
  int errorCode;

  CommonResponse(
    this.data,
    this.errorMsg,
    this.errorCode,
  );

  factory CommonResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return _$CommonResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$CommonResponseToJson<T>(this, toJsonT);
  }
}

@JsonSerializable(genericArgumentFactories: true)
class PageResponse<T> {
  int curPage;
  List<T> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  PageResponse(
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  );

  factory PageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return _$PageResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$PageResponseToJson<T>(this, toJsonT);
  }
}