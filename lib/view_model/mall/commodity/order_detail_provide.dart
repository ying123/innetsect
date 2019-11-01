import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order_detail_model.dart';


class OrderDetailProvide extends BaseProvide {

  OrderDetailModel _orderDetailModel;

  get orderDetailModel => _orderDetailModel;

  set orderDetailModel(OrderDetailModel model){
    _orderDetailModel = model;
    notifyListeners();
  }

}