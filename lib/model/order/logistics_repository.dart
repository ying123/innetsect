import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 物流
class LogisticsService{
  /// 列表
  Observable<BaseResponse> listData (int orderID,String shipperCode,String waybillNo,String phone){
    var url ="/api/boms/kuaidiInfo?orderID=$orderID&shipperCode=$shipperCode&waybillNo=$waybillNo&phone=$phone";
    var response = get(url);
    return response;
  }
}


/// 请求响应
class LogisticsRepo {
  final LogisticsService _remote = LogisticsService();

  /// banner请求
  Observable<BaseResponse> listData(int orderID,String shipperCode,String waybillNo,String phone){
    return _remote.listData( orderID, shipperCode, waybillNo, phone);
  }
}