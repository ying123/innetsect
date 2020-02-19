import 'package:flutter/material.dart';
import 'package:innetsect/api/pay_utils.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/enum/order_status.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/logistics/logistics_page.dart';
import 'package:innetsect/view/mall/order/order_pay_page.dart';
import 'package:innetsect/view/my/address_management/address_management_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/mall/logistics/logistics_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:qr_flutter/qr_flutter.dart';

///Y订单详情页
class OrderDetailPage extends PageProvideNode{

  final CommodityAndCartProvide _provide = CommodityAndCartProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  final LogisticsProvide _logisticsProvide = LogisticsProvide.instance;
  final Map drawData;
  OrderDetailPage({this.drawData}){
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
    mProviders.provide(Provider<LogisticsProvide>.value(_logisticsProvide));
    print('drawData ===========> $drawData');
    // _orderDetailProvide.prodName = drawData['prodName'];
    // _orderDetailProvide.skuSpecs = drawData['skuSpecs'];
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return OrderContent(_provide,_detailProvide,_orderDetailProvide,_logisticsProvide);
  }
}

class OrderContent extends StatefulWidget {
  final CommodityAndCartProvide _provide;
  final CommodityDetailProvide _detailProvide;
  final OrderDetailProvide _orderDetailProvide;
  final LogisticsProvide _logisticsProvide;

  OrderContent(this._provide,this._detailProvide,this._orderDetailProvide,this._logisticsProvide);

  @override
  _OrderContentState createState() => new _OrderContentState();
}

