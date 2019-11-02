import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 商城首页请求
class MallHomeService {

  /// 首页banner
  Observable<BaseResponse> bannerData (){
    var url = '/api/society/portals/home';
    var response = get(url);
    return response;
  }
}




///商城首页请求响应
class MallHomeRepo {
  final MallHomeService _remote = MallHomeService();

  /// banner请求
  Observable<BaseResponse> bannerData(){
    return _remote.bannerData();
  }
}