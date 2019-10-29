import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:provide/provide.dart';
import 'package:tobias/tobias.dart' as tobias;

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,leading: false,
          widget: new Text("选择支付方式",style: TextStyle(
              fontSize: ScreenAdapter.size((30)),fontWeight: FontWeight.w900
            ),
          )
      ),
      body: new Container(
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            new Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: new Container(
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
                      new Container(
                        padding: EdgeInsets.only(left: 20,right: 20),
                        height: ScreenAdapter.height(120),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1,color: AppConfig.assistLineColor))
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text("支付宝"),
                            CustomsWidget().customRoundedWidget(isSelected: true,
                                onSelectedCallback: (){
                                  // 点击回调
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ),
            new Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: new Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(width: 1,color: AppConfig.assistLineColor))
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Container(
                        width: ScreenAdapter.getScreenWidth()/2 -20,
                        child: new RaisedButton(
                          color: AppConfig.fontBackColor,
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.pop(context);
                          },child: new Text("取消支付"),),
                      ),
                      new Container(
                          width: ScreenAdapter.getScreenWidth()/2 -20,
                          child: new RaisedButton(
                            color: AppConfig.primaryColor,
                            textColor: Colors.black,
                            onPressed: (){
                              // 提交付款
                              widget._provide.payShopping().doOnListen(() {
                                print('doOnListen');
                              }).doOnCancel(() {}).listen((item) {
                                ///加载数据
                                print('listen data->$item');
                                if(item.data!=null){
                                  _callAlipay(item.data['orderString']);
                                }
                              }, onError: (e) {});

                            },
                            child: new Text("付款"),)
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  _callAlipay(String orderInfo) async{
    try{
      Map map = await tobias.aliPay(orderInfo);
      print(map);
    }catch(e){}
  }
}