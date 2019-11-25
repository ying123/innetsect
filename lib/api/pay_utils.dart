import 'package:tobias/tobias.dart' as tobias;
//import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';

class PayUtils{

  /// 支付宝支付
  Future<Map> aliPay(String orderInfo) async{
    Map result = new Map();
    try{
      Map map = await tobias.aliPay(orderInfo);
      map['memo'] = this.aliPayFormat(map['resultStatus']);
      result = map;
      /// * 9000	订单支付成功
      /// * 8000	正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
      /// * 4000	订单支付失败
      /// * 5000	重复请求
      /// * 6001	用户中途取消
      /// * 6002	网络连接出错
      /// * 6004	支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
      print(map);
    }catch(e){}
    return result;
  }

  /// 微信支付
  /// *[index==0] 支付成功
  /// *[index!=0] 支付失败
  Future<SyPayResult> weChatPay(dynamic data) async{
      SyPayResult payResult = await SyFlutterWechat.pay(
          SyPayInfo.fromJson(data));
      return payResult;
  }

  String aliPayFormat(String resultStatus){
    String str ;
    if(resultStatus == "9000"){
      str= "订单支付成功";
    }else if(resultStatus == "8000"){
      str= "正在处理中,请查询商户订单列表中订单的支付状态";
    }else if(resultStatus == "4000"){
      str= "订单支付失败";
    }else if(resultStatus == "5000"){
      str= "重复请求";
    }else if(resultStatus == "6001"){
      str= "用户中途取消";
    }else if(resultStatus == "6002"){
      str= "网络连接出错";
    }else if(resultStatus == "6004"){
      str= "支付结果未知,请查询商户订单列表中订单的支付状态";
    }
    return str;
  }

  /// 支付方式
  String payMode(int payMode){
    String str;
    switch(payMode){
      case 2:
        str="支付宝";
        break;
      case 1:
        str="微信";
        break;
    }
    return str;
  }

  /// 发货状态
  String deliverMode(int mode){
    String str="已发货";
    if(mode<3){
      str = "未发货";
    }
    return str;
  }
}