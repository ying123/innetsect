import 'package:innetsect/base/base.dart';

class ProfileProvide extends BaseProvide{
  ///工厂模式
  factory ProfileProvide() => _getInstance();
  static ProfileProvide get instance => _getInstance();
  static ProfileProvide _instance;
  static ProfileProvide _getInstance() {
    if (_instance == null) {
      _instance = new ProfileProvide._internal();
    }
    return _instance;
  }
  ProfileProvide._internal() {
    print('ProfileProvide init');
    // 初始化
  }
}