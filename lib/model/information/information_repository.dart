import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 资讯请求
class InformationService {

  /// 列表
  Observable<BaseResponse> listData (int pageNo){
    var url = '/api/society/contents/info/latest?pageNo=$pageNo&pageSize=8';
    var response = get(url);
    return response;
  }

  /// 详情
  Future getDetail (int contentID){
    var url = '/api/society/contents/$contentID/detailPage';
    return getHtml(url);
  }
}

///请求响应
class InformationRepo {
  final InformationService _remote = InformationService();

  /// list请求
  Observable<BaseResponse> listData(int pageNo){
    return _remote.listData(pageNo);
  }

  /// 详情
  Future getDetail(int contentID){
    return _remote.getDetail(contentID);
  }
}