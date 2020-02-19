import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/order_detail_model.dart';


class OrderDetailProvide extends BaseProvide {



  String _prodName;
  String get prodName => _prodName;
  set prodName(String prodName){
    _prodName = prodName;
  }

  String _skuSpecs;
  String get skuSpecs => _skuSpecs;
  set skuSpecs(String skuSpecs){
    _skuSpecs = skuSpecs;
  }

  OrderDetailModel _orderDetailModel;
  String _pages;
  String get pages => _pages;
  set pages(String pages){
    _pages = pages;
    notifyListeners();
  }

  OrderDetailModel get orderDetailModel => _orderDetailModel;

  set orderDetailModel(OrderDetailModel model){
    _orderDetailModel = model;
    notifyListeners();
  }


  /// 修改收货地址
  void editAddress(AddressModel model){
    _orderDetailModel.addressModel = model;
    _orderDetailModel.addressID = model.addressID;
    notifyListeners();
  }

  ///工厂模式
  factory OrderDetailProvide() => _getInstance();
  static OrderDetailProvide get instance => _getInstance();
  static OrderDetailProvide _instance;
  static OrderDetailProvide _getInstance() {
    if (_instance == null) {
      _instance = new OrderDetailProvide._internal();
    }
    return _instance;
  }
  OrderDetailProvide._internal() {
    print('OrderDetailProvide初始化');
    // 初始化
  }

}