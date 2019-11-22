import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 搜索
class SearchService {

  /// 标签请求
  Observable<BaseResponse> onRecommendedTags (){
    var url = '/api/eshop/products/recommended/tags';
    var response = get(url);
    return response;
  }

}

///搜索
class SearchRepo {
  final SearchService _remote = SearchService();

  /// 标签请求
  Observable<BaseResponse> onRecommendedTags(){
    return _remote.onRecommendedTags();
  }

}