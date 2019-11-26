
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/registered_repository.dart';
import 'package:rxdart/rxdart.dart';

class RegisteredProvide extends BaseProvide{


  List placeHoderText = [
    '请输入账号',
    '请输入验证码',
  ];

  String _telPrefix="86";
  String get telPrefix => _telPrefix;
  set telPrefix(String telPrefix){
    _telPrefix = telPrefix;
    notifyListeners();
  }
  
 ///账号
  String _userCode = '';
  String get userCode => _userCode;
  set userCode(String userCode) {
    _userCode = userCode;
    _loginBtnCanClick();
  }

  /// 验证码
  String _vaildCode;
  get vaildCode => _vaildCode;
  set vaildCode(String vaild){
    _vaildCode = vaild;
    notifyListeners();
  }

  bool _isButtonEnable = true; //按钮状态 是否可点击
  get isButtonEnable{
    return _isButtonEnable;
  }

  set isButtonEnable(bool isButtonEnable){
    _isButtonEnable = isButtonEnable;
    notifyListeners();
  }

  //初始文本
  String _buttonText = '获取验证码';
  get buttonText{
    return _buttonText;
  }
  set buttonText(String buttonText){
    _buttonText = buttonText;
    notifyListeners();
  }
///初始化倒计时
  int _count = 60;
  get count{
    return _count;
  }
  set count(int count){
    _count = count;
    notifyListeners();
  }

///当前状态
  bool _checkSelected = false;
  get checkSelected{
    return _checkSelected;
  }

  set checkSelected(bool checkSelected){
    _checkSelected = checkSelected;
    notifyListeners();
  }

  final RegisteredRepo _repo = RegisteredRepo();

  /// 验证手机号是否注册过
  Observable registeredPhone() {
    return _repo.registeredPhone(_userCode)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 注册
  Observable onRegistered(String vaildCode,String telPrefix) {
    return _repo.onRegistered(vaildCode,telPrefix)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory RegisteredProvide()=> _getInstance();
  static RegisteredProvide get instance => _getInstance();
  static RegisteredProvide _instance;
  static RegisteredProvide _getInstance(){
    if (_instance == null) {
      _instance = new RegisteredProvide._internal();
    }
    return _instance;
  }

  RegisteredProvide._internal() {
    print('RegisteredProvide init');
    // 初始化
  }


_loginBtnCanClick(){

}

}