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
  Observable<BaseResponse> getCountriess (){
    var url = '/api/geo/countries';
    var response = getCountries(url);
    return response;
  }
  /// 获取省
  Observable<BaseResponse> getProvices (String code){
    var url = '/api/geo/provinces?countryCode=$code';
    var response = getCountries(url);
    return response;
  }
  /// 获取市
  Observable<BaseResponse> getCitys (String countryCode,String parentCode){
    var url = '/api/geo/subregions?countryCode=$countryCode&parentCode=$parentCode';
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
  Observable<BaseResponse> getCountriess() {
    return _remote.getCountriess();
  }
  /// 获取省
  Observable<BaseResponse> getProvices (String code){
    return _remote.getProvices(code);
  }
  /// 获取市
  Observable<BaseResponse> getCitys (String countryCode,String parentCode){
    return _remote.getCitys(countryCode,parentCode);
  }
}
