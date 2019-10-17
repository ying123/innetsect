
import 'package:innetsect/base/base.dart';

class AppNavigationBarProvide extends BaseProvide{


  ///工厂模式
  factory AppNavigationBarProvide()=> _getInstance();
  static AppNavigationBarProvide get instance => _getInstance();
  static AppNavigationBarProvide _instance;
  static AppNavigationBarProvide _getInstance(){
    if (_instance == null) {
      _instance = new AppNavigationBarProvide._internal();
    }
    return _instance;
  }

  AppNavigationBarProvide._internal() {
    print('MainProvide初始化');
    // 初始化
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int currentIndex){
    _currentIndex = currentIndex;
    notify();
  }
///[notifyListeners]通知听众刷新
  notify(){
    notifyListeners();
  }

}