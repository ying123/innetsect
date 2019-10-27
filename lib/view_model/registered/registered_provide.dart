
import 'package:innetsect/base/base.dart';

class RegisteredProvide extends BaseProvide{


  List placeHoderText = [
    '请输入账号',
    '请输入验证码',
  ];
  
 ///账号
  String _userCode = '';
  String get userCode => _userCode;
  set userCode(String userCode) {
    _userCode = userCode;
    _loginBtnCanClick();
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



_loginBtnCanClick(){

}

}