import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 搜索
class SearchService {

  /// 标签请求
  Observable<BaseResponse> onRecommendedTags ({BuildContext context}){
    var url = '/api/eshop/app/products/words/hotest';
    var response = get(url,context: context);
    return response;
  }

  /// 搜索
  Observable<BaseResponse> onSearch (String url,{BuildContext context}){
    var response = get(url,context: context);
    return response;
  }
}

///搜索
class SearchRepo {
  final SearchService _remote = SearchService();

  /// 标签请求
  Observable<BaseResponse> onRecommendedTags({BuildContext context}){
    return _remote.onRecommendedTags(context: context);
  }

  /// 搜索
  Observable<BaseResponse> onSearch (String url,{BuildContext context}){
    return _remote.onSearch(url,context:context);
  }
}