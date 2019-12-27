import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 商城首页请求
class DrawshopService {

  /// 添加抽签信息
  Observable<BaseResponse> draws ({dynamic resouce, int drawID}){
    var url = '/api/promotion/draws/1';
    var response = get(url);
    return response;
  }
  /// 添加抽签登记 
  Observable<BaseResponse> drawshop (dynamic resouce, int drawID){
    var url = '/api/promotion/draws/1/register';
    var response = post(url,body:resouce);
    return response;
  }
}

///添加抽签店铺 
class DrawshopRepo {
  final DrawshopService _remote = DrawshopService();
  ///抽签信息
  Observable<BaseResponse> draws({dynamic resouce , int drawID}){
    return _remote.draws();
  }
  ///抽签登记
  Observable<BaseResponse> drawshop(dynamic resouce , int drawID){
    return _remote.drawshop(resouce,drawID);
  }

}