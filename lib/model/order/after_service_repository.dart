
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class AfterService{
  /// 售后申请列表
  Observable<BaseResponse> listData (String method){
    var response = get(method);
    return response;
  }

  /// 申请原因列表
  Observable<BaseResponse> rmareasonsListData(){
    var url = "/api/eshop/rmareasons";
    var response = get(url);
    return response;
  }

}

class AfterRepo {
  final AfterService _remote = AfterService();

  /// 售后申请列表
  Observable<BaseResponse> listData(String method){
    return _remote.listData(method);
  }

  /// 申请原因列表
  Observable<BaseResponse> rmareasonsListData(){
    return _remote.rmareasonsListData();
  }
}