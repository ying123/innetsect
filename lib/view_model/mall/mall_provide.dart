
import 'package:innetsect/base/base.dart';

class MallProvide extends BaseProvide{

  /// 工厂模式
  factory MallProvide()=> _getInstance();
  static MallProvide get instance => _getInstance();
  static MallProvide _instance;
  static MallProvide _getInstance(){
    if (_instance == null) {
      _instance = new MallProvide._internal();
    }
    return _instance;
  }

  MallProvide._internal() {
    print('MallProvide init');
  }

  /// 底部选中索引
  int _currentIndex = 2;
  int get currentIndex => _currentIndex;
  set currentIndex(int currentIndex){
    _currentIndex = currentIndex;
    notifyListeners();
  }
}