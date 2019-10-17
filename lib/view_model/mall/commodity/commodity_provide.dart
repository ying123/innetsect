
import 'package:innetsect/base/base.dart';

class CommodityProvode extends BaseProvide{

  /// 工厂模式
  factory CommodityProvode()=> _getInstance();
  static CommodityProvode get instance => _getInstance();
  static CommodityProvode _instance;
  static CommodityProvode _getInstance(){
    if (_instance == null) {
      _instance = new CommodityProvode._internal();
    }
    return _instance;
  }

  CommodityProvode._internal() {
    print('MallProvode init');
  }
}