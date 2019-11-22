import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';

class SearchScreenPage extends PageProvideNode{

  final SearchProvide _searchProvide = SearchProvide.instance;
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;

  SearchScreenPage(){
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SearchScreenContent(_searchProvide,_commodityListProvide,_detailProvide,_cartProvide);
  }
}

class SearchScreenContent extends StatefulWidget {
  final SearchProvide _searchProvide;
  final CommodityListProvide _commodityListProvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  SearchScreenContent(this._searchProvide,this._commodityListProvide,this._detailProvide,this._cartProvide);
  @override
  _SearchScreenContentState createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  SearchProvide _searchProvide;
  CommodityListProvide _commodityListProvide;
  EasyRefreshController _easyRefreshController;
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide _cartProvide;

  List navList = [ {'index': 0,'title': "销量",'isSelected': false,'direction':null},
                    {'index': 1,'title': "价格",'isSelected': false,'direction':null},
                    {'index': 2,'title': "新品",'isSelected': false,'direction':null}];

  int pageNo = 1;
  String sort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget:new Text(
        _searchProvide.searchValue,style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),) ,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
            padding: EdgeInsets.only(top: 10),
            child: _listWidget(),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: new Container(
              width: double.infinity,
              color: Colors.white,
              height: ScreenAdapter.height(80),
              child: new Row(
                children: navList.map((item){
                  if(item['index']==1){
                    return Expanded(
                      child: InkWell(
                        onTap: (){
                          // 判断价格点击
                          navList[0]['isSelected']=false;
                          navList[2]['isSelected']=false;
                          item['isSelected'] = !item['isSelected'];
                          if(item['isSelected']){
                            setState(() {
                              item['direction'] = 'up';
                              sort = "p.defSalesPrice ASC";
                            });
                          }

                          if(!item['isSelected']){
                            setState(() {
                              item['direction'] = 'down';
                              sort = "p.defSalesPrice DESC";
                            });
                          }
                          pageNo = 1;
                          _commodityListProvide.clearList();
                          _loadList(pageNos: pageNo);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(item['title'],style: TextStyle(color: item['direction']!=null?Colors.black:Colors.black26)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.bottomLeft,
                                    child: Icon(Icons.arrow_drop_up,size: 16,color: item['isSelected']&&item['direction']!=null&&item['direction']=="up"?Colors.black:Colors.black26,),
                                  ),
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    alignment: Alignment.topLeft,
                                    child: Icon(Icons.arrow_drop_down,size: 16,color: !item['isSelected']&&item['direction']!=null&&item['direction']=="down"?Colors.black:Colors.black26),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Expanded(
                      child: InkWell(
                        onTap: (){
                          navList.forEach((val){
                            val['isSelected']=false;
                            val['direction']=null;
                          });

                          // 筛选点击
                          String sorts;
                          switch(item['index']){
                            case 0:
                              sorts = 'c.soldCount DESC';
                              break;
                            case 2:
                              sorts = 'arrivingDate DESC';
                              break;
                          }
                          setState(() {
                            item['isSelected'] = !item['isSelected'];
                            sort = sorts;
                          });
                          pageNo = 1;
                          _commodityListProvide.clearList();
                          _loadList(pageNos: pageNo);
                        },
                        child: Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(item['title'],style: TextStyle(color: item['isSelected']?Colors.black:Colors.black26),),
                        ),
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchProvide ??= widget._searchProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;

    _easyRefreshController = EasyRefreshController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    navList.forEach((item){
      item['isSelected']=false;
      item['direction']=null;
    });
  }

  /// 筛选商品数据列表展示
  Provide<CommodityListProvide> _listWidget(){
    return Provide<CommodityListProvide>(
      builder: (BuildContext context,Widget widget,CommodityListProvide provide){
        double itemWidth = (ScreenAdapter.getScreenWidth()-30)/2;
        return new ListWidgetPage(
          controller: _easyRefreshController,
          onRefresh:() async{
            print('onRefresh');
            this.pageNo = 1;
            provide.clearList();
            await _loadList(pageNos: pageNo);
          },
          onLoad: () async{
            await _loadList(pageNos: ++ pageNo);
          },
          child: <Widget>[
            // 数据内容
            SliverList(
                delegate:
                SliverChildListDelegate([
                  new Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: new Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: provide.list.length>0? provide.list.map((item){
                        print(item);
                        return new InkWell(
                          onTap: (){
                            /// 跳转详情
//                            _detailProvide.clearCommodityModels();
//                            _detailProvide.prodId = item.prodID;
//                            Navigator.push(context, MaterialPageRoute(
//                                builder:(context){
//                                  return new CommodityDetailPage();
//                                }
//                            )
//                            );
                          },
                          child: new Container(
                            width: itemWidth,
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: new Column(
                              children: <Widget>[
                                // 商品图片
                                _imageWidget(item.prodPic),
                                // 价格 购物车图标
                                _priceAndCartWidget(item.salesPriceRange.toString(),item.prodID),
                                // 描述
                                _textWidget(item.prodName)
                              ],
                            ),
                          ),
                        );
                      }).toList():[],
                    ),
                  )
                ])
            ),
          ],
        );
      },
    );
  }

  /// 商品图片
  Widget _imageWidget(String image){
    return new Stack(
      children: <Widget>[
        new Positioned(
            top:0,
            right: 0,
            child: new Container(
              padding: EdgeInsets.all(5),
              child: new Text("标签栏",style: TextStyle(fontSize: ScreenAdapter.size(16.0)),),
            )
        ),
        new Container(
            width: double.infinity,
            height: ScreenAdapter.height(320),
            child: Image.network(
              image,
              fit: BoxFit.fitWidth,
            )
        )
      ],
    );
  }

  /// 价格和购物车
  Widget _priceAndCartWidget(String price,int prodID){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: CustomsWidget().priceTitle(price: price),
          ),
          new Container(
            width: ScreenAdapter.width(28),height: ScreenAdapter.height(28),
            child: new InkWell(
              onTap: (){
                // 购物车
                _loadDetail(prodID);
                CommodityModalBottom.showBottomModal(context:context);
              },
              child: new Image.asset("assets/images/mall/shop_bucket.png",
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 描述
  Widget _textWidget(String text){
    return new Container(
      padding: EdgeInsets.only(left: 6,right: 5,bottom: 5),
      height: ScreenAdapter.height(80),
      alignment: Alignment.topLeft,
      child: new Text(text,softWrap: true,maxLines: 2,textAlign: TextAlign.left,
        style: TextStyle(fontSize: ScreenAdapter.size(26)),
      ),
    );
  }

  _loadList({int pageNos}){
    String url = _commodityListProvide.requestUrl+'&pageNo=$pageNos&pageSize=8';
    if(sort!=null){
      url=_commodityListProvide.requestUrl+'&sort=$sort&pageNo=$pageNos&pageSize=8';
    }
    _searchProvide.onSearch(url).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
      if(items!=null&&items.data!=null){
        if(!mounted) return;
        setState(() {
          _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
        });
      }

    }, onError: (e) {});
  }

  _loadDetail(int prodID){
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
    /// 加载详情数据
    _detailProvide.detailData()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      _detailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
      _detailProvide.setInitData();
      _cartProvide.setInitCount();
      _detailProvide.isBuy = false;
//      _provide
    }, onError: (e) {});
  }
}
