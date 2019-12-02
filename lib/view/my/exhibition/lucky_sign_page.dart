import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/exhibition/lucky_sign_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/shopping/high_commodity_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/exhibition/luck_sign_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

/// 我的中签
class LuckySignPage extends PageProvideNode{
  final LuckSignProvide _luckSignProvide = LuckSignProvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  LuckySignPage(){
    mProviders.provide(Provider<LuckSignProvide>.value(_luckSignProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return LuckySignContent(_luckSignProvide,_detailProvide,_cartProvide);
  }
}

class LuckySignContent extends StatefulWidget {
  final LuckSignProvide _luckSignProvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  LuckySignContent(this._luckSignProvide,this._detailProvide,this._cartProvide);
  @override
  _LuckySignContentState createState() => new _LuckySignContentState();
}

class _LuckySignContentState extends State<LuckySignContent> {
  List<LuckySignModel> _list = List();
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide _cartProvide;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: new Text("我的中签",style: TextStyle(fontSize: ScreenAdapter.size((30)),
            fontWeight: FontWeight.w900)),
      ),
      body: _list.length>0? ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              color: Colors.white,
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children:<Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                          width: ScreenAdapter.width(220),
                          height: ScreenAdapter.height(220),
                          alignment: Alignment.center,
                          child: new CachedNetworkImage(imageUrl:"${_list[index].prodPic}${ConstConfig.BANNER_TWO_SIZE}",fit: BoxFit.fill,)
                      ),
                      Expanded(
                        child: new Container(
                            padding: EdgeInsets.only(left: 5,top: 5,right: 10),
                            alignment: Alignment.centerLeft,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: new Text(_list[index].prodName,softWrap: true,),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("限购: ${_list[index].panicBuyQtyPerAcct.toString()} 件",style: TextStyle(
                                        color: AppConfig.blueBtnColor
                                    ),),
                                    Text("¥ ${_list[index].salesPriceRange}",style: TextStyle(
                                        fontWeight: FontWeight.w800,fontSize: ScreenAdapter.size(32)
                                    ),)
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("有效时间 ${_list[index].expiryTime}",style: TextStyle(
                                      color: Colors.grey
                                  ),),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 20),
                    child: RaisedButton(
                      onPressed: (){
                        widget._luckSignProvide.getDetail(_list[index].prodID).doOnListen(() {
                          print('doOnListen');
                        })
                            .doOnCancel(() {})
                            .listen((item) {
                          ///加载数据
                          print('listen data->$item');
                          if(item!=null&&item.data!=null){
                            // 商品详情
                            CommodityModels models = CommodityModels.fromJson(item.data);
                            _detailProvide.clearCommodityModels();
                            _detailProvide.prodId = models.prodID;
                            /// 加载详情数据
                            _detailProvide.setCommodityModels(models);
                            _detailProvide.setInitData();
                            _cartProvide.setInitCount();
                            _detailProvide.isBuy = false;

                            // 跳转抢购商品
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return HighCommodityPage();
                                }
                            ));
                          }
                        }, onError: (e) {});
                      },
                      textColor: Colors.white,
                      color: AppConfig.blueBtnColor,
                      child: Text("立即使用"),
                    ),
                  )
                ],
              ),
            );
          }):Column(
        children: CustomsWidget().noDataWidget(),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;
    _loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _loadData(){
    widget._luckSignProvide.getSignList().doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        setState(() {
          _list = LuckySignModelList.fromJson(item.data).list;
        });
      }
    }, onError: (e) {});
  }
}