import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 订单列表全部请求
class AllOrderService {

  /// 全部列表
  Observable<BaseResponse> listData (int pageNo){
    var url = '/api/eshop/salesorders/list?pageNo=$pageNo&pageSize=8';
    var response = get(url);
    return response;
  }
}

/// 订单列表请求响应
class AllOrderRepo {
  final AllOrderService _remote = AllOrderService();

  /// banner请求
  Observable<BaseResponse> listData(int pageNo){
    return _remote.listData(pageNo);
  }
}