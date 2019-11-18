
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class AfterService{
  Observable<BaseResponse> listData (String method){
    var response = get(method);
    return response;
  }
}

class AfterRepo {
  final AfterService _remote = AfterService();

  /// 列表请求
  Observable<BaseResponse> listData(String method){
    return _remote.listData(method);
  }
}