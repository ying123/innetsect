import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:innetsect/base/base.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/order/order_detail_page.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';
import 'package:innetsect/view/widget/counter_widget.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

/// 抢购商品视图
class HighCommodityPage extends PageProvideNode{

  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  final String pages;
  HighCommodityPage({this.pages}){
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<OrderDetailProvide>.value(_orderDetailProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return HighCommodityContent(_detailProvide,_cartProvide,_orderDetailProvide,pages: pages,);
  }
  
}

class HighCommodityContent extends StatefulWidget {
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final OrderDetailProvide _orderDetailProvide;
  final String pages;
  HighCommodityContent(this._detailProvide,this._cartProvide,this._orderDetailProvide,{this.pages});

  @override
  _HighCommodityContentState createState() => new _HighCommodityContentState();
}

class _HighCommodityContentState extends State<HighCommodityContent> {
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide _cartProvide;
  ScrollController _scrollController;
  String _promptingMessage;
  bool _isShowBottom = false;
  DateTime _startTime;
  DateTime _endTime;
  Timer _timer;
  String _times="";
  String html;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget:Container()),
      body: _contentWidget(),
      bottomSheet: _bottomWidget(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;
    _scrollController = ScrollController();

    if(_detailProvide.commodityModels.promptingMessage!=null){
      setState(() {
        _promptingMessage = _detailProvide.commodityModels.promptingMessage;
      });
    }


    // 判断显示倒计时
    if(_detailProvide.commodityModels!=null&&
        _detailProvide.commodityModels.panicBuyingStart!=null
        &&_detailProvide.commodityModels.panicCountdownTime!=null){
      _startTime = DateTime.parse(_detailProvide.commodityModels.panicBuyingStart);
//      _endTime = DateTime.parse(_detailProvide.commodityModels.panicCountdownTime);
      _endTime = DateTime.now();
      bool flag = _startTime.isAfter(_endTime);
      if(flag){

        if(!mounted) return;
        setState(() {
          _isShowBottom = true;
        });

        // 计算时间差
        var difference = _startTime.difference(_endTime);
        int sec = difference.inSeconds-1;
        Timer.periodic(Duration(seconds: 1), (Timer timer){
          -- sec;
          int seconds = (sec%60).toInt();
          int minutes = (sec~/60).toInt();
          int hours = (sec~/(24*3600)).toInt();
          String secondsStr = seconds<10?"0${seconds.toString()}":seconds.toString();
          String minutesStr = minutes<10?"0${minutes.toString()}":minutes.toString();
          String hoursStr = hours<10?"0${hours.toString()}":hours.toString();
          if(!mounted) return;
          if(sec<1){
            setState(() {
              _isShowBottom = false;
            });
            _timer.cancel();
          }else{
            setState(() {
              _times =  '距抢购倒计时 $hoursStr:$minutesStr:$secondsStr';
            });
          }
        });
      }
    }

    if(widget.pages=="tickets"){
      _loadHtml();
    }
  }

