import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/enum/order_status.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/logistics/logistics_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/mall/order/order_pay_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/mall/logistics/logistics_provide.dart';
import 'package:innetsect/view_model/my/all/all_provide.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AllPage extends PageProvideNode{
  final int idx;
  final AllProvide _provide = AllProvide.instance;
  final OrderDetailProvide _detailProvide = OrderDetailProvide.instance;
  final CommodityDetailProvide _commodityDetailProvide = CommodityDetailProvide.instance;
  final LogisticsProvide _logisticsProvide = LogisticsProvide.instance;

  AllPage({
    this.idx
  }){
    mProviders.provide(Provider<AllProvide>.value(_provide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_commodityDetailProvide));
    mProviders.provide(Provider<LogisticsProvide>.value(_logisticsProvide));
    print('idx======================>${this.idx}');
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return AllContentPage(_provide,_detailProvide,_commodityDetailProvide,this.idx,
    this._logisticsProvide);
  }
}

class AllContentPage extends StatefulWidget {
  final int idx;
  final AllProvide _provide;
  final OrderDetailProvide _detailProvide;
  final CommodityDetailProvide _commodityDetailProvide;
  final LogisticsProvide _logisticsProvide;
  AllContentPage(this._provide,this._detailProvide,this._commodityDetailProvide,this.idx,
      this._logisticsProvide);
  @override
  _AllContentPageState createState() => _AllContentPageState();
}

class _AllContentPageState extends State<AllContentPage> {
  AllProvide _provide;
  OrderDetailProvide _detailProvide;
  CommodityDetailProvide _commodityDetailProvide;
  LogisticsProvide _logisticsProvide;
  int idx;
  EasyRefreshController _easyRefreshController;
  List<OrderDetailModel> _orderDetailList = new List();

