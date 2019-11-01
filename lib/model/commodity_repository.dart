import 'package:flutter/material.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:rxdart/rxdart.dart';

/// 商城服务请求
class CommodityService {

  /// 列表数据请求
  Observable<BaseResponse> homeListData (int pageNo,String types){
    var url = '/api/eshop/app/products/hotest?pageNo=$pageNo';
    if(types=="newCom"){
      url = '/api/eshop/app/products/latest?pageNo=$pageNo';
    }
    var response = get(url);
    return response;
  }

  /// 详情请求
  Observable<BaseResponse> detailData(int types,int prodId){
    var url = '/api/eshop/$types/products/$prodId';
    var response = get(url);
    return response;
  }

  /// 立即下单
  Observable<BaseResponse> createShopping(CommodityModels models,
      CommoditySkusModel skuModel,int counts,BuildContext context){
    var url = '/api/eshop/salesorders/shoppingorder/create';
    List json = [{
      "acctID": UserTools().getUserData()['id'],
      "shopID":models.shopID,
      "prodID":models.prodID,
      "presale":models.presale,
      "skuCode":skuModel.skuCode,
      "skuName":skuModel.skuName,
      "skuPic":skuModel.skuPic,
      "quantity":counts,
      "unit": models.unit,
//      "salesPrice":skuModel.salesPrice,
      "salesPrice":0.01,
      "allowPointRate":models.allowPointRate
//      discountPrice
//      discountDesc
//      promotionID
//      remark
    }];
    print(json);
    var response = post(url,body: json,context: context);
    return response;
  }

  /// 提交订单
  Observable<BaseResponse> submitShopping(){
    var url = '/api/eshop/salesorders/submit?addrID=138373&channel=Android';
    var response = post(url);
    return response;
  }

  /// 订单支付
  Observable<BaseResponse> payShopping(int orderId,int payTypes){
    var url = '/api/eshop/pay/$orderId?billMode=$payTypes&clientType=3';
    var response = post(url);
    return response;
  }
}




///商城数据请求响应
class CommodityRepo {
  final CommodityService _remote = CommodityService();

  /// 列表请求
  /// *[pageNo] page页
  /// *[types] 热门(hotCom)，新品类型(newCom)
  Observable<BaseResponse> homeListData(int pageNo,String types){
    return _remote.homeListData(pageNo,types);
  }

  /// 详情请求
  /// *[types] 37：商城，47：展会
  /// *[prodId] 商品id
  Observable<BaseResponse> detailData(int types,int prodId){
    return _remote.detailData(types,prodId);
  }

  /// 立即下单
  Observable<BaseResponse> createShopping(CommodityModels models,
      CommoditySkusModel skuModel,int counts,BuildContext context){
    return _remote.createShopping(models,skuModel,counts,context);
  }

  /// 提交订单
  Observable<BaseResponse> submitShopping(){
    return _remote.submitShopping();
  }

  /// 订单支付
  Observable<BaseResponse> payShopping(int orderId,int payTypes){
    return _remote.payShopping(orderId,payTypes);
  }
}