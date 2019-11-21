import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/login_respository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:innetsect/data/user_info_model.dart';

class LoginProvide extends BaseProvide {
  List placeHoderText = [
    '手机号/邮箱/昵称',
    '密码',
  ];

  List placePhoneText = [
    '手机号',
    '验证码'
  ];

  ///用户信息
  UserInfoModel _userInfoModel;
  get userInfoModel => _userInfoModel;
  void setUserInfoModel(UserInfoModel userInfoModel){
    _userInfoModel = userInfoModel;
    notifyListeners();
  }

  void clearUserInfoModel(){
    _userInfoModel = null;
    notifyListeners();
  }

  String _loginImage;
  get loginImage {
    if (_loginImage == null) {
      _loginImage = 'assets/images/yan_logo.png';
    }
    return _loginImage;
  }

  set loginImage(String image) {
    _loginImage = image;
    notifyListeners();
  }

  /// 验证码
  String _vaildCode = "";
  get vaildCode => _vaildCode;
  set vaildCode(String vaild){
    _vaildCode = vaild;
    notifyListeners();
  }

  ///密码是否可见
  bool _passwordVisiable = true;
  bool get passwordVisiable => _passwordVisiable;
  set passwordVisiable(bool passwordVisiable) {
    _passwordVisiable = passwordVisiable;
    notifyListeners();
  }

  ///账号
  String _userCode = '';
  String get userCode => _userCode;
  set userCode(String userCode) {
    _userCode = userCode;
    _loginBtnCanClick();
  }

  ///密码
  String _password = '';
  String get password => _password;
  set password(String password) {
    _password = password;
    _loginBtnCanClick();
  }

  _loginBtnCanClick() {
    
    notifyListeners();
  }

  ///工厂模式
  factory LoginProvide()=> _getInstance();
  static LoginProvide get instance => _getInstance();
  static LoginProvide _instance;
  static LoginProvide _getInstance(){
    if (_instance == null) {
      _instance = new LoginProvide._internal();
    }
    return _instance;
  }

  LoginProvide._internal() {
    print('MainProvide初始化');
    // 初始化
  }

  final LoginRepo _repo = LoginRepo();

  /// 详情数据
  Observable loginData() {
    return _repo.loginData(_userCode, _password)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 用户数据
  Observable getUserInfo({BuildContext context}) {
    return _repo.getUserInfo(context:context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  
  /// 获取验证码
  Future getVaildCode() {
    return _repo.getVaildCode(_userCode);
  }

  /// 修改密码
  Future editLogingPwd(String pwd){
    return _repo.editPwdSetting(pwd);
  }
}