  int pageNo=1;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListWidgetPage(
        controller: _easyRefreshController,
        onRefresh: () async{
          _orderDetailList.clear();
          pageNo = 1;
          await _listData(pageNo: pageNo,isReload: true);
        },
        onLoad: () async{
          await _listData(pageNo: ++pageNo);
        },
        child: <Widget>[
          // 数据内容
          SliverList(
            delegate: SliverChildListDelegate(
                _orderDetailList.length>0?_orderDetailList.map((item){
              return new InkWell(
                onTap: () {
//                  /// 订单详情请求
//                  _commodityDetailProvide.getOrderPayDetails(
//                    orderID: item.orderID,
//                  ).doOnListen(() {
//                    print('doOnListen');
//                  }).doOnCancel(() {}).listen((items) {
//                    ///加载数据
//                    print('listen data->$items');
//                    if(items!=null&&items.data!=null){
//                      _detailProvide.orderDetailModel = OrderDetailModel.fromJson(items.data);
//
//                    }
//                  }, onError: (e) {});
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return OrderDetailPage();
                      },
                      settings: RouteSettings(arguments: {"orderID": item.orderID})
                  ));
                },
                child: new Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding:EdgeInsets.only(top: 5),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text('订单号: ${item.orderNo}'),
                            new Text(OrderStatusEnum().getStatusTitle(item.status),
                              style: TextStyle(color: AppConfig.blueBtnColor),)
                          ],
                        ),
                      ),
                      // 商品展示
                      _commodityContent(item),
                      //底部操作按钮
                      item.status!=-2?
                      new Container(
                        padding:EdgeInsets.only(bottom: 5,top: 10),
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: AppConfig.assistLineColor)),
                        ),
                        child: _bottomAction(item),
                      ):new Divider(height: 5,color: AppConfig.assistLineColor,)
                    ],
                  ),
                ),
              );
            }).toList():CustomsWidget().noDataWidget()
            ),
          )
        ]
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
    _detailProvide??=widget._detailProvide;
    _commodityDetailProvide??=widget._commodityDetailProvide;
    _logisticsProvide ??= widget._logisticsProvide;
    _easyRefreshController = EasyRefreshController();
    setState(() {
      idx = widget.idx;
    });
    _listData(pageNo: pageNo,isReload: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageNo = 1;
  }

  Widget _commodityContent(OrderDetailModel model){
    List<CommodityModels> skuList = model.skuModels;
    double price=double.parse(model.freight.toString());
    skuList.forEach((items){
      price += double.parse(items.amount.toString()) ;
    });
    return new Container(
      padding: EdgeInsets.only(bottom: 10),
      child: skuList.length>1?
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Row(
                  children: skuList.sublist(0,2).map((skuItem){
                    return  new Container(
                        width: ScreenAdapter.width(120),
                        height: ScreenAdapter.height(120),
                        alignment: Alignment.center,
                        child: new Image.network(skuItem.skuPic,fit: BoxFit.fill,
                          width: ScreenAdapter.width(100),height: ScreenAdapter.height(100),)
                    );
                  }).toList(),
                ),
              ),
              new Container(
                  height: ScreenAdapter.height(120),
                  padding:EdgeInsets.only(bottom: 5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new CustomsWidget().priceTitle(price: price.toString()),
                      new Text("共 ${skuList.length} 件")
                    ],
                  ))
            ],
          )
          : new Column(
        children: skuList.map((skuItem){
          List skuNameList = CommonUtil.skuNameSplit(skuItem.skuName);
          return new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Container(
                  width: ScreenAdapter.width(120),
                  height: ScreenAdapter.height(120),
                  alignment: Alignment.center,
                  child: new Image.network(skuItem.skuPic,fit: BoxFit.fill,
                    width: ScreenAdapter.width(100),height: ScreenAdapter.height(100),)
              ),
              new Container(
                  height: ScreenAdapter.height(120),
                  width: (ScreenAdapter.getScreenWidth()/1.7)-4,
                  padding: EdgeInsets.only(left: 10,top: 5),
                  alignment: Alignment.centerLeft,
                  child:skuNameList!=null&&skuNameList.length>0? new Column(
                    children: <Widget>[
                      new Container(
                        width: double.infinity,
                        child: new Text(skuNameList[0],softWrap: true,),
                      ),
                      new Container(
                          width: double.infinity,
                          child: new Text(skuNameList[1],style: TextStyle(color: Colors.grey),)
                      )
                    ],
                  ): new Container(
                    width: double.infinity,
                    child: new Text(skuItem.skuName,softWrap: true,),
                  )),
              new Container(
                  height: ScreenAdapter.height(120),
                  padding:EdgeInsets.only(bottom: 5),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new CustomsWidget().priceTitle(price: price.toString()),
                      new Text("共 ${skuItem.quantity} 件")
                    ],
                  ))
            ],
          );
        }).toList(),
      ),
    );
  }

  /// 底部操作栏
  Widget _bottomAction(OrderDetailModel model){
    Widget widget=Container(width: 0,height: 0,);
    //0待支付 1待收货 2已完成 -1已取消 -2已取消待退款 -4已取消已退款
    if(model.status==1){
      if(model.shopID==37){
        if(model.syncStatus<3){
          widget = new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              this._cancelOrderWidget(model.orderID),
              this._logisticsWidget(model)
            ],
          );
        } else{
          widget = new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              this._logisticsWidget(model)
            ],
          );
        }
      }else if(model.ladingMode==1&&model.syncStatus==3
          &&DateTime.now().isAfter(DateTime.parse(model.ladingTime))){
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
                height: ScreenAdapter.height(60),
                padding:EdgeInsets.only(left: 10,) ,
                child: new RaisedButton(
                  color: AppConfig.fontBackColor,
                  onPressed: () async{
                    _commodityDetailProvide.ladingQrCode(model.orderID).doOnListen(() {
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
                                        padding: EdgeInsets.all(20),
                                        data: item.data['qrCode'],
                                        size: 2000,
                                      ),
                                    ),
                                    Container(
                                      width: ScreenAdapter.width(400),
                                      height: ScreenAdapter.height(100),
                                      color:Colors.white,
                                      alignment: Alignment.center,
                                      child: Text(item.data['remark']==null?"":item.data['remark'],
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
            )
          ],
        );
      }
    }
    if(model.status==0){
      widget = new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          this._cancelOrderWidget(model.orderID),
          new Container(
            height: ScreenAdapter.height(60),
            padding:EdgeInsets.only(left: 10,) ,
            child: new RaisedButton(
              textColor: AppConfig.whiteBtnColor,
              color: AppConfig.blueBtnColor,
              onPressed: (){
                ///默认支付宝
                _commodityDetailProvide.payMode = 2;
                ///加载数据，存储订单号
                _commodityDetailProvide.setOrderId(model.orderID);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return OrderPayPage();
                  },
                ));
              },
              child: new Text("立即付款",style: TextStyle(
                  fontSize: ScreenAdapter.size(24)),),
            ),
          )
        ],
      );
    }else if(model.status==2 && model.shopID==37){
      widget = new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          this._logisticsWidget(model)
        ],
      );
    }else if(model.status==-1){
      widget = new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _delOrderWidget(model.orderID)
        ],
      );
    }
    return widget;
  }
