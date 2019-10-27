
import 'package:innetsect/base/base.dart';

class SearchProvide extends BaseProvide{

  /// 工厂模式
  factory SearchProvide()=> _getInstance();
  static SearchProvide get instance => _getInstance();
  static SearchProvide _instance;
  static SearchProvide _getInstance(){
    if (_instance == null) {
      _instance = new SearchProvide._internal();
    }
    return _instance;
  }

  SearchProvide._internal() {
    print('MallProvode init');
  }
}