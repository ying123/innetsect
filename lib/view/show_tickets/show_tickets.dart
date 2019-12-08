import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/exhibition/ticket_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/shopping/high_commodity_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/show_tickets/show_tickets_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

class ShowTicketsPage extends PageProvideNode {
  final ShowTicketsProvide _provide = ShowTicketsProvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;
  Map showId;
  ShowTicketsPage({this.showId}) {
    mProviders.provide(Provider<ShowTicketsProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return ShowTicketsContentPage(_provide,showId,_detailProvide,_cartProvide,_mainProvide);
  }
}

class ShowTicketsContentPage extends StatefulWidget {
  final ShowTicketsProvide _provide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final MainProvide _mainProvide;
  Map showId;
  ShowTicketsContentPage(this._provide,this.showId,this._detailProvide,this._cartProvide,
      this._mainProvide);
  @override
  _ShowTicketsContentPageState createState() => _ShowTicketsContentPageState();
}

class _ShowTicketsContentPageState extends State<ShowTicketsContentPage> {
ShowTicketsProvide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??= widget._provide;
    _loadTickets();
  }
  _loadTickets(){
    _provide.tickets(widget._mainProvide.splashModel.exhibitionID,widget.showId['shopID']).doOnListen((){

    }).listen((item){
      if (item!= null) {
        setState(() {
          _provide.addTickets(TicketModelList.fromJson(item.data).list);
        });
      }
    },onError: (e, stack){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar:  CustomsWidget().customNav(context: context,
          widget: new Text("展会门票",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900)),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _showTicketsList(),
       
          
          ],
        ));
  }

  Provide<ShowTicketsProvide> _showTicketsList() {
    return Provide<ShowTicketsProvide>(
      builder:
          (BuildContext context, Widget child, ShowTicketsProvide provide) {
        var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
        return Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: provide.showTickets.map((value) {
              return InkWell(
                onTap: () {
                  print('value$value');
                  _loadDetail(value.prodID,value.shopID);
                },
                child: Container(
                  width: itemWidth,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl:"${value.prodPic}${ConstConfig.BANNER_FOUR_SIZE}",
                            fit: BoxFit.fill,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: ScreenAdapter.height(20),),
                        child: Container(
                          height: ScreenAdapter.height(90),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '￥',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenAdapter.size(25),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                value.salesPriceRange,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenAdapter.size(35),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(value.prodName,style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenAdapter.size(28)
                      ),)
                      // Padding(
                      //   padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      //   child: Container(
                      //     child: Text(
                      //       value['describe'],
                      //       style: TextStyle(
                      //         color: Color.fromRGBO(120, 120, 120, 1.0),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

_loadDetail(int prodID,int shopID){
  widget._detailProvide.clearCommodityModels();
  widget._detailProvide.prodId = prodID;
  /// 加载详情数据
  widget._detailProvide.detailData(types: shopID,prodId:prodID,context: context )
      .doOnListen(() {
    print('doOnListen');
  })
      .doOnCancel(() {})
      .listen((item) {
    ///加载数据
    print('listen data->$item');
    CommodityModels models = CommodityModels.fromJson(item.data);
    widget._detailProvide.setCommodityModels(models);
    widget._detailProvide.setInitData();
    widget._detailProvide.prodId = models.prodID;
    widget._cartProvide.setInitCount();
    widget._detailProvide.isBuy = false;
    widget._cartProvide.setMode(mode: "single");
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return HighCommodityPage(pages: "tickets",);
        }
    ));
//      _provide
  }, onError: (e) {});
}
}
