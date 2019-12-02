import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

/// 我的中签
class LuckSignService{
  /// 列表
  Observable getSignList (){
    var url = '/api/eshop/draws/myTokens';
    var response = get(url);
    return response;
  }

  /// 详情
  Observable getDetail (int prodID){
    var url = '/api/eshop/47/products/panicBuyWithToken/$prodID';
    var response = get(url);
    return response;
  }
}


class  LuckSignRepo {
  final LuckSignService _remote = LuckSignService();
  Observable getSignList (){
    return _remote.getSignList();
  }
  Observable getDetail (int prodID){
    return _remote.getDetail(prodID);
  }
}