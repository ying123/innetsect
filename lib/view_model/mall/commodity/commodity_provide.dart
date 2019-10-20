
import 'package:innetsect/base/base.dart';

class CommodityProvide extends BaseProvide{

  List list = [
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
    {
      "image": "assets/images/Logoy.png",
      "describe": "2018年12月07-09日 国际文化体验 限售预览票",
      "Price": "328",
      'title': "SO"
    },
  ];

  /// 工厂模式
  factory CommodityProvide()=> _getInstance();
  static CommodityProvide get instance => _getInstance();
  static CommodityProvide _instance;
  static CommodityProvide _getInstance(){
    if (_instance == null) {
      _instance = new CommodityProvide._internal();
    }
    return _instance;
  }

  CommodityProvide._internal() {
    print('MallProvode init');
  }
}