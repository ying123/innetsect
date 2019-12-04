import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 订单列表全部请求
class AllOrderService {

  /// 全部列表
  Observable<BaseResponse> listData (String method){
    var response = get(method);
    return response;
  }

  /// 取消订单
  Future cancelOrder (int orderID){
    var url = '/api/eshop/salesorders/cancel/$orderID';
    return patch(url);
  }

  /// 删除订单
  Future delOrder(int orderID){
    var url = '/api/eshop/salesorders/$orderID';
    return delete(url);
  }

  /// 提货码
  Observable<BaseResponse> ladingQrCode (int orderID){
    String url = "/api/eshop/salesorders/$orderID/ladingQrCode";
    var response = get(url);
    return response;
  }

}

/// 订单列表请求响应
class AllOrderRepo {
  final AllOrderService _remote = AllOrderService();

  /// banner请求
  Observable<BaseResponse> listData(String method){
    return _remote.listData(method);
  }

  /// 取消订单
  Future cancelOrder(int orderID){
    return _remote.cancelOrder(orderID);
  }

  /// 删除订单
  Future delOrder(int orderID){
    return _remote.delOrder(orderID);
  }

  /// 提货码
  Observable<BaseResponse> ladingQrCode (int orderID){
    return _remote.ladingQrCode(orderID);
  }
}