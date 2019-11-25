

import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 注册
class RegisteredService{
  /// 获取注册验证码
  Observable<BaseResponse> registeredPhone(String phone){
    var url = '/api/accounts/validate/mobile/$phone/unduplicated';
    var response = get(url);
    return response;
  }

  /// 注册
  /// *referer 推荐人
  Observable<BaseResponse> onRegistered(String vaildCode){
    var url = '/api/accounts/register?referer=admin&vcode=$vaildCode';
    var response = post(url);
    return response;
  }
}

class RegisteredRepo{
  final RegisteredService _remote = RegisteredService();

  Observable<BaseResponse> registeredPhone(String phone){
    return _remote.registeredPhone(phone);
  }

  Observable<BaseResponse> onRegistered(String vaildCode){
    return _remote.onRegistered(vaildCode);
  }
}