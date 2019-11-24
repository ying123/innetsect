
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class AfterService{
  /// 售后申请列表
  Observable<BaseResponse> listData (String method){
    var response = get(method);
    return response;
  }

  /// 申请原因列表
  Observable<BaseResponse> rmareasonsListData(){
    var url = "/api/eshop/rmareasons";
    var response = get(url);
    return response;
  }

  /// 提交售后
  Observable<BaseResponse> submitSalesRma(Map<String,dynamic> json){
    var url = '/api/eshop/salesrma';
    var response = post(url,body: json);
    return response;
  }

  /// 取消售后
  Future cancelAfterOrder (int rmaID){
    var url = '/api/eshop/salesrma/cancel/$rmaID';
    return patch(url);
  }

  /// 售后详情
  Observable<BaseResponse> getAfterDetail(int rmaID){
    var url = '/api/eshop/salesrma/$rmaID/detail';
    var response = get(url);
    return response;
  }

  ///提交物流
  ///*[rmaID]售后订单ID
  ///*[waybillNo]物流单号
  ///*[shipperCode]物流公司code
  ///*[reasonType]原因类型
  Observable<BaseResponse> submitLogistic({
    int rmaID,
    String waybillNo,
    String shipperCode,
    int reasonType
  }){
    var url = '/api/eshop/salesrma/$rmaID/logistics';
    var json = {
      "waybillNo":waybillNo,
      "shipperCode":shipperCode,
      "$reasonType":reasonType
    };
    var response = put(url,body: json);
    return response;
  }

  /// 物流公司请求
  Observable<BaseResponse> getShipperData(){
    var url = '/api/eshop/shippers';
    var response = get(url);
    return response;
  }

  /// 退换货物流
  /// 根据退换货物流状态，<3显示退货物流，>=3显示换货物流
  ///  syncStatus<3传1， >=3传2;
  ///  *[phone]取 extel
  Observable<BaseResponse> getShipperDetail({
    int rmaID, int syncStatus,
    String shipperCode,String waybillNo,
    String phone
  }){
    var url = '/api/boms/$rmaID/$syncStatus/rmaKuaidiInfo?shipperCode=$shipperCode'
        '&waybillNo=$waybillNo&phone=$phone';
    var response = get(url);
    return response;
  }
}

class AfterRepo {
  final AfterService _remote = AfterService();

  /// 售后申请列表
  Observable<BaseResponse> listData(String method){
    return _remote.listData(method);
  }

  /// 申请原因列表
  Observable<BaseResponse> rmareasonsListData(){
    return _remote.rmareasonsListData();
  }

  /// 提交售后
  Observable<BaseResponse> submitSalesRma(Map<String,dynamic> json){
    return _remote.submitSalesRma(json);
  }

  /// 取消售后
  Future cancelAfterOrder (int rmaID){
    return _remote.cancelAfterOrder(rmaID);
  }

  /// 售后详情
  Observable<BaseResponse> getAfterDetail(int rmaID){
    return _remote.getAfterDetail(rmaID);
  }

  ///提交物流
  ///*[rmaID]售后订单ID
  ///*[waybillNo]物流单号
  ///*[shipperCode]物流公司code
  ///*[reasonType]原因类型
  Observable<BaseResponse> submitLogistic({
    int rmaID,
    String waybillNo,
    String shipperCode,
    int reasonType
  }){
    return _remote.submitLogistic(rmaID: rmaID,waybillNo: waybillNo,shipperCode: shipperCode,reasonType: reasonType);
  }

  /// 物流公司请求
  Observable<BaseResponse> getShipperData(){
    return _remote.getShipperData();
  }

  /// 退换货物流
  /// 根据退换货物流状态，<3显示退货物流，>=3显示换货物流
  ///  syncStatus<3传1， >=3传2;
  ///  *[phone]取 extel
  Observable<BaseResponse> getShipperDetail({
    int rmaID, int syncStatus,
    String shipperCode,String waybillNo,
    String phone
  }){
    return _remote.getShipperDetail(
      rmaID: rmaID,syncStatus: syncStatus,
      shipperCode: shipperCode,waybillNo: waybillNo,
      phone: phone
    );
  }

}