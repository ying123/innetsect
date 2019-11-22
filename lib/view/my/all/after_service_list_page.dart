import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/all/after_apply_page.dart';
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
            provide.clearList();
            pageNo = 1;
            await this._loadData(pageNo: pageNo);
          },
          onLoad: () async{
            await this._loadData(pageNo: ++pageNo);
          },
          child: <Widget>[
            // 数据内容
            SliverList(
                delegate: SliverChildListDelegate(
                    provide.list.map((item){
                      return new Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 5),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            // 订单号
                            new Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: new Text("订单号:  ${item.orderNo}"),
                            ),
                            // 商品展示
                            _commodityContent(item),
                            // 底部操作按钮
                            _bottomConditionBtn(item)
                          ],
                        ),
                      );
                    }).toList()
                )
            )
          ],
        );
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _afterServiceProvide ??= widget._afterServiceProvide;
    _easyRefreshController = EasyRefreshController();
    setState(() {
      idx = widget.idx;
    });
    _loadData(pageNo: pageNo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              height: ScreenAdapter.height(140),
              width: (ScreenAdapter.getScreenWidth()/1.7)-4,
              padding: EdgeInsets.only(left: 10,top: 5),
              child: list!=null? new Column(
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    child: new Text(list[0],softWrap: true,),
                  ),
                  new Container(
                      width: double.infinity,
                      child: new Text(list[1],style: TextStyle(color: Colors.grey),)
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
                new CustomsWidget().priceTitle(price: item.salesPrice.toString())
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 底部操作按钮,动态显示底部操作栏
  Widget _bottomConditionBtn(CommodityModels item){
    /**
     *  // 退换策略,0：此商品不支持退换货,>0申请售后，1.退货，2.换货,3.可退换
        int rmaPolicy;
        // 是否申请售后，1已申请 0未申请
        bool rearequested;
        // 是否在可退换时间内，0：不可申请，1：可申请
        bool rmaInPeriod;
     */
    Widget widget=Container();
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
                    _afterServiceProvide.commodityModels = item;
                    _afterServiceProvide.count = item.quantity;
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
      widget = new Container(
          decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppConfig.assistLineColor))
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 20),
                child: new Text("此商品不支持退换货",style: TextStyle(color: AppConfig.blueBtnColor,
                    fontSize: ScreenAdapter.size(26)
                ),),
              )
            ],
          ),
      );
    }
    return widget;
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

    _afterServiceProvide.listData(method: method).doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        if(idx==0){
          _afterServiceProvide.setList(CommodityList.fromJson(item.data).list);
        }else{
          // 售后模型
        }
      }
    }, onError: (e) {});
  }
}