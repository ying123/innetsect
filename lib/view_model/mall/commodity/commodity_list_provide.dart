
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';

/// 筛选商品列表
class CommodityListProvide extends BaseProvide{
  // 请求地址
  String _requestUrl;

  String get requestUrl =>_requestUrl;

  set requestUrl(String requestUrl){
    _requestUrl = requestUrl;
    notifyListeners();
  }

  List<CommodityModels> _list=[];

  List<CommodityModels> get list => _list;

  void addList(List<CommodityModels> list){
    _list.addAll(list);
    notifyListeners();
  }

  void clearList(){
    _list.clear();
    notifyListeners();
  }

  /// 工厂模式
  factory CommodityListProvide()=> _getInstance();
  static CommodityListProvide get instance => _getInstance();
  static CommodityListProvide _instance;
  static CommodityListProvide _getInstance(){
    if (_instance == null) {
      _instance = new CommodityListProvide._internal();
    }
    return _instance;
  }

  CommodityListProvide._internal() {
    print('MallProvode init');
  }
}