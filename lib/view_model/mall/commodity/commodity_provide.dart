
import 'package:innetsect/base/base.dart';

class CommodityProvide extends BaseProvide{

  List _list = [
    {
      "id":1,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":2,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":3,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":4,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":5,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":6,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":7,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
    {
      "id":8,
      "image": "assets/images/Logoy.png",
      "describe": "描述描述描述描述描述描述描述",
      "Price": 1000.00
    },
  ];

  get list => _list;

  /// 工厂模式
//  factory CommodityProvide()=> _getInstance();
//  static CommodityProvide get instance => _getInstance();
//  static CommodityProvide _instance;
//  static CommodityProvide _getInstance(){
//    if (_instance == null) {
//      _instance = new CommodityProvide._internal();
//    }
//    return _instance;
//  }
//
//  CommodityProvide._internal() {
//    print('MallProvode init');
//  }
}