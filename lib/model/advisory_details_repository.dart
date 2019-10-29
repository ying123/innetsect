

import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

///资讯详情网络请求相关
class AdvisoryDetailsService {
  
  Observable<BaseResponse> loadadvisoryDetails(dynamic request){
    var url = '/api/society/contents/${request['contentID']}';
    var response = get(url);
    return response;
  }
}

///资讯详情网络数据响应
class AdvisoryDatailsRepo {
  final AdvisoryDetailsService _remote = AdvisoryDetailsService();

  Observable loadadvisoryDetails(dynamic request){
    return _remote.loadadvisoryDetails(request);
  }
}