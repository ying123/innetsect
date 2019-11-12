import 'package:flutter/material.dart';
import 'package:innetsect/api/pay_utils.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/order/order_pay_page.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/base/base.dart';

class OrderDetailPage extends PageProvideNode{

  final CommodityAndCartProvide _provide = CommodityAndCartProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;

  OrderDetailPage(){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderContent(_provide,_detailProvide,_orderDetailProvide);
  }
}

class OrderContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  final CommodityDetailProvide _detailProvide;
  final OrderDetailProvide _orderDetailProvide;

  OrderContent(this._provide,this._detailProvide,this._orderDetailProvide);

  @override
  _OrderContentState createState() => new _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  OrderDetailProvide _orderDetailProvide;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("订单详情",style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),
        )
      ),
      body: new Stack(
        children: <Widget>[
          new Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: new Container(
                width: double.infinity,
                height: ScreenAdapter.getScreenHeight()-140,
                color: AppConfig.assistLineColor,
                child: new ListView(
                  children: <Widget>[
                    // 地址栏
                    _addressWidget(),
                    // 订单详情
                    _orderDetailWidget(),
                    // 商品总价
                    _orderCountWidget(),
                    // 底部
                    _orderBottomWidget(),
                    // 已支付订单显示
                    this._orderNoWidget(),
                  ],
                ),
              ),
          ),
          new Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Provide<OrderDetailProvide>(
                  builder: (BuildContext context,Widget widget, OrderDetailProvide provide){
                    if(provide.orderDetailModel!=null&&provide.orderDetailModel.status==0){
                      return this.payBtn();
                    }else {
                      return this.logisticsBtn();
                    }
                  }
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
    _orderDetailProvide = widget._orderDetailProvide;

    Future.delayed(Duration.zero,(){
      Map<dynamic,dynamic> map = ModalRoute.of(context).settings.arguments;
      if(map!=null&&map['orderID']!=null){
        /// 订单详情请求
        widget._detailProvide.getOrderPayDetails(
          orderID: map['orderID'],
        ).doOnListen(() {
          print('doOnListen');
        }).doOnCancel(() {}).listen((items) {
          ///加载数据
          print('listen data->$items');
          if(items!=null&&items.data!=null){
            widget._orderDetailProvide.orderDetailModel = OrderDetailModel.fromJson(items.data);
          }
        }, onError: (e) {});
      }
    });

  }

  /// 查询物流信息
  Widget logisticsBtn(){
    return  new RaisedButton(
      color: AppConfig.fontBackColor,
      textColor: Colors.white,
      onPressed: (){
        // 跳转物流信息
      },child: new Text("物流信息"),
    );
  }

  /// 支付按钮
  Widget payBtn(){
    return  new RaisedButton(
      color: AppConfig.primaryColor,
      textColor: AppConfig.fontBackColor,
      onPressed: (){
        //提交订单
        widget._detailProvide.submitShopping(widget._orderDetailProvide.orderDetailModel.addressID)
            .doOnListen(() {
          print('doOnListen');
        })
            .doOnCancel(() {})
            .listen((item) {
          print('listen data->$item');
          if(item!=null&&item.data!=null){
            ///默认支付宝
            widget._detailProvide.setPayModel(2);
            ///加载数据，存储订单号
            widget._detailProvide.setOrderId(item.data['orderID']);
            Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return OrderPayPage();
              },
            ));
          }
        }, onError: (e) {});
      },child: new Text("支付"),
    );
  }

  /// 地址栏
  Provide<OrderDetailProvide> _addressWidget(){
    return Provide<OrderDetailProvide>(
      builder: (BuildContext context,Widget widget, OrderDetailProvide provide){
        OrderDetailModel model = provide.orderDetailModel;
        return new Container(
          width: double.infinity,
          color: AppConfig.assistLineColor,
          child: new Column(
            children: <Widget>[
              new Container(
                width: double.infinity,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex:9,
                      child:  new InkWell(
                        onTap: (){
                          if(model.addressModel!=null){
                            // 点击跳转地址管理页面
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context){
                                  return AddressManagementPage();
                                },
                                settings: RouteSettings(arguments: {'pages': 'orderDetail'})
                            ));
                          } else {
                            return null;
                          }
                        },
                        child: new Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child:  this.getAddress(model),
                        ),
                      )
                    ),
                    model!=null&&model.addressModel!=null?new Expanded(
                      flex:1,
                      child: new Container(
                        alignment: Alignment.topLeft,
                        child: new Icon(Icons.chevron_right,color: AppConfig.fontBackColor,),
                      )
                    ):new Container()
                  ],
                ),
              ),
              model==null?new Container():
              model.addressModel==null?model.shipTo!=null?
                this.getAddressDetailWidget(addressDetail: model.shipTo)
                  : new Container()
                    : this.getAddressDetailWidget(
                      province: model.addressModel.province,
                      city: model.addressModel.city,
                      addressDetail: model.addressModel.addressDetail
                    )
            ],
          ),
        );
      },
    );
  }

  Widget getAddress(OrderDetailModel model){
    Widget widget;
    if(model==null) return new Container();
    if(model.addressModel!=null){
      widget = this.getAddressWidget(name: model.addressModel.name,tel: model.addressModel.tel);
    }else if(model.tel!=null){
      widget = this.getAddressWidget(name: model.receipient,tel: model.tel);
    }else {
      widget = _addAddress();
    }
    return widget;
  }

  Widget getAddressDetailWidget({String province="",String city="",String addressDetail}){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 40,bottom: 10),
      child:  new Text(province+city+addressDetail,
        style: TextStyle(color: Colors.grey),),
    );
  }

  Widget getAddressWidget({String name,String tel}){
    return new Column(
      children: <Widget>[
        new Container(
          width: double.infinity,
          child: new Row(
            children: <Widget>[
              new Expanded(
                  flex:2,
                  child: new Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Row(
                      children: <Widget>[
                        new Image.asset("assets/images/mall/location.png",fit: BoxFit.fill,width: ScreenAdapter.width(25),),
                        new Padding(padding: EdgeInsets.only(left: 5),
                          child: new Text("收货人: $name",maxLines: 1,),)
                      ],
                    ),
                  )
              ),
              new Expanded(
                  flex:1,
                  child: new Container(
                    alignment: Alignment.centerRight,
                    child: new Text(tel),
                  ))
            ],
          ),
        ),

      ],
    );
  }

  /// 订单详情
  Provide<OrderDetailProvide> _orderDetailWidget(){
    return Provide<OrderDetailProvide> (
      builder: (BuildContext context,Widget widget,OrderDetailProvide  provide){
//        List<CommodityModel> list = provide.buyCommodityModelList;
        OrderDetailModel model = provide.orderDetailModel;
        return new Container(
          color: Colors.white,
          padding: EdgeInsets.only(left:20,top: 10,right:20),
          width: double.infinity,
          child: new Column(
            children: <Widget>[
              CustomsWidget().subTitle(title: "订单详情",color: AppConfig.primaryColor),
              new Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                child: model!=null? new Column(
                  children: model.skuModels.map((item){
                    return new Container(
                      padding:EdgeInsets.only(top: 10,bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppConfig.assistLineColor))
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Expanded(
                              flex: 1,
                              child: new Container(
                                width: ScreenAdapter.width(80),
                                height: ScreenAdapter.height(80),
                                child: new Image.network(item.skuPic,fit: BoxFit.fill,),
                              )
                          ),
                          new Expanded(
                              flex:6,
                              child: new Container(
                                width: double.infinity,
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(padding: EdgeInsets.only(left: 10,bottom: 10),
                                      child: new Text(item.skuName,softWrap: true,),
                                    ),
                                    new Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Padding(padding: EdgeInsets.only(left:10),
                                          child: new Text("数量 x ${item.quantity} 件"),),
                                        CustomsWidget().priceTitle(price: item.amount.toString())
                                      ],
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ):new Container(),
              )
            ],
          ),
        );
      }
    );
  }
  /// 商品总价
  Provide<OrderDetailProvide> _orderCountWidget(){
    return Provide<OrderDetailProvide> (
        builder: (BuildContext context,Widget widget,OrderDetailProvide  provide){
      OrderDetailModel model = provide.orderDetailModel;
        return new Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.only(left:20,top: 10,right:20),
          width: double.infinity,
          child: model!=null? new Column(
            children: <Widget>[
              CustomsWidget().subTitle(title: "商品总价",color: AppConfig.primaryColor),
              new Padding(padding: EdgeInsets.all(10),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("优惠",style: TextStyle(fontWeight: FontWeight.w600,fontSize: ScreenAdapter.size(24)),),
                    new CustomsWidget().priceTitle(price: model.totalDiscount.toString())
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(10),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("运费",style: TextStyle(fontWeight: FontWeight.w600,fontSize: ScreenAdapter.size(24)),),
                    new CustomsWidget().priceTitle(price: model.freight.toString())
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new CustomsWidget().priceTitle(price: model.totalAmount.toString())
                ],
              ))
            ]
          ):new Container()
        );
    });
  }

  /// 卡抵用券等
  Provide<OrderDetailProvide> _orderBottomWidget(){
    return Provide<OrderDetailProvide> (
        builder: (BuildContext context,Widget widget,OrderDetailProvide  provide){
      OrderDetailModel model = provide.orderDetailModel;
      return new Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.all(10),
        child: model!=null? new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("卡券抵用:"),
                new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      new CustomsWidget().priceTitle(price: model.payCoupon.toString()),
                      new Icon(Icons.chevron_right,color: Colors.grey,)
                    ],
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("积分支付:"),
                new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      new CustomsWidget().priceTitle(price: model.payPoint.toString()),
                      new Icon(Icons.chevron_right,color: Colors.grey,)
                    ],
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("实际支付:"),
                new Container(
                  padding: EdgeInsets.only(right: 10,top: 10),
                  child: new Row(
                    children: <Widget>[
                      new CustomsWidget().priceTitle(price: model.payableAmount.toString(),color: Colors.red)
                    ],
                  ),
                )
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("发票类型:"),
                new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: new Row(
                    children: <Widget>[
                      new Text(getType(model.invoiceType)),
                      new Icon(Icons.chevron_right,color: Colors.grey,)
                    ],
                  ),
                )
              ],
            ),
          ],
        ):new Container(),
      );
    });
  }

  /// 订单详情底部订单号等信息
  Provide<OrderDetailProvide> _orderNoWidget() {
    return Provide<OrderDetailProvide>(
        builder: (BuildContext context, Widget widget,
            OrderDetailProvide provide) {
          OrderDetailModel model = provide.orderDetailModel;
          return model!=null&&model.payDate!=null?new Container(
            color: Colors.white,
            width: double.infinity,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(left:10,right:20,top: 5),
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("支付方式:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(PayUtils().payMode(model.payMode)),
                        ],
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("支付时间:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(model.payDate),
                        ],
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("发货状态:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(PayUtils().deliverMode(model.syncStatus)),
                        ],
                      ),
                    )
                  ],
                ),
                model.shipperName!=null? new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("配送方式:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                      children: <Widget>[
                          new Text(model.shipperName),
                        ],
                      ),
                    )
                  ],
                ):new Container()
                ,new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("订单编号:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(model.orderNo),
                        ],
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("下单时间:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(model.orderDate),
                        ],
                      ),
                    )
                  ],
                ),new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text("下单备注:"),
                    new Container(
                      padding: EdgeInsets.only(top: 10),
                      child: new Row(
                        children: <Widget>[
                          new Text(model.remark==null?"":model.remark),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ):new Container();
        }
    );
  }

  /// 添加购物车地址
  Widget _addAddress(){
    return new Row(
      children: <Widget>[
        new Image.asset("assets/images/mall/express.png",width: ScreenAdapter.width(40),),
        new Padding(
          padding: EdgeInsets.only(left: 10),
          child: new Text("添加购物地址",style: TextStyle(fontSize: ScreenAdapter.size(28),
              color: AppConfig.assistFontColor
          ),),
        )
      ],
    );
  }

  String getType(int types){
    String str="";
    switch(types){
      case 0:
        str="不开票";
        break;
      case 1:
        str="个人普票";
        break;
      case 2:
        str = "专票";
        break;
    }
    return str;
  }
}