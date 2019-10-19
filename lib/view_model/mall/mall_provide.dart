
import 'package:innetsect/base/base.dart';

class MallProvode extends BaseProvide{

  /// 工厂模式
  factory MallProvode()=> _getInstance();
  static MallProvode get instance => _getInstance();
  static MallProvode _instance;
  static MallProvode _getInstance(){
    if (_instance == null) {
      _instance = new MallProvode._internal();
    }
    return _instance;
  }

  MallProvode._internal() {
    print('MallProvode init');
  }

  /// 底部选中索引
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int currentIndex){
    _currentIndex = currentIndex;
    notifyListeners();
  }
}