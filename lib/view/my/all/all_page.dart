import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/enum/order_status.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/my/all/all_provide.dart';
import 'package:provide/provide.dart';

class AllPage extends PageProvideNode{
  final AllProvide _provide = AllProvide();
  AllPage(){
    mProviders.provide(Provider.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return AllContentPage(_provide);
  }
}

class AllContentPage extends StatefulWidget {
  final AllProvide _provide;
  AllContentPage(this._provide);
  @override
  _AllContentPageState createState() => _AllContentPageState();
}

class _AllContentPageState extends State<AllContentPage> {
  AllProvide _provide;
  int pageNo=1;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Provide<AllProvide>(
      builder: (BuildContext context,Widget widget,AllProvide provide){
        return ListWidgetPage(
            onRefresh: () async{
              await Future.delayed(Duration(seconds: 2), () {
                _listData(pageNo: 1,isReload: true);
              });
            },
            onLoad: () async{
              await Future.delayed(Duration(seconds: 2), () {
                _listData(pageNo: pageNo++);
              });
            },
            child: <Widget>[
              // 数据内容
              SliverList(
                delegate: SliverChildListDelegate(_provide.orderDetailList.map((item){
                  return new Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text('订单号: ${item.orderNo}'),
                              new Text(OrderStatusEnum().getStatusTitle(item.status))
                            ],
                          ),
                        ),
                        // 商品展示
                        _commodityContent(item),
                        new Divider(height: 1,color: AppConfig.assistLineColor,),
                        //底部操作按钮
                        new Container(
                          padding:EdgeInsets.only(bottom: 10,top: 10),
                          child: _bottomAction(item.status),
                        )
                      ],
                    ),
                  );
                }).toList()),
              )
            ]
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provide ??= widget._provide;
    _listData(pageNo: pageNo,isReload: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageNo = 1;
  }

  Provide<AllProvide> _commodityContent(OrderDetailModel model){
    return Provide<AllProvide>(
      builder: (BuildContext context, Widget widget, AllProvide provide){
        List<CommodityModels> skuList = model.skuModels;
        return new Container(
          child: new Column(
            children: skuList.map((skuItem){
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
                      child: new Text(skuItem.skuName,softWrap: true,)),
                  new Container(
                      height: ScreenAdapter.height(120),
                      padding:EdgeInsets.only(bottom: 5,right: 10),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new CustomsWidget().priceTitle(price: skuItem.salesPrice.toString()),
                          new Text("共 ${skuItem.quantity} 件")
                        ],
                      ))
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _bottomAction(int index){
    Widget widget;
    switch(index){
      case 0:
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
                height: ScreenAdapter.height(60),
                width: ScreenAdapter.width(160),
                child: new RaisedButton(
                  color: AppConfig.assistLineColor,
                  onPressed: (){},
                  child: new Text("取消订单",style: TextStyle(
                      fontSize: ScreenAdapter.size(24),color: AppConfig.fontBackColor),),
                )
            ),
            new Container(
              height: ScreenAdapter.height(60),
              width: ScreenAdapter.width(180),
              padding:EdgeInsets.only(left: 10,) ,
              child: new RaisedButton(
                color: AppConfig.primaryColor,
                onPressed: (){},
                child: new Text("立即付款",style: TextStyle(
                    fontSize: ScreenAdapter.size(24),color: AppConfig.fontBackColor),),
              ),
            )
          ],
        );
        break;
      case 1:
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Container(
                height: ScreenAdapter.height(60),
                width: ScreenAdapter.width(160),
                child: new RaisedButton(
                  color: AppConfig.fontBackColor,
                  onPressed: (){},
                  child: new Text("退款明细",style: TextStyle(
                      fontSize: ScreenAdapter.size(24),color: Colors.white),),
                )
            ),
            _delOrderWidget()
          ],
        );
        break;
      case -1:
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _delOrderWidget()
          ],
        );
        break;
    }
    return widget;
  }

  Widget _delOrderWidget(){
    return new Container(
      height: ScreenAdapter.height(60),
      width: ScreenAdapter.width(180),
      padding:EdgeInsets.only(left: 10,) ,
      child: new RaisedButton(
        color: AppConfig.primaryColor,
        onPressed: (){},
        child: new Text("删除订单",style: TextStyle(
            fontSize: ScreenAdapter.size(24),color: AppConfig.fontBackColor),),
      ),
    );
  }

  _listData({int pageNo=0,bool isReload = false}){
    _provide.getOrderList(pageNo: pageNo,isReload: isReload).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item.data!=null){
        _provide.addOrderList(OrderDetailModelList.fromJson(item.data).list);
      }
    }, onError: (e) {});
  }
}