  /// 加载webview
  _loadHtml() async{
    await widget._detailProvide.getDetailHtml().then((item){
      print(item);
      if(item.data!=null){
        setState(() {
          html = item.data;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isShowBottom = false;
    _timer?.cancel();
    _timer = null;
  }

  Widget _bottomWidget(){
    Widget widgets = Container(width: 0,height: 0,);
    if(_promptingMessage==null&&!_isShowBottom
    &&_detailProvide.commodityModels!=null&&
        _detailProvide.commodityModels.orderable){
      if(widget.pages=="tickets"){
        widgets = Container(
          width: double.infinity,
          height: ScreenAdapter.height(120),
          padding: EdgeInsets.only(right: 20,left: 20),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: _iconAndTextMerge(title:"客服",icon: "assets/images/mall/service_p_icon.png"
                    ,onTap: (){
                      CustomsWidget().serviceWidget(context: context);
                    }),
              ),
              Expanded(
                child: RaisedButton(
                  onPressed:(){
                    // 票务购买界面
                    if(!isLogin()){
                      if(_detailProvide.skusModel.qtyInHand ==0){
                        CustomsWidget().showToast(title: "没有库存");
                      }else{
                        // 跳转订单详情
                        List json = [{
                          "acctID": UserTools().getUserData()['id'],
                          "shopID":_detailProvide.commodityModels.shopID,
                          "prodID":_detailProvide.commodityModels.prodID,
                          "presale":_detailProvide.commodityModels.presale,
                          "skuCode":_detailProvide.skusModel.skuCode,
                          "skuName":_detailProvide.skusModel.skuName,
                          "skuPic":_detailProvide.skusModel.skuPic,
                          "quantity":_cartProvide.count,
                          "unit": _detailProvide.commodityModels.unit,
                          "prodCode": _detailProvide.commodityModels.prodCode,
                          "salesPrice":_detailProvide.commodityModels.salesPrice,
                          "allowPointRate":_detailProvide.commodityModels.allowPointRate
                        }];
                        _detailProvide.createShopping(json,context)
                            .doOnListen(() {
                          print('doOnListen');
                        })
                            .doOnCancel(() {})
                            .listen((item) {
                          ///加载数据,订单详情
                          print('listen data->$item');
                          if(item.data!=null){
                            OrderDetailModel model = OrderDetailModel.fromJson(item.data);
                            widget._orderDetailProvide.orderDetailModel = model;
                            widget._detailProvide.pages = "exhibition";
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context){
                                  return new OrderDetailPage();
                                })
                            );
                          }
                        }, onError: (e) {
                          print(e);
                        });
                      }
                    }
                  },
                  textColor: Colors.white,
                  color: AppConfig.blueBtnColor,
                  child: Text("立即购买"),
                ),
              )
            ],
          ),
        );
      }else{
        widgets = Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 20,left: 20),
          color: Colors.white,
          child: RaisedButton(
            onPressed:(){
              // 弹出购买界面
              _detailProvide.setInitData();
              _cartProvide.setInitCount();
              _detailProvide.isBuy = false;
              _detailProvide.pages = "highCommodity";
              CommodityModalBottom.showBottomModal(context:context);
            },
            textColor: Colors.white,
            color: AppConfig.blueBtnColor,
            child: Text("立即购买"),
          ),
        );
      }
    }else if(_promptingMessage==null&&_isShowBottom){
      widgets = Container(
        width: double.infinity,
        height: ScreenAdapter.height(80),
        color: Colors.white,
        padding: EdgeInsets.only(right: 20,left: 20,bottom: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppConfig.assistLineColor,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Text("$_times",style: TextStyle(
          color: Colors.black,fontSize: ScreenAdapter.size(28),
          fontWeight: FontWeight.w600
        ),),
      );
    }
    return widgets;
  }

  /// 商品详情内容区域
  Widget _contentWidget(){
    return new ListView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      children: <Widget>[
        new Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(563),
          color: Colors.white,
          child: _swiperWidget(),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          color: Colors.white,
          child: _comTitleProdName(),
        ),
        Container(
          width: ScreenAdapter.width(750),
          padding: EdgeInsets.only(top: 20),
          alignment: Alignment.center,
          color: Colors.white,
          child: _comTitleSalesPrice(),
        ),
        widget._detailProvide.commodityModels.presaleDesc!=null?
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              color: Colors.white,
              child: Text(widget._detailProvide.commodityModels.presaleDesc,
              style: TextStyle(color: Colors.grey),),
            ):Container(height: 0,width: 0,),
        _promptingMessage!=null&&widget.pages==null?
          Container(
            width: ScreenAdapter.width(750),
            padding: EdgeInsets.only(top: 20,right: 20,left: 20),
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(_promptingMessage,style: TextStyle(
              color: AppConfig.blueBtnColor
            ),),
          ):Container(width: 0,height: 0,),

        widget.pages=="tickets"?
            Container(
              padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("购买数量",style: TextStyle(
                    color: Colors.grey,fontSize: ScreenAdapter.size(28)
                  ),),
                  CounterWidget(provide: widget._cartProvide,
                    model: widget._detailProvide.commodityModels,)
                ],
              ),
            ):Container(width: 0,height: 0,),
        widget.pages!="tickets"?Container(
          width: ScreenAdapter.width(750),
          padding: EdgeInsets.only(top: 20,right: 20,left: 20),
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: _comRemark(),
        ):Container(
          padding: EdgeInsets.only(right: 20,left: 20),
          color: Colors.white,
          child: Html(
            data: html==null?"":html,
          ),
        ),
        SizedBox(width: double.infinity,height: ScreenAdapter.height(80),)
      ],
    );
  }

  /// _swiperWidget
  Provide<CommodityDetailProvide> _swiperWidget(){
    return Provide<CommodityDetailProvide>(
      builder: (BuildContext context, Widget widget,CommodityDetailProvide provide){
        CommoditySkusModel skuModel = provide.skusModel;
        return new Swiper(
          itemBuilder: (BuildContext context,int index){
            return skuModel!=null?
            CachedNetworkImage(imageUrl: "${skuModel.pics[index].skuPicUrl}${ConstConfig.BANNER_TWO_SIZE}",)
                :new Container();
          },
          loop: false,
          itemCount: skuModel!=null?skuModel.pics.length:1,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  color: Colors.white70,              // 其他点的颜色
                  activeColor: AppConfig.blueBtnColor,      // 当前点的颜色
                  space: 2,                           // 点与点之间的距离
                  activeSize: 5,                      // 当前点的大小
                  size: 5
              )
          ),
        );
      },
    );
  }
  /// 标题 prodName
  Provide<CommodityDetailProvide> _comTitleProdName() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,
            CommodityDetailProvide provide) {
          CommodityModels models = provide.commodityModels;
          return new Text(models!=null?models.prodName:"",style: TextStyle(fontSize: ScreenAdapter.size(38),
              fontWeight: FontWeight.w800,color: _isShowBottom?Colors.grey:Colors.black
          ),);
        }
    );
  }
  /// 标题价格
  Provide<CommodityDetailProvide> _comTitleSalesPrice() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,
            CommodityDetailProvide provide) {
          CommodityModels models = provide.commodityModels;
          String price =models!=null?models.salesPrice.toString():"";
          return Text("¥ $price",style: TextStyle(
            color: _isShowBottom?Colors.grey:AppConfig.blueBtnColor,
            fontSize: ScreenAdapter.size(32)
          ),);
        }
    );
  }
  /// 标题 prodName
  Provide<CommodityDetailProvide> _comRemark() {
    return Provide<CommodityDetailProvide>(
        builder: (BuildContext context, Widget widget,
            CommodityDetailProvide provide) {
          CommodityModels models = provide.commodityModels;
          return new Text(models!=null?models.remark:"",
            softWrap: true,
            style: TextStyle(fontSize: ScreenAdapter.size(28),
            color:_isShowBottom?Colors.grey:Colors.black
          ),);
        }
    );
  }

  /// 图片和文字结合，垂直布局
  Widget _iconAndTextMerge({String title,String icon,Function() onTap}){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(icon,width: ScreenAdapter.width(32),height: ScreenAdapter.height(32),fit: BoxFit.fitWidth,),
            new Text(title,style: TextStyle(fontSize: ScreenAdapter.size(18)),)
          ],
        ),
      ),
    );
  }

  bool isLogin(){
    bool flag = false;
    if(UserTools().getUserData()==null){
      flag = true;
      Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context){
            return LoginPage();
          }
      ));
    }
    return flag;
  }
}