bool isCancelButton = false;
  // 取消订单按钮
  Widget _cancelOrderWidget(int orderID){
    return new Container(
        height: ScreenAdapter.height(60),
        child: new RaisedButton(
          color: AppConfig.assistLineColor,
          onPressed: (){
            // 取消订单
            CustomsWidget().customShowDialog(
                context: context,
                content: "确定取消该订单!",
                onPressed: () async{
                  isCancelButton = !isCancelButton;
                  if (isCancelButton == true) {
                    print('================isCancelButton');
                     await _provide.cancelOrder(orderID).then((item){
                    if(item.data){
                      int index=_orderDetailList.indexWhere((val)=>val.orderID==orderID);
                      if(_orderDetailList[index].status==0){
                        _orderDetailList[index].status = -1;
                      }else if(_orderDetailList[index].status==1){
                        _orderDetailList[index].status = -2;
                      }
                      Navigator.pop(context);
                      this.setState((){});
                    }
                  });
                  }else{
                  //  isCancelButton = false;
                  }
                 
                }
            );
          },
          child: new Text("取消订单",style: TextStyle(
              fontSize: ScreenAdapter.size(24),color: AppConfig.fontBackColor),),
        )
    );
  }
  // 物流进度按钮
  Widget _logisticsWidget(OrderDetailModel model){
    return new Container(
      height: ScreenAdapter.height(60),
      padding:EdgeInsets.only(left: 10,) ,
      child: new RaisedButton(
        color: AppConfig.fontBackColor,
        onPressed: (){
          _detailProvide.orderDetailModel = model;
          _logisticsProvide.backPage=null;
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return LogisticsPage();
            }
          ));
        },
        child: new Text("物流进度",style: TextStyle(
        fontSize: ScreenAdapter.size(24),color: Colors.white),),
      )
    );
  }

  Widget _delOrderWidget(int orderID){
    return new Container(
      height: ScreenAdapter.height(60),
      padding:EdgeInsets.only(left: 10,) ,
      child: new RaisedButton(
        color: AppConfig.blueBtnColor,
        onPressed: () {
          //删除订单
          CustomsWidget().customShowDialog(
              context: context,
              content: "是否删除订单!",
              onPressed: () async{
                await _provide.delOrder(orderID).then((item){
                  if(item.data){
                    CustomsWidget().showToast(title: "删除成功");
                    //删除订单
                    _orderDetailList.removeWhere((res)=>res.orderID==orderID);
                    this.setState((){});
                    Navigator.pop(context);
                  }
                });
              }
          );
        },
        child: new Text("删除订单",style: TextStyle(
            fontSize: ScreenAdapter.size(24),color:Colors.white),),
      ),
    );
  }

  _listData({int pageNo=0,bool isReload = false}){
    String method;
    switch(this.idx){
      case 0:
        method = "/api/eshop/salesorders/list?pageNo=$pageNo&pageSize=8";
        break;
      case 1:
        method = "/api/eshop/salesorders/unpayed?pageNo=$pageNo&pageSize=8";
        break;
      case 2:
        method = "/api/eshop/salesorders/payed?pageNo=$pageNo&pageSize=8";
        break;
      case 3:
        method = "/api/eshop/salesorders/received?pageNo=$pageNo&pageSize=8";
        break;
      case 4:
        method = "/api/eshop/salesorders/canceled?pageNo=$pageNo&pageSize=8";
        break;
    }
    _provide.getOrderList(isReload: isReload,method: method).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        this.setState((){
          _orderDetailList.addAll(OrderDetailModelList.fromJson(item.data).list);
        });
      }
    }, onError: (e) {});
  }
}