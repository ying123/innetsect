import 'package:json_annotation/json_annotation.dart';
part 'base.g.dart';

///基本响应数据
@JsonSerializable()
class BaseResponse<T> {
  int code;
  int total;
  int totalPage;
  dynamic data;
  String message;
  bool success;

  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic>json)=> _$BaseResponseFromJson(json);
  factory BaseResponse.fromlist(List json)=> _$BaseResponseFromList(json);

  static Map<String, dynamic> toJson(BaseResponse instance) => _$BaseResponseToJson(instance);
}
///常见的响应数据
@JsonSerializable()
class  CommonResponse {
  int code;
  dynamic data;
  String message;
  bool success;

  CommonResponse();


  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);

  static Map<String, dynamic> toJson(CommonResponse instance) => _$CommonResponseToJson(instance);
}