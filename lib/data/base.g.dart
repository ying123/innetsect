part of 'base.dart';

///将json转换BaseResponse实例
BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) {
  return BaseResponse<T>()..data = json;
}

///将json转换BaseResponse实例
BaseResponse<T> _$BaseResponseFromList<T>(List json) {
  return BaseResponse<T>()..data = json;
}

///将基本响应数据转换成json
Map<String, dynamic> _$BaseResponseToJson<T>(BaseResponse<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

CommonResponse _$CommonResponseFromJson(Map<String, dynamic> json) {
  return CommonResponse()
    ..code = json['code'] as int
    ..data = json['data']
    ..message = json['message'] as String
    ..success = json['success'] as bool;
}

Map<String, dynamic> _$CommonResponseToJson(CommonResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
      'success': instance.success
    };
