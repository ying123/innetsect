import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class AddressService{
  /// 地址列表
  Observable<BaseResponse> listData (int pageNo){
    var url = '/api/eshop/addresses?pageNo=$pageNo';
    var response = get(url);
    return response;
  }
  /// 编辑
  Observable<BaseResponse> editData(AddressModel model){
    var url = '/api/eshop/addresses';
    var response = put(url,body: model.toJson());
    return response;
  }
  /// 获取国家
  Observable<BaseResponse> getCity (){
    var url = '/api/geo/countries';
    var response = getCountries(url);
    return response;
  }
}
///商城数据请求响应
class AddressRepo {
  final AddressService _remote = AddressService();

  /// 列表请求
  /// *[pageNo] page页
  Observable<BaseResponse> listData(int pageNo) {
    return _remote.listData(pageNo);
  }
  /// 编辑
  Observable<BaseResponse> editData(AddressModel model) {
    return _remote.editData(model);
  }
  /// 获取国家
  Observable<BaseResponse> getCity() {
    return _remote.getCity();
  }
}
