import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/base/base.dart';

class OrderDetailPage extends PageProvideNode{
  
  final CommodityAndCartProvide _provide = CommodityAndCartProvide();

  OrderDetailPage(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
  }
  
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderContent(_provide);
  }
}

class OrderContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;

  OrderContent(this._provide);
  
  @override
  _OrderContentState createState() => new _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("订单详情",style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900
          ),
        )
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            width: double.infinity,
            height: ScreenAdapter.getScreenHeight(),
            child: new Text("111"),
          ),
          new Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: new RaisedButton(
                color: AppConfig.primaryColor,
                textColor: AppConfig.fontBackColor,
                onPressed: (){

                },child: new Text("支付"),
              )
          )
        ],
      ),
    );
  }
}