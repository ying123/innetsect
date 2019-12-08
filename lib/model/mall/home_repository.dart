import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 商城首页请求
class MallHomeService {

  /// 首页banner
  Observable<BaseResponse> bannerData ({BuildContext context}){
    var url = '/api/society/portals/home';
    var response = get(url,context: context);
    return response;
  }

  /// 首页列表
  Observable<BaseResponse> listData (int pageNo,{BuildContext context}){
    var url = '/api/society/portals/home/portlets?pageNo=$pageNo';
    var response = get(url,context: context);
    return response;
  }
}

///商城首页请求响应
class MallHomeRepo {
  final MallHomeService _remote = MallHomeService();

  /// banner请求
  Observable<BaseResponse> bannerData({BuildContext context}){
    return _remote.bannerData(context:context);
  }

  /// list请求
  Observable<BaseResponse> listData(int pageNo,{BuildContext context}){
    return _remote.listData(pageNo,context:context);
  }
}