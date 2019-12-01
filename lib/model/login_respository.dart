import 'package:flutter/material.dart';
import 'package:innetsect/api/http_util.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:rxdart/rxdart.dart';

/// 登录服务请求
class LoginService {
  /// 登录请求
  Observable<BaseResponse> LoginData (String userName,String pwd){
    UserTools().clearUserInfo();
    var url = '/api/oauth/token?grant_type=password&username=$userName&password=$pwd'
        '&scope=read write&client_id=innersect&client_secret=888888';
    var response = post(url);
    return response;
  }

  /// 邮箱验证
  Observable<BaseResponse> validEmail(String email){
    var url = '/api/accounts/validate/email/$email/unduplicated';
    var response = get(url);
    return response;
  }

  /// 邮箱获取验证码
  Future getEmailValidCode (String email){
    var url = '/api/emails/vcode?email=$email';
    return HttpUtil().dio.post(url);
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
    return patch(url);
  }

  /// 验证手机号
  Observable<BaseResponse> getVaildPhone(String phone){
    var url = '/api/accounts/validate/mobile/$phone/unduplicated';
    var response = get(url);
    return response;
  }

  /// 修改手机号
  Future editPhone(String phone,String code){
    var url = '/api/accounts/change/mymobile?newMobile=$phone&vcode=$code';
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
  
  /// 修改邮箱
  Future editEmail(String email,String code){
    var url = '/api/accounts/change/myemail?newEmail=$email&vcode=$code';
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

  /// 邮箱获取验证码
  Future getEmailValidCode (String email){
    return _remote.getEmailValidCode(email);
  }

  /// 邮箱验证
  Observable<BaseResponse> validEmail(String email){
    return _remote.validEmail(email);
  }

  /// 修改邮箱
  Future editEmail(String email,String code){
    return _remote.editEmail(email, code);
  }

  /// 验证手机号
  Observable<BaseResponse> getVaildPhone(String phone){
    return _remote.getVaildPhone(phone);
  }

  /// 修改手机号
  Future editPhone(String phone,String code){
    return _remote.editPhone(phone, code);
  }
  
}