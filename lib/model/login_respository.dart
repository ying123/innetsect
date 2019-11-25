import 'package:flutter/material.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:rxdart/rxdart.dart';

/// 登录服务请求
class LoginService {
  /// 登录请求
  Observable<BaseResponse> LoginData (String userName,String pwd){
    UserTools().clearUserInfo();
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
  Future getVaildCode(String phone){
    var url = '/api/sms/vcode/$phone';
    var response = patch(url);
    return response;
  }

  /// 修改密码
  Future editPwdSetting(String pwd){
    var url = '/api/accounts/change/mypwd?newPwd=$pwd';
    var response = patch(url);
    return response;
  }

  /// 修改昵称
  Future editUserNick(String nickName){
    var url = '/api/accounts/change/mynickname?newNickName=$nickName';
    var response = patch(url);
    return response;
  }

  /// 验证修改昵称
  Observable<BaseResponse> getVaildNick(String nickName){
    var url = '/api/accounts/validate/nickname/$nickName/unduplicated';
    var response = get(url);
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
  Future getVaildCode(String phone){
    return _remote.getVaildCode(phone);
  }

  /// 修改密码
  Future editPwdSetting(String pwd){
    return _remote.editPwdSetting(pwd);
  }

  /// 修改昵称
  Future editUserNick(String userNick){
    return _remote.editUserNick(userNick);
  }

  /// 验证昵称
  Observable<BaseResponse> getVaildNick(String nickName){
    return _remote.getVaildNick(nickName);
  }
}