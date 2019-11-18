import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/order/after_service_repository.dart';
import 'package:rxdart/rxdart.dart';

/// 我的售后
class AfterServiceProvide extends BaseProvide{

  // list 数据
  List _list = new List();
  List get list => _list;

  void setList(List list){
    _list.addAll(list);
    notifyListeners();
  }

  void clearList(){
    _list.clear();
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