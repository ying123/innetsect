import 'package:flutter/material.dart';
import 'package:innetsect/api/pay_utils.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/mall/order/order_pay_result_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:provide/provide.dart';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';

class OrderPayPage extends PageProvideNode{

  final CommodityDetailProvide _provide = CommodityDetailProvide.instance;

  OrderPayPage(){
    mProviders.provide(Provider<CommodityDetailProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderPayContent(_provide);
  }
}

class OrderPayContent extends StatefulWidget {
  final CommodityDetailProvide _provide;
  OrderPayContent(this._provide);
  @override
  _OrderPayContentState createState() => new _OrderPayContentState();
}

class _OrderPayContentState extends State<OrderPayContent> {
  CommodityDetailProvide _provide;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,leading: false,
          widget: new Text("选择支付方式",style: TextStyle(
              fontSize: ScreenAdapter.size((30)),fontWeight: FontWeight.w900
            ),
          ),onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context){
                  return OrderDetailPage();
                },
                settings: RouteSettings(arguments: {"orderID":widget._provide.orderId})
            ));
          }
      ),
      body: new Container(
        color: Colors.white,
        width: double.infinity,
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1,color: AppConfig.assistLineColor))
              ),
              child: new Text("请选择支付方式"),
            ),
            _payWidget()
          ],
        ),
      ),
      bottomSheet: new Container(
        width: double.infinity,
        height: ScreenAdapter.height(120),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1,color: AppConfig.assistLineColor))
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Container(
              width: ScreenAdapter.getScreenWidth()/2 -20,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              child: new RaisedButton(
                color: AppConfig.fontBackColor,
                textColor: Colors.white,
                onPressed: (){
                  // 默认支付宝支付
                  widget._provide.defaultPayMode();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return OrderDetailPage();
                    },
                    settings: RouteSettings(arguments: {"orderID":widget._provide.orderId})
                  ));
                },child: new Text("取消支付",style:TextStyle(fontSize: ScreenAdapter.size(24)))),
            ),
            new Container(
                width: ScreenAdapter.getScreenWidth()/2 -20,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: new RaisedButton(
                  color: AppConfig.blueBtnColor,
                  textColor: Colors.white,
                  onPressed: (){
                    // 提交付款
                    widget._provide.payShopping().doOnListen(() {
                      print('doOnListen');
                    }).doOnCancel(() {}).listen((item) {
                      ///加载数据
                      print('listen data-===========>${item.data}');
                      if(item.data!=null){
                        if(widget._provide.payMode==1){
                          // 微信支付，注册
                      
                          SyFlutterWechat.register(item.data['appid']);
                          // package,orderID,appid,sign,partnerid,prepayid,noncestr,timestamp
                          print('========');
                          PayUtils().weChatPay(item.data).then((result){
                            if(result.index==0){
                              widget._provide.resultStatus = true;
                              // 支付成功
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }else{
                              // 支付异常
                              widget._provide.resultStatus = false;
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }
                          });
                        }else if(widget._provide.payMode==2){
                          //支付宝支付
                          PayUtils().aliPay(item.data['orderString']).then((result){
                            if(result['resultStatus']=="9000"){
                              widget._provide.resultStatus = true;
                              // 支付成功
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }else{
                              // 支付异常
                              widget._provide.resultStatus = false;
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context){
                                    return OrderPayResultPage();
                                  }
                              ));
                            }
                          });
                        }
                      }
                    }, onError: (e) {});

                  },
                  child: new Text("付款",style:TextStyle(fontSize: ScreenAdapter.size(24))),)
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
  }

  /// 选择支付方式
  Provide<CommodityDetailProvide> _payWidget(){
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context,Widget widget, CommodityDetailProvide provide){
        return new Column(
                children: provide.payList.asMap().keys.map((keys){
                  return InkWell(
                      onTap: (){
                        provide.onChangePayMode(keys);
                      },
                      child: new Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        height: ScreenAdapter.height(120),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: AppConfig.assistLineColor))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(provide.payList[keys]['name'],style: TextStyle(fontSize: ScreenAdapter.height(28)),),
                            new Container(
                              child: provide.payList[keys]['isSelected']? new Icon(
                                Icons.check_circle,
                                size: 25.0,
                                color: AppConfig.fontBackColor,
                              ) : new Icon(Icons.panorama_fish_eye,
                                size: 25.0,
                              ),
                            )
                          ],
                        ),
                      )
                  );
                }).toList()
            );
      },
    );
  }


}