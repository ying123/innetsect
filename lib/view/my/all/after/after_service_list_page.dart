import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/order/after_order_model.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/after/after_apply_page.dart';
import 'package:innetsect/view/my/all/after/after_detail_page.dart';
import 'package:innetsect/view/my/all/after/after_goods_page.dart';
import 'package:innetsect/view/my/all/after/after_logistics_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/my_order/after_service_provide.dart';
import 'package:provide/provide.dart';

class AfterServiceListPage extends PageProvideNode{
  final int idx;
  final AfterServiceProvide _afterServiceProvide = AfterServiceProvide.instance;

  AfterServiceListPage({this.idx}){
    mProviders.provide(Provider<AfterServiceProvide>.value(_afterServiceProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return AfterServiceListContent(idx,_afterServiceProvide);
  }
}

class AfterServiceListContent extends StatefulWidget {
  final int idx;
  final AfterServiceProvide _afterServiceProvide;
  AfterServiceListContent(this.idx,this._afterServiceProvide);
  @override
  _AfterServiceListContentState createState() => new _AfterServiceListContentState();
}

class _AfterServiceListContentState extends State<AfterServiceListContent> {
  AfterServiceProvide _afterServiceProvide;
  // 导航下标
  int idx;
  // 页码
  int pageNo = 1;
  // list 控制器
  EasyRefreshController _easyRefreshController;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide){
        return ListWidgetPage(
          controller: _easyRefreshController,
          onRefresh: () async{
            pageNo = 1;
            await this._loadData(pageNo: pageNo);
          },
          onLoad: () async{
            pageNo = pageNo +1;
            await this._loadData(pageNo: pageNo);
          },
          child: <Widget>[
            // 数据内容
            SliverList(
                delegate: SliverChildListDelegate(
                    _afterServiceProvide.list.length>0? _afterServiceProvide.list.map((item){
                      String orderNoName = item is AfterOrderModel?"售后单号: ${item.rmaNo}":"订单号: ${item.orderNo}";
                      String status = CommonUtil.afterStatusName(item.status);
                      if(item.syncStatus>=3&&item.status==40){
                        status = "已发出换货";
                      }else if(item.syncStatus>=3&&item.status==50){
                        status = "换货已完成";
                      }
                      return new Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          onTap: () async {
                            if(item is AfterOrderModel){
                              // 售后详情请求
                              _loadAfterDetail(item.rmaID);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context){
                                    return AfterDetailPage();
                                  }
                              ));
                            }
                          },
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // 订单号
                              new Container(
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child:item is AfterOrderModel?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(orderNoName),
                                    new Text(status,style: TextStyle(color: AppConfig.blueBtnColor),)
                                  ],
                                ): new Text(orderNoName),
                              ),
                              // 商品展示
                              _commodityContent(item),
                              // 底部操作按钮
                              item is AfterOrderModel?_afterBottom(item):_bottomConditionBtn(item),

                            ],
                          ),
                        ),
                      );
                    }).toList():CustomsWidget().noDataWidget()
                )
            )
          ],
        );
      },
    );
  }
  @override
  void initState() {
   
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
    _easyRefreshController = EasyRefreshController();
    setState(() {
      idx = widget.idx;
    });
    _afterServiceProvide.clearList();
    _loadData(pageNo: pageNo);
  }

  @override
  void dispose() {
    
    super.dispose();
    pageNo = 1;
  }

  /// 商品展示
  _commodityContent(item){
    List list = CommonUtil.skuNameSplit(item.skuName);
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // 商品图片
          new Container(
              width: ScreenAdapter.width(120),
              height: ScreenAdapter.height(120),
              alignment: Alignment.center,
              child: new Image.network(item.skuPic,fit: BoxFit.fill,
                width: ScreenAdapter.width(100),height: ScreenAdapter.height(100),)
          ),
          // 商品描述
          new Container(
              width: (ScreenAdapter.getScreenWidth()/1.7)-4,
              padding: EdgeInsets.only(left: 10,top: 5),
              child: list!=null? new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(list.length==0?item.skuName:list[0],softWrap: true,),
                  ),
                  new Container(
                      width: double.infinity,
                      child: new Text(list.length==0?"":list[1],style: TextStyle(color: Colors.grey),)
                  ),
                  new Container(
                    padding:EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: new Text("可申请数量: ${item.quantity} 件")
                  )
                ],
              ): new Text(item.skuName,softWrap: true,)
          ),
          // 价格
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new CustomsWidget().priceTitle(price: (item.salesPrice*item.quantity).toString())
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 底部售后申请列表按钮
  Widget _afterBottom(AfterOrderModel model){
    Widget widget = Container();
    if(model.status==10||model.status==30){
      // 显示取消售后
      widget = new Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppConfig.assistLineColor))
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                child: RaisedButton(
                  color: AppConfig.assistLineColor,
                  textColor: Colors.black,
                  onPressed: (){
                    // 取消售后
                    CustomsWidget().customShowDialog(context: context,content: "确定取消售后吗？",
                    onPressed: (){
                      // 取消售后请求
                      _afterServiceProvide.cancelAfterOrder(model.rmaID).then((item){
                        if(item!=null&&item.data){
                          CustomsWidget().showToast(title: "取消成功");
                          _afterServiceProvide.removeOrder(model);
                          pageNo= 1;
                          this._loadData(pageNo: pageNo);
                          Navigator.pop(context);
                        }
                      });
                    });
                  },
                  child: new Text("取消售后"),
                ),
              ),
              model.status==30?
              new Container(
                margin: EdgeInsets.only(left: 20),
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: (){
                    // 寄回商品
                    _afterServiceProvide.afterOrderModel = model;
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return AfterGoodsPage();
                      }
                    ));
                  },
                  child: new Text("寄回商品"),
                ),
              ):Container()
            ],
          )
      );
    }else if(model.status==35||model.status==40){
      // 退货物流
      widget = new Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: AppConfig.assistLineColor))
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Container(
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  onPressed: () async{
                    // 退货物流
                    _afterServiceProvide.afterOrderModel = model;
                    // 退货物流请求
                    if(model.waybillNo!=null){
                      _getShipperDetail();

                    }
                  },
                  child: new Text(model.syncStatus<3?"退货物流":"换货物流"),
                ),
              ),
            ],
          )
      );
    }
    return widget;
  }

  /// 底部操作按钮,动态显示底部操作栏
  /// 售后申请列表底部按钮
  Provide<AfterServiceProvide> _bottomConditionBtn(OrderDetailModel item){
    /**
     *  // 退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
        int rmaPolicy;
        // 是否申请售后，1已申请 0未申请
        bool rearequested;
        // 是否在可退换时间内，0：不可申请，1：可申请
        bool rmaInPeriod;
     */
    return Provide<AfterServiceProvide>(
      builder: (BuildContext context,Widget widget,AfterServiceProvide provide ){
        widget=Container();
        if(item.rmaPolicy>0&&!item.rmaRequested&&item.rmaInPeriod){
          // 申请售后
          widget = new Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: AppConfig.assistLineColor))
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    child: RaisedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: (){
                        // 跳转申请售后
                        _afterServiceProvide.orderDetailModel = item;
                        _afterServiceProvide.count = item.quantity;
                        _afterServiceProvide.clearReasonList();
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return AfterApplyPage();
                            }
                        ));
                      },
                      child: new Text("申请售后"),
                    ),
                  )
                ],
              )
          );
        }else if(item.rmaPolicy==0){
          // 此商品不支持退换货
          widget = _textDesc("此商品不支持退换货");
        }else if(item.rmaPolicy>0&&item.rmaRequested&&item.rmaInPeriod){
          widget = new Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: AppConfig.assistLineColor))
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    child: RaisedButton(
                      disabledColor: AppConfig.assistLineColor,
                      disabledTextColor: Colors.grey,
                      child: new Text("已申请售后"),
                    ),
                  )
                ],
              )
          );
        }else if(item.rmaPolicy>0&&!item.rmaRequested&&!item.rmaInPeriod){
          widget = _textDesc("该商品已超过7天售后期");
        }
        return widget;
      },
    );
  }

  /// 文字描述
  Widget _textDesc(String title){
    return new Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppConfig.assistLineColor))
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(left: 20,top: 10),
            child: new Text(title,style: TextStyle(color: AppConfig.blueBtnColor,
                fontSize: ScreenAdapter.size(26)
            ),),
          )
        ],
      ),
    );
  }

  /// 加载列表数据
  _loadData({int pageNo}){
    String method;
    switch(idx){
      case 0:
        method = "/api/eshop/returnableitems?pageNo=$pageNo&pageSize=8";
        break;
      case 1:
        method = "/api/eshop/salesrma/applying?pageNo=$pageNo&pageSize=8";
        break;
      case 2:
        method = "/api/eshop/salesrma/forARefund?pageNo=$pageNo&pageSize=8";
        break;
      case 3:
        method = "/api/eshop/salesrma/inHand?pageNo=$pageNo&pageSize=8";
        break;
      case 4:
        method = "/api/eshop/salesrma?pageNo=$pageNo&pageSize=8";
        break;
    }

    if(pageNo==1){
      _afterServiceProvide.clearList();
    }
    _afterServiceProvide.listData(method: method).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        if(idx==0){
          _afterServiceProvide.setList(OrderDetailModelList.fromJson(item.data).list);
        }else{
          // 售后模型
          _afterServiceProvide.setList(AfterOrderModelList.fromJson(item.data).list);
        }
      }
    }, onError: (e) {});
  }

  /// 详情请求
  _loadAfterDetail(int rmaID){
    _afterServiceProvide.getAfterDetail(rmaID).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        // 设置详情数据
        _afterServiceProvide.afterOrderModel = AfterOrderModel.fromJson(item.data);
      }
    }, onError: (e) {});
  }

  /// 退货物流请求
  _getShipperDetail(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return AfterLogisticsPage();
        }
    ));

  }
}