
import 'package:innetsect/base/base.dart';

class ListProvide extends BaseProvide{

  /// 工厂模式
  factory ListProvide()=> _getInstance();
  static ListProvide get instance => _getInstance();
  static ListProvide _instance;
  static ListProvide _getInstance(){
    if (_instance == null) {
      _instance = new ListProvide._internal();
    }
    return _instance;
  }

  ListProvide._internal() {
    print('MallProvode init');
  }
}