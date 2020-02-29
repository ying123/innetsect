import 'package:flutter/cupertino.dart';
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 商城优惠卷
class CouponsService {

  /// 未使用优惠卷
  Observable<BaseResponse> dontUseCouPons (String type, {int pageNo}){
    var url = '/api/promotion/coupons/$type?pageNo=$pageNo';
    var response = get(url);
    return response;
  }

  ///商品优惠卷列表
  Observable<BaseResponse> listOfCoupons ({int prodid}){
    var url = '/api/promotion/couponSets/$prodid/cs';
    var response = get(url);
    return response;
  }
  ///根据ID领取优惠卷
  Observable<BaseResponse> couponByID ({int csID, dynamic body }){
    var url = '/api/promotion/couponSets/take/$csID';
    var response = post(url,body: body);
    return response;
  }
 
}

/// 未使用优惠卷
class CouponsRepo {
  final CouponsService _remote = CouponsService();
  ///未使用的优惠卷
  Observable<BaseResponse> dontUseCouPons(String type,{int pageNo}){
    return _remote.dontUseCouPons(type ,pageNo: pageNo);
  }
  //商品优惠卷列表
  Observable<BaseResponse> listOfCoupons({int prodid}){
    return _remote.listOfCoupons(prodid: prodid);
  }
  //根据ID领取优惠卷
  Observable<BaseResponse> couponByID({int csID, dynamic body}){
    return _remote.couponByID(csID: csID, body: body);
  }


}