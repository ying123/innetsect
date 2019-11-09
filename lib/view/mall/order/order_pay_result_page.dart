import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:provide/provide.dart';

class OrderPayResultPage extends PageProvideNode{
  
  final CommodityDetailProvide _provide = CommodityDetailProvide.instance;
  final OrderDetailProvide _detailProvide = OrderDetailProvide.instance;

  OrderPayResultPage(){
    mProviders.provide(Provider<CommodityDetailProvide>.value(_provide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_detailProvide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderPayResultContent(_provide,_detailProvide);
  }
}

class OrderPayResultContent extends StatefulWidget {
  final CommodityDetailProvide _provide;
  final OrderDetailProvide _detailProvide;
  OrderPayResultContent(this._provide,this._detailProvide);
  
  @override
  _OrderPayResultContentState createState() => _OrderPayResultContentState();
}

class _OrderPayResultContentState extends State<OrderPayResultContent> {

  CommodityDetailProvide _provide;
  OrderDetailProvide _detailProvide;
  
  @override
  Widget build(BuildContext context) {
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context,Widget widget, CommodityDetailProvide provide){
        return Container(
          color: Colors.white,
          width: double.infinity,
          height: ScreenAdapter.getScreenHeight(),
          padding: EdgeInsets.only(top: 140),
          alignment: Alignment.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image.asset(provide.resultStatus?"assets/images/mall/pay_success.png":"assets/images/mall/pay_fail.png",
                width: ScreenAdapter.width(240),),
              new Padding(
                padding: EdgeInsets.only(top: 10),
                child: new Text(provide.resultStatus?"支付成功":"支付失败",style: TextStyle(decoration: TextDecoration.none,fontSize: ScreenAdapter.size(32)),),
              ),
              new Container(
                padding: EdgeInsets.only(top: 10,left: 20,right: 20),
                width: double.infinity,
                child: new RaisedButton(
                  textColor: AppConfig.fontBackColor,
                  color: AppConfig.primaryColor,
                  onPressed: (){
                    // 查看详情
                    this.orderDetailRoute(context,provide);
                  },
                  child: new Text("查看详情"),),
              )
            ],
          ),
        );
      },
    );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._provide ??= widget._provide;
  }

  void orderDetailRoute(BuildContext context,CommodityDetailProvide provide){
    /// 订单详情请求
    provide.getOrderPayDetails(
        orderID:provide.orderId,
        payMode:provide.commodityModels.payMode,
        queryStatus:provide.resultStatus?1:0
    ).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item.data!=null){
        _detailProvide.orderDetailModel=OrderDetailModel.fromJson(item.data);
      }
    }, onError: (e) {});
    
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context){
          return OrderDetailPage();
        }
    ));
  }
}

