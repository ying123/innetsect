import 'package:flutter/material.dart';
import 'package:innetsect/api/pay_utils.dart';
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
    print('OrderPayResultPage');
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
                child: new Text(provide.resultStatus?"支付成功":"订单未支付",style: TextStyle(decoration: TextDecoration.none,fontSize: ScreenAdapter.size(32)),),
              ),
              provide.resultStatus?new Container(
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
              ): new Padding(padding: EdgeInsets.only(top: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    textColor: Colors.white,
                    color: Colors.black,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: new Text("暂不支付",),
                  ),
                  new RaisedButton(
                    textColor: Colors.black,
                    color: AppConfig.primaryColor,
                    onPressed: (){
                      // 提交付款
                      _provide.payShopping().doOnListen(() {
                        print('doOnListen');
                      }).doOnCancel(() {}).listen((item) {
                        ///加载数据
                        print('listen data->$item');
                        if(item.data!=null){
                          PayUtils().aliPay(item.data['orderString']).then((result){
                            if(result['resultStatus']=="9000"){
                              _provide.resultStatus = true;
                              // 支付成功
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }else{
                              // 支付异常
                              _provide.resultStatus = false;
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }
                          });
                        }
                      }, onError: (e) {});
                    },
                    child: new Text("继续支付",),
                  ),
                ],
              ),)
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
    this._detailProvide??=widget._detailProvide;
    /// 订单详情请求
    _provide.getOrderPayDetails(
        orderID:_provide.orderId,
        payMode:_provide.payMode,
        queryStatus:_provide.resultStatus?1:0
    ).doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item.data!=null){
        _detailProvide.orderDetailModel=OrderDetailModel.fromJson(item.data);

      }
    }, onError: (e) {});
  }

  void orderDetailRoute(BuildContext context,CommodityDetailProvide provide){
    if(_detailProvide.orderDetailModel!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context){
            return OrderDetailPage();
          },
        settings: RouteSettings(arguments: {'orderID':_detailProvide.orderDetailModel.orderID})
      ));
    }
  }
}