class _OrderContentState extends State<OrderContent> {
  CommodityAndCartProvide _provide;
  OrderDetailProvide _orderDetailProvide;
  CommodityDetailProvide _detailProvide;
  LogisticsProvide _logisticsProvide;
  bool isShowToast=false;
  String pages;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("订单详情",style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),
        ),onTap: (){
        print(_detailProvide);
            if(pages=="pay_result"&&(widget._detailProvide.pages==null||
                widget._detailProvide.pages!="exhibition")){
              Navigator.pushNamedAndRemoveUntil(context, "/mallPage", (Route routes)=>false);
            }else if(widget._detailProvide.pages=="exhibition"){
              Navigator.pushNamedAndRemoveUntil(context, "/appNavigationBarPage", (Route routes)=>false);
            }else{
              Navigator.pop(context);
            }
          }
      ),
      body: Scaffold(
        body: new SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: <Widget>[
              // 地址栏
              _addressWidget(),
              // 订单详情
              _orderDetailWidget(),
              _orderDetailProvide.prodName == null
              ? Container()
              : Container(
                margin: EdgeInsets.only(left: ScreenAdapter.width(30)),
                alignment: Alignment.centerLeft,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(100),
                child: Text('恭喜您已成功抢到${_orderDetailProvide.prodName}:${_orderDetailProvide.skuSpecs}',style: TextStyle(
                  color: Color.fromRGBO(154, 163, 184, 1.0),fontSize: ScreenAdapter.size(28)
                ),),
              ),
              // orderType==2\3
              isShowToast?
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("恭喜您已成功抢到${_orderDetailProvide.orderDetailModel.orderSummary}",
                    style: TextStyle(color: AppConfig.blueBtnColor),),
                  ):Container(width: 0,height: 0,),
              // 商品总价
              _orderCountWidget(),
              // 底部
              _orderBottomWidget(),
              // 已支付订单显示
              _orderNoWidget(),
            ],
          ) ,
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(left: 20,right: 20),
          child: Provide<OrderDetailProvide>(
              builder: (BuildContext context,Widget widget, OrderDetailProvide provide){
                Widget widget =Container(height: 0.0,width: 0.0,);
                if(provide.orderDetailModel!=null
                    &&provide.orderDetailModel.status==0){

                  widget= this.payBtn();
                }
                if(provide.orderDetailModel!=null
                    &&(provide.orderDetailModel.status==1
                    ||provide.orderDetailModel.status==2)
                    &&provide.orderDetailModel.shopID==37){
                  widget= this.logisticsBtn();
                }
                if(provide.orderDetailModel!=null
                &&provide.orderDetailModel.status==1
                &&provide.orderDetailModel.ladingMode==1&&provide.orderDetailModel.syncStatus==3
                    &&DateTime.now().isAfter(DateTime.parse(provide.orderDetailModel.ladingTime))){
                  widget = Container(
                      height: ScreenAdapter.height(60),
                      padding:EdgeInsets.only(left: 10,) ,
                      child: new RaisedButton(
                        color: AppConfig.fontBackColor,
                        onPressed: () async{
                          _detailProvide.ladingQrCode(provide.orderDetailModel.orderID).doOnListen(() {
                            print('doOnListen');
                          })
                              .doOnCancel(() {})
                              .listen((item) {
                            ///加载数据
                            print('listen data->$item');
                            if(item!=null&&item.data!=null){
                              showDialog(context: context,
                                  builder: (context){
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: ScreenAdapter.width(400),
                                            height: ScreenAdapter.height(400),
                                            color: Colors.white,
                                            child: QrImage(
                                              padding: EdgeInsets.all(0),
                                              data: item.data['qrCode'],
                                              size: 5000,
                                            ),
                                          ),
                                          Container(
                                              width: ScreenAdapter.width(400),
                                              height: ScreenAdapter.height(100),
                                              color:Colors.white,
                                              alignment: Alignment.center,
                                              child: Text(provide.orderDetailModel.remark==null?"":provide.orderDetailModel.remark,
                                                style: TextStyle(
                                                    fontSize: ScreenAdapter.size(24),
                                                    color: Colors.black,decoration: TextDecoration.none
                                                ),)
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              );
                            }
                          }, onError: (e) {});
                        },
                        child: new Text("提货码",style: TextStyle(
                            fontSize: ScreenAdapter.size(24),color: Colors.white),),
                      )
                  );
                }
                return widget;
              }
          ),
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
    _orderDetailProvide ??= widget._orderDetailProvide;
    _detailProvide ??= widget._detailProvide;
    _logisticsProvide ??= widget._logisticsProvide;
    Future.delayed(Duration.zero,(){
      Map<dynamic,dynamic> maps = ModalRoute.of(context).settings.arguments;
      if(maps!=null&&maps['orderID']!=null){
        /// 订单详情请求
        widget._detailProvide.getOrderPayDetails(
          orderID: maps['orderID'],
        ).doOnListen(() {
          print('doOnListen');
        }).doOnCancel(() {}).listen((items) {
          ///加载数据
          print('listen data->$items');
          if(items!=null&&items.data!=null){
            OrderDetailModel model = OrderDetailModel.fromJson(items.data);
            if(model.orderType==2 || model.orderType==3){
              isShowToast = true;
            }
            setState(() {
              _orderDetailProvide.orderDetailModel = model;
              pages = maps['pages'];
            });
          }
        }, onError: (e) {});
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget._orderDetailProvide.orderDetailModel = null;
    ///默认支付宝
    _detailProvide.defaultPayMode();
  }

  /// 查询物流信息
  Widget logisticsBtn(){
    return  new RaisedButton(
      color: AppConfig.fontBackColor,
      textColor: Colors.white,
      onPressed: (){
        // 跳转物流信息
        Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return LogisticsPage();
            }
        ));
      },child: new Text("查看物流",style: TextStyle(fontSize: ScreenAdapter.size(24),
    fontWeight: FontWeight.w500),),
    );
  }

  /// 支付按钮
  Widget payBtn(){
    return  new RaisedButton(
      color: AppConfig.blueBtnColor,
      textColor: Colors.white,
      onPressed: (){
        //提交订单
        if(_orderDetailProvide.orderDetailModel.orderNo!=null){
          _setOrder(_orderDetailProvide.orderDetailModel.orderID);
        }else{
          _detailProvide.submitShopping(_orderDetailProvide.orderDetailModel.addressID,
          context:context)
              .doOnListen(() {
            print('doOnListen');
          })
              .doOnCancel(() {})
              .listen((item) {
            print('listen data->$item');
            if(item!=null&&item.data!=null){
              _reloadCartList();
              _setOrder(item.data['orderID']);
            }
          }, onError: (e) {});
        }
      },child: new Text("提交订单"),
    );
  }

  void _reloadCartList(){
    _provide.getMyCarts(context).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        List<CommodityModels> list = CommodityList.fromJson(item.data).list;
        _provide.commodityTypesModelLists.clear();
        list.forEach((res){
          _provide.addCarts(res);
        });
      }
    }, onError: (e) {});
  }

  _setOrder(int orderID){
    ///默认支付宝
    _detailProvide.defaultPayMode();
    ///加载数据，存储订单号
    _detailProvide.setOrderId(orderID);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context){
        return OrderPayPage();
      },
    ));
  }

  /// 地址栏
  Widget _addressWidget(){
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
                      if(_orderDetailProvide.orderDetailModel.addressModel!=null){
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
                      child:  this.getAddress(),
                    ),
                  )
                ),
                _addressRightIcon()
              ],
            ),
          ),
          _orderDetailProvide.orderDetailModel==null?new Container():
          this.getAddressDetailWidget()
        ],
      ),
    );
  }

  Provide<OrderDetailProvide> _addressRightIcon(){
    return Provide<OrderDetailProvide>(
        builder: (BuildContext context,Widget widget, OrderDetailProvide provide)
    {
      OrderDetailModel model = provide.orderDetailModel;
      if(model!=null&&model.addressModel!=null){
        return new Expanded(
            flex:1,
            child: new Container(
              alignment: Alignment.topLeft,
              child: new Icon(Icons.chevron_right,color: AppConfig.fontBackColor,),
            )
        );
      }else {
        return new Container();
      }
    });
  }

  Widget getAddress(){
    Widget widget;
    OrderDetailModel model = _orderDetailProvide.orderDetailModel;
    if(model==null) return new Container();
    if(model.addressModel!=null){
      widget = this.getAddressWidget();
    }else if(model!=null&&model.tel!=null){
      widget = this.getAddressWidget();
    }else {
      widget = _addAddress();
    }
    return widget;
  }

  Widget getAddressDetailWidget(){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 40,bottom: 10),
      child:  Provide<OrderDetailProvide>(
        builder: (BuildContext context,Widget widget, OrderDetailProvide provide){
          OrderDetailModel model = provide.orderDetailModel;
          String address = "";
          if(model.addressModel==null&& model.shipTo!=null){
            address = model.shipTo;
          }else if(model.addressModel!=null){
            address =  model.addressModel.province + model.addressModel.city +model.addressModel.county
                + model.addressModel.addressDetail;
          }
          return new Text(address, style: TextStyle(color: Colors.grey),);
        },
      ),
    );
  }

  Widget getAddressWidget(){
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
                          child: Provide<OrderDetailProvide>(
                              builder: (BuildContext context,Widget widget, OrderDetailProvide provide) {
                                OrderDetailModel model = provide.orderDetailModel;
                                String name = model.receipient;
                                if(model.addressModel!=null){
                                  name = model.addressModel.name;
                                }
                                return new Text("收货人: $name",maxLines: 1,);
                              })
                          ,)
                      ],
                    ),
                  )
              ),
              new Expanded(
                  flex:1,
                  child: new Container(
                    alignment: Alignment.centerRight,
                    child: Provide<OrderDetailProvide>(
                        builder: (BuildContext context,Widget widget, OrderDetailProvide provide) {
                          OrderDetailModel model = provide.orderDetailModel;
                          String tel = model!=null&&model.tel!=null?model.tel:"";
                          if(model.addressModel!=null){
                            tel = model.addressModel.tel!=null?model.addressModel.tel:"";
                          }
                          return new Text(tel,maxLines: 1,);
                        }),
                  ))
            ],
          ),
        ),

      ],
    );
  }

  /// 订单详情
  Widget _orderDetailWidget(){
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:20,top: 10,right:20),
      width: double.infinity,
      child: _orderDetailProvide.orderDetailModel!=null? new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: ScreenAdapter.width(10),
                height: ScreenAdapter.height(40),
                margin: EdgeInsets.only(right: 8),
                color: AppConfig.blueBtnColor,
              ),
              new Text("订单详情",style: TextStyle(
                  fontSize: ScreenAdapter.size(28),
                  fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: _orderDetailStatus(),
                ),
              )
            ],
          ),
          new Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10,left: 10,right: 10),
            child: _orderDetailProvide.orderDetailModel!=null
                &&_orderDetailProvide.orderDetailModel.skuModels!=null
                &&_orderDetailProvide.orderDetailModel.skuModels.length>0? new Column(
              children: _orderDetailProvide.orderDetailModel.skuModels.map((item){
                List skuNameList = CommonUtil.skuNameSplit(item.skuName);
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
                            child: new Image.network(item.skuPic+ConstConfig.LIST_IMAGE_SIZE,fit: BoxFit.fill,),
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
                                  child: new Column(
                                    children: <Widget>[
                                      new Container(
                                        width: double.infinity,
                                        child: new Text(skuNameList.length>0?skuNameList[0]:item.skuName,softWrap: true,),
                                      ),
                                      new Container(
                                          width: double.infinity,
                                          child: new Text(skuNameList.length>0?skuNameList[1]:"",style: TextStyle(color: Colors.grey),)
                                      )
                                    ],
                                  ),
                                ),
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(padding: EdgeInsets.only(left:10),
                                      child: new Text("数量 x ${item.quantity} 件"),),
                                    CustomsWidget().priceTitle(price: item.salesPrice.toString())
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
      ):Container(),
    );
  }
  /// 订单详情状态
  Provide<OrderDetailProvide> _orderDetailStatus(){
    return Provide<OrderDetailProvide> (
        builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
//        List<CommodityModel> list = provide.buyCommodityModelList;
          OrderDetailModel model = provide.orderDetailModel;
          return Text(model.status!=null?OrderStatusEnum().getStatusTitle(model.status):"",
            style: TextStyle(color: AppConfig.blueBtnColor),);
        });
  }
  /// 商品总价
  Widget _orderCountWidget(){
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.only(left:20,top: 10,right:20),
      width: double.infinity,
      child: _orderDetailProvide.orderDetailModel!=null? new Column(
        children: <Widget>[
          CustomsWidget().subTitle(title: "商品总价",color: AppConfig.blueBtnColor),
          new Padding(padding: EdgeInsets.all(10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("商品总价",style: TextStyle(fontSize: ScreenAdapter.size(24)),),
              Provide<OrderDetailProvide> (
                builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                  OrderDetailModel model = provide.orderDetailModel;
                  return new CustomsWidget().priceTitle(price: model.totalAmount.toString(),
                      color: Colors.grey,fontWeight: FontWeight.w400);
                }
              )
            ],
          )),
          new Padding(padding: EdgeInsets.all(10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("优惠",style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                Provide<OrderDetailProvide> (
                    builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                      OrderDetailModel model = provide.orderDetailModel;
                      return new CustomsWidget().priceTitle(price: model.totalDiscount.toString(),
                          color: Colors.grey,fontWeight: FontWeight.w400);
                    }
                )
              ],
            ),
          ),
          new Padding(padding: EdgeInsets.all(10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("运费",style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                Provide<OrderDetailProvide> (
                    builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                      OrderDetailModel model = provide.orderDetailModel;
                      return new CustomsWidget().priceTitle(price: model.freight.toString(),
                          color: Colors.grey,fontWeight: FontWeight.w400);
                    }
                )
              ],
            ),
          ),
        ]
      ):new Container()
    );
  }

  /// 卡抵用券等
  Widget _orderBottomWidget(){
      return new Container(
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        child: _orderDetailProvide.orderDetailModel != null? new Column(
          children: <Widget>[

            ///TODO 暂时隐藏
            /**new Row(
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
                ),*/

            ///TODO 暂时隐藏
            /**new Row(
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
                ),*/
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Provide<OrderDetailProvide> (
                    builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                      OrderDetailModel model = provide.orderDetailModel;
                      return new Text(model.status==0?"应付金额":"实际支付:");
                    }
                ),
                new Container(
                  padding: EdgeInsets.only(right: 10, top: 10),
                  child: new Row(
                    children: <Widget>[
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new CustomsWidget().priceTitle(price: model.status==0?
                            model.payableAmount.toString():model.payAmount.toString(), color: AppConfig.blueBtnColor);
                          }
                      )
                    ],
                  ),
                )
              ],
            ),

            ///TODO 暂时隐藏
            /**new Row(
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
                ),*/
          ],
        ) : new Container(),
      );
  }

  /// 订单详情底部订单号等信息
  Widget _orderNoWidget() {
      return _orderDetailProvide.orderDetailModel!=null&&
          _orderDetailProvide.orderDetailModel.payDate!=null?new Container(
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(PayUtils().payMode(model.payMode));
                          }
                      ),
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(model.payDate);
                          }
                      )
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(PayUtils().deliverMode(model.syncStatus));
                          }
                      )
                    ],
                  ),
                )
              ],
            ),
            _orderDetailProvide.orderDetailModel.shipperName!=null? new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("配送方式:"),
                new Container(
                  padding: EdgeInsets.only(top: 10),
                  child: new Row(
                  children: <Widget>[
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(model.shipperName);
                          }
                      )
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(model.orderNo);
                          }
                      ),
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(model.orderDate);
                          }
                      )
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
                      Provide<OrderDetailProvide> (
                          builder: (BuildContext context,Widget widget,OrderDetailProvide  provide) {
                            OrderDetailModel model = provide.orderDetailModel;
                            return new Text(model.remark==null?"":model.remark);
                          }
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ):new Container();
    }

  /// 添加购物车地址
  Widget _addAddress(){
    return InkWell(
      onTap: (){
        // 跳转新建地址
        // 点击跳转地址管理页面
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context){
              return AddressManagementPage();
            },
            settings: RouteSettings(arguments: {'pages': 'orderDetail'})
        ));
      },
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              width:double.infinity,
              padding: EdgeInsets.only(left: 20,top: 10,bottom: 10),
              child: Row(
                children: <Widget>[
                  new Image.asset("assets/images/mall/express.png",width: ScreenAdapter.width(40),),
                  new Text("添加购物地址",style: TextStyle(fontSize: ScreenAdapter.size(28),
                      color: AppConfig.assistFontColor
                  ),)
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.chevron_right),
          )
        ],
      ),
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


