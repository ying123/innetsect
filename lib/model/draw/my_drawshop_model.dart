import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 我的抽签
class MyDrawshopModelService {

  /// 我的抽签
  Observable<BaseResponse> myDraws ({int pageNo, int pageSize}){
    var url = '/api/promotion/draws/getAll?pageNo=$pageNo&pageSize=$pageSize';
    var response = get(url);
    return response;
  }
  
}

///我的抽签
class MyDrawshopModelRepo {
  final MyDrawshopModelService _remote = MyDrawshopModelService();
  ///我的抽签
  Observable<BaseResponse> myDraws({int pageNo , int pageSize}){
    return _remote.myDraws( pageNo: pageNo,pageSize:pageSize);
  }
 

}