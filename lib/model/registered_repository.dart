

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
  Observable<BaseResponse> onRegistered(String vaildCode,String telPrefix,
      String mobile){
    var url = '/api/accounts/register?referer=&vcode=$vaildCode';
    var json={
      'telPrefix': telPrefix,
      'mobile':mobile,
      "acctType": 0,
      "credit": 0,
      "acctPwd": " ",
      "status": 0,
      "rank": 0,
      "acctID": 0,
      "channel":"android",
      "nickName":mobile
    };
    var response = post(url,body: json);
    return response;
  }
}

class RegisteredRepo{
  final RegisteredService _remote = RegisteredService();

  Observable<BaseResponse> registeredPhone(String phone){
    return _remote.registeredPhone(phone);
  }

  Observable<BaseResponse> onRegistered(String vaildCode,String telPrefix,String mobile){
    return _remote.onRegistered(vaildCode, telPrefix,mobile);
  }
}