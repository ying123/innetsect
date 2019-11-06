import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/widget/commodity_select_widget.dart';
import 'package:innetsect/view/widget/counter_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';

class CommodityModalChildPage extends PageProvideNode{
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide();
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide();

  CommodityModalChildPage(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CommodityModalChildContent();
  }
}

class CommodityModalChildContent extends StatefulWidget {

  @override
  _CommodityModalChildContentState createState() => new _CommodityModalChildContentState();
}

class _CommodityModalChildContentState extends State<CommodityModalChildContent> {
  CommodityAndCartProvide _cartProvide;
  CommodityDetailProvide _detailProvide;
  OrderDetailProvide _orderDetailProvide;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        // 返回按钮
        goBackIcon(),
        // 中间部分
        contentWidget(),
        // 计数器
        counterWidget(),
        // 加入购物车、立即购买
        bottomBtn()
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._cartProvide = CommodityAndCartProvide.instance;
    this._detailProvide = CommodityDetailProvide.instance;
    this._orderDetailProvide = OrderDetailProvide.instance;
    this._cartProvide.setMode();
  }

  /// 返回按钮
  Widget goBackIcon(){
    return new Container(
      height: ScreenAdapter.height(60),
      color: Colors.white,
      width: double.infinity,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: new Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: new Icon(Icons.clear),
            )
          )
        ],
      ),
    );
  }
  
  /// 中间选择区域
  Widget contentWidget(){
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.getScreenHeight()/1.5,
      color: Colors.white,
      child: new CommoditySelectWidget(),
    );
  }

  /// 计数器
  Widget counterWidget(){
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.height(100),
      alignment: Alignment.center,
      child: CounterWidget(provide: this._cartProvide,),
    );
  }

  /// 底部按钮
  Widget bottomBtn(){
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.height(60),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: ScreenAdapter.getScreenWidth()/2-10,
            padding: EdgeInsets.only(left: 10,right: 10),
            child: new RaisedButton(
              color: AppConfig.fontBackColor,
              textColor: Colors.white,
              onPressed: (){},
              child: new Text("加入购物车",style: TextStyle(
                  fontSize: ScreenAdapter.size(30)
                ),
              ),
            ),
          ),
          new Container(
            width: ScreenAdapter.getScreenWidth()/2-10,
            padding: EdgeInsets.only(right: 5),
            child: new RaisedButton(
              color: AppConfig.primaryColor,
              textColor: AppConfig.fontBackColor,
              onPressed: (){
                // 检测本地是否存在token
                if(UserTools().getUserData()==null){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return LoginPage();
                      }
                  ));
                }else{
                  // 跳转订单详情
                  _detailProvide.createShopping(_detailProvide.commodityModels,
                      _detailProvide.skusModel,_cartProvide.count,context)
                      .doOnListen(() {
                    print('doOnListen');
                  })
                      .doOnCancel(() {})
                      .listen((item) {
                    ///加载数据,订单详情
                    print('listen data->$item');
                    if(item.data!=null){
                      OrderDetailModel model = OrderDetailModel.fromJson(item.data);
                      _orderDetailProvide.orderDetailModel = model;
                    }
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context){
                          return new OrderDetailPage();
                        })
                    );
                    //      _provide
                  }, onError: (e) {
                    print(e);
                  });
                }
              },
              child: new Text("立即购买",style: TextStyle(
                  fontSize: ScreenAdapter.size(30)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}