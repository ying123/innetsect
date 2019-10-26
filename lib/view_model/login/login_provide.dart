import 'package:innetsect/base/base.dart';

class LoginProvide extends BaseProvide {
  List placeHoderText = [
    '手机号/邮箱/昵称',
    '密码',
  ];

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
}
