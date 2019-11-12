import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/order/logistics_repository.dart';
import 'package:rxdart/rxdart.dart';

class LogisticsProvide extends BaseProvide{
  final LogisticsRepo _repo = LogisticsRepo();

  ///获取列表
  Observable getLogisticsList({int orderID,String shipperCode,String waybillNo,String phone}){
    return _repo.listData( orderID, shipperCode, waybillNo, phone).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}