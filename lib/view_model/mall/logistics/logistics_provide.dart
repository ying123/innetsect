import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/order/logistics_repository.dart';
import 'package:rxdart/rxdart.dart';

class LogisticsProvide extends BaseProvide{

  /// 返回页面
  String _backPage;

  String get backPage => _backPage;

  set backPage(String backPage){
    _backPage = backPage;
    notifyListeners();
  }

  final LogisticsRepo _repo = LogisticsRepo();

  ///获取列表
  Observable getLogisticsList({int orderID,String shipperCode,String waybillNo,String phone}){
    return _repo.listData( orderID, shipperCode, waybillNo, phone).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory LogisticsProvide() => _getInstance();
  static LogisticsProvide get instance => _getInstance();
  static LogisticsProvide _instance;
  static LogisticsProvide _getInstance() {
    if (_instance == null) {
      _instance = new LogisticsProvide._internal();
    }
    return _instance;
  }
  LogisticsProvide._internal() {
    print('LogisticsProvide初始化');
    // 初始化
  }
}