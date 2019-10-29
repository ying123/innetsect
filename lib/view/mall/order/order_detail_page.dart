import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/order/order_pay_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/base/base.dart';

class OrderDetailPage extends PageProvideNode{

  final CommodityAndCartProvide _provide = CommodityAndCartProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;

  OrderDetailPage(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderContent(_provide,_detailProvide);
  }
}

class OrderContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  final CommodityDetailProvide _detailProvide;

  OrderContent(this._provide,this._detailProvide);

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
            color: Colors.white,
            height: ScreenAdapter.getScreenHeight(),
            child: new Column(
              children: <Widget>[
                // 地址栏
                _addressWidget(),
                // 订单详情
                _orderDetailWidget()
              ],
            ),
          ),
          new Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: new RaisedButton(
                color: AppConfig.primaryColor,
                textColor: AppConfig.fontBackColor,
                onPressed: (){
                  //提交订单
                  widget._detailProvide.submitShopping()
                      .doOnListen(() {
                  print('doOnListen');
                  })
                      .doOnCancel(() {})
                      .listen((item) {
                  ///加载数据
                    print('listen data->$item');
                    if(item.data!=null){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return OrderPayPage();
                          },
                      ));
                    }
                  }, onError: (e) {});
                },child: new Text("支付"),
              )
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadData();
  }

  /// 地址栏
  Provide<CommodityAndCartProvide> _addressWidget(){
    return Provide<CommodityAndCartProvide>(
      builder: (BuildContext context,Widget widget, CommodityAndCartProvide provide){
        return new Container(
          width: double.infinity,
          color: AppConfig.backGroundColor,
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex:1,
                      child: new Container(
                        padding: EdgeInsets.all(20),
                        child: new Row(
                          children: <Widget>[
                            new Image.asset("assets/images/mall/express.png",width: ScreenAdapter.width(40),),
                            new Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: new Text("添加购物地址",style: TextStyle(fontSize: ScreenAdapter.size(28),
                                color: AppConfig.assistFontColor
                              ),),
                            )
                          ],
                        ),
                      )
                    ),
                    new Expanded(
                      flex:1,
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: new Icon(Icons.chevron_right,color: AppConfig.fontBackColor,),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
              new Container(
              )
            ],
          ),
        );
      },
    );
  }

  /// 订单详情
  Provide<CommodityAndCartProvide> _orderDetailWidget(){
    return Provide<CommodityAndCartProvide> (
      builder: (BuildContext context,Widget widget,CommodityAndCartProvide  provide){
        List<CommodityModel> list = provide.buyCommodityModelList;
        return new Container(
          padding: EdgeInsets.only(left:20,top: 10,right:20),
          width: double.infinity,
          child: new Column(
            children: <Widget>[
              CustomsWidget().subTitle(title: "订单详情",color: AppConfig.primaryColor),
              new Container(
                width: double.infinity,
                color: Colors.red,
                child: new Row(
                  children: list.map((CommodityModel item){
                    return new Row(
                      children: <Widget>[
                        // 图片
                        new Container(
                          width:ScreenAdapter.width(160),
                          height:ScreenAdapter.height(160),
                          padding: EdgeInsets.all(10),
                          child: new Image.asset(item.images),
                        ),
                        // 右边
                        new Container(
                          width: double.infinity,
                          height:ScreenAdapter.height(160),
                          color:Colors.yellow,
                          child: new Column(
                            children: <Widget>[
                              new Text(item.describe,softWrap: true,)
                            ],
                          ),
                        )
//
//                        new Expanded(
//                            flex:1,
//                            child: new Container(
//                              padding: EdgeInsets.all(10),
//                              child: new Image.asset(item.images),
//                            )
//                        ),
//                        new Expanded(
//                            flex: 1,
//                            child: new Container(
//                              child: new Column(
//                                children: <Widget>[
//                                  new Text(item.describe,softWrap: true,)
//                                ],
//                              ),
//                            )
//                        )
                      ],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  /// 加载数据
  _loadData(){
    widget._detailProvide.createShopping(widget._detailProvide.commodityModels,
        widget._detailProvide.skusModel,widget._provide.count)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
//      _provide
    }, onError: (e) {});
  }
}