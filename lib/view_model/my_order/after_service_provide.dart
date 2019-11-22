import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/model/order/after_service_repository.dart';
import 'package:rxdart/rxdart.dart';

/// 我的售后
class AfterServiceProvide extends BaseProvide{

  // list 数据
  List _list = new List();
  // 商品model
  CommodityModels _commodityModels;
  // 计数器数字
  int _count;

  List get list => _list;

  CommodityModels get commodityModels=>_commodityModels;

  int get count =>_count;
  set count(int count){
    _count = count;
    notifyListeners();
  }

  //设置商品model
  set commodityModels(CommodityModels models){
    _commodityModels = models;
    notifyListeners();
  }

  void setList(List list){
    _list.addAll(list);
    notifyListeners();
  }

  void clearList(){
    _list.clear();
    notifyListeners();
  }

  // 减少
  void reduce(){
    if(_count<=1){
      return;
    }else{
      _count --;
    }
    notifyListeners();
  }

  // 添加
  void addCount(){
    if(_count == _commodityModels.quantity){
      return;
    }else{
      _count ++;
    }
    notifyListeners();
  }

  final AfterRepo _repo = AfterRepo();

  ///获取订单全部列表
  Observable listData({String method}){
    return _repo.listData(method).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 申请原因列表
  Observable rmareasonsListData(){
    return _repo.rmareasonsListData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory AfterServiceProvide() => _getInstance();
  static AfterServiceProvide get instance => _getInstance();
  static AfterServiceProvide _instance;
  static AfterServiceProvide _getInstance() {
    if (_instance == null) {
      _instance = new AfterServiceProvide._internal();
    }
    return _instance;
  }
  AfterServiceProvide._internal() {
    print('AfterServiceProvide init');
    // 初始化
  }
}