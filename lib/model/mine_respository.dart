

import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

///网络请求相关
class  MineService {
  ///登录
  Observable<BaseResponse> login(dynamic request){
    var url = '/Services/OAuth/Authorize?tenantId=${request['tenantId']}&userCode=${request['userCode']}&password=${request['passWord']}';
    var response = get(url, params: request);
    return response;
  }

  Observable<BaseResponse> getWarehouseLiset(){
    var url = '/services/Warehouses';
    var response = get(url);
    return response;
  }




}


class MineRepo{

  final MineService _remote = MineService();

  Observable<BaseResponse> login(dynamic request){
    return _remote.login(request);
  }

  Observable<BaseResponse> getWarehouseLiset(){
    return _remote.getWarehouseLiset();
  }
}