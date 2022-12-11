import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CommonResponse<T> extends Object {
  T data;
  String errorMsg;
  int errorCode;

  CommonResponse({
    required this.data,
    this.errorMsg = "",
    this.errorCode = 0,
  });

  factory CommonResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return _$CommonResponseFromJson<T>(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return _$CommonResponseToJson<T>(this, toJsonT);
  }

  @override
  String toString() {
    return {
      "data": data.toString(),
      "errorMsg": errorMsg,
      "errorCode": errorCode,
    }.toString();
  }
}

@JsonSerializable(genericArgumentFactories: true)
class PageResponse<T> {
  @JsonKey(defaultValue: [])
  List<T> datas;

  int curPage;
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

extension CommonResponseStreamExt<T> on Stream<CommonResponse<T>> {
  Stream<T> data() {
    return this.map((commonResponse) {
      if (commonResponse.errorCode != 0) {
        throw commonResponse;
      }

      return commonResponse.data;
    });
  }
}
