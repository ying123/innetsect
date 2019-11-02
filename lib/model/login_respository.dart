import 'package:flutter/material.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 登录服务请求
class LoginService {
  /// 登录请求
  Observable<BaseResponse> LoginData (String userName,String pwd){
    var url = '/api/oauth/token?grant_type=password&username=$userName&password=$pwd&scope=read write&client_id=innersect&client_secret=888888';
    var response = post(url);
    return response;
  }

  /// 个人信息
  Observable<BaseResponse> getUserInfo({BuildContext context}){
    var url = '/api/accounts/me';
    var response = get(url,context: context);
    return response;
  }

  /// 获取验证码
  Observable<BaseResponse> getVaildCode(String phone){
    var url = '/sms/vcode/$phone';
    var response = patch(url);
    return response;
  }
}


/// 登录数据请求响应
class LoginRepo {
  final LoginService _remote = LoginService();

  /// 登录请求
  Observable<BaseResponse> loginData(String userName,String pwd){
    return _remote.LoginData(userName,pwd);
  }

  /// 个人信息
  Observable<BaseResponse> getUserInfo({BuildContext context}){
    return _remote.getUserInfo(context: context);
  }

  /// 获取验证码
  Observable<BaseResponse> getVaildCode(String phone){
    return _remote.getVaildCode(phone);
  }
}