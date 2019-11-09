import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/model/order/all_order_repository.dart';
import 'package:rxdart/rxdart.dart';

class  AllProvide  extends BaseProvide{

  List<OrderDetailModel> _orderDetailList=[];

  List<OrderDetailModel> get orderDetailList=>_orderDetailList;

  OrderDetailModel _orderDetailModel;

  OrderDetailModel get orderDetailModel => _orderDetailModel;

  void setOrderDetailModel(OrderDetailModel models){
    _orderDetailModel = models;
    notifyListeners();
  }

  void addOrderList(List<OrderDetailModel> list){
    _orderDetailList..addAll(list);
    notifyListeners();
  }

  final AllOrderRepo _repo = AllOrderRepo();

  ///获取订单全部列表
  Observable getOrderList({int pageNo,bool isReload = false}){
    if(isReload) _orderDetailList.clear();
    return _repo.listData(pageNo).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory AllProvide() => _getInstance();
  static AllProvide get instance => _getInstance();
  static AllProvide _instance;
  static AllProvide _getInstance() {
    if (_instance == null) {
      _instance = new AllProvide._internal();
    }
    return _instance;
  }
  AllProvide._internal() {
    print('AllProvide init');
    // 初始化
  }
}