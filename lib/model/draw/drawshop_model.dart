import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 商城首页请求
class DrawshopService {

  /// 添加抽签信息
  Observable<BaseResponse> draws ({dynamic resouce, int drawID}){
    print('drawID===============>$drawID');
    var url = '/api/promotion/draws/$drawID';
    var response = get(url);
    return response;
  }
  /// 销售订单
  Observable<BaseResponse> salesOrder ({int drawID}){
    print('drawID===============>$drawID');
    var url = '/api/eshop/salesorders/createDrawAwardOrder?drawID=178';
    var response = post(url);
    return response;
  }
  /// 抽签登记页
  Observable<BaseResponse> lotteryRegistrationPage ({num drawId,num shopID, double longitude,double latitude,String platform} ){
    var url = '/api/promotion/draws/$drawId/shops/$shopID?longitude=$longitude&latitude=$latitude&platform=$platform';
    print('url========>$url');
    var response = get(url);
    return response;
  }
  /// 查看我的抽签登记信息
  Observable<BaseResponse> viewRegistrationInformation ({num id,num shopId} ){
    var url = '/api/promotion/draws/$id/shops/$shopId/myRegistration';
    var response = get(url);
    return response;
  }

  /// 添加抽签登记 
  Observable<BaseResponse> drawshop (dynamic resouce, int drawID){
    var url = '/api/promotion/draws/$drawID/register';
    var response = post(url,body:resouce);
    return response;
  }
}

///添加抽签店铺 
class DrawshopRepo {
  final DrawshopService _remote = DrawshopService();
  ///抽签信息
  Observable<BaseResponse> draws({dynamic resouce , int drawID}){
    return _remote.draws(drawID:drawID);
  }
  ///抽签登记页面
  Observable<BaseResponse> lotteryRegistrationPage({num drawId,num shopID, double longitude,double latitude,String platform }){
    return _remote.lotteryRegistrationPage(drawId: drawId, shopID: shopID, longitude:longitude,latitude:latitude,platform:platform );
  }
  ///查看我的抽签登记信息
  Observable<BaseResponse> viewRegistrationInformation({num id,num shopId }){
    return _remote.viewRegistrationInformation( id:id,shopId:shopId);
  }
  ///抽签登记
  Observable<BaseResponse> drawshop(dynamic resouce , int drawID){
    return _remote.drawshop(resouce,drawID);
  }
  ///销售订单
  Observable<BaseResponse> salesOrder( int drawID){
    return _remote.salesOrder(drawID: drawID);
  }

}