import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_badges_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
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
  final String pages;

  SearchScreenPage({this.pages}){
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return SearchScreenContent(_searchProvide,_commodityListProvide,
        _detailProvide,_cartProvide,pages: pages,);
  }
}

class SearchScreenContent extends StatefulWidget {
  final SearchProvide _searchProvide;
  final CommodityListProvide _commodityListProvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final String pages;
  SearchScreenContent(this._searchProvide,this._commodityListProvide,
      this._detailProvide,this._cartProvide,{this.pages});
  @override
  _SearchScreenContentState createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent>
    with SingleTickerProviderStateMixin{
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
  TabController _tabController ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget:new Text(
       _searchProvide.searchValue
        ,style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),) ,
      ),
      body:
//      NestedScrollView(
//          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
//            return <Widget>[
////              SliverAppBar(
////                elevation: 0,
////                automaticallyImplyLeading: false,
////                expandedHeight: 200.0,
////                floating: true,
////                pinned: true,
////                flexibleSpace: FlexibleSpaceBar(
////                    centerTitle: true,
////                    title: Text(
////                      "我是可以跟着滑动的title",
////                    ),
////                    background: Image.network(
////                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
////                      fit: BoxFit.fill,
////                    )
////                ),
////                bottom: TabBar(
////                  isScrollable: true,
////                  controller: _tabController,
////                  tabs: <Widget>[
////                    Tab(text: "111",),
////                    Tab(text: "222",)
////                  ],
////                ),
////              ),
//              SliverPersistentHeader(
//                delegate: CustomSliverHeaderDelegate(
//                    max: 60,
//                    min: 60,
//                    child: new Container(
//                      width: double.infinity,
//                      color: Colors.white,
//                      height: ScreenAdapter.height(80),
//                      child: new Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: navList.map((item){
//                          if(item['index']==1){
//                            return Expanded(
//                              child: InkWell(
//                                onTap: (){
//                                  // 判断价格点击
//                                  navList[0]['isSelected']=false;
//                                  navList[2]['isSelected']=false;
//                                  item['isSelected'] = !item['isSelected'];
//                                  if(item['isSelected']){
//                                    setState(() {
//                                      item['direction'] = 'up';
//                                      sort = "p.defSalesPrice ASC";
//                                    });
//                                  }
//
//                                  if(!item['isSelected']){
//                                    setState(() {
//                                      item['direction'] = 'down';
//                                      sort = "p.defSalesPrice DESC";
//                                    });
//                                  }
//                                  pageNo = 1;
//                                  _commodityListProvide.clearList();
//                                  _loadList(pageNos: pageNo);
//                                },
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                  children: <Widget>[
//                                    Expanded(
//                                      flex: 1,
//                                      child: Container(
//                                        alignment: Alignment.centerRight,
//                                        child: Text(item['title'],style: TextStyle(color: item['direction']!=null?Colors.black:Colors.black26)),
//                                      ),
//                                    ),
//                                    Expanded(
//                                      flex: 1,
//                                      child: Column(
//                                        mainAxisAlignment: MainAxisAlignment.center,
//                                        crossAxisAlignment: CrossAxisAlignment.center,
//                                        children: <Widget>[
//                                          Container(
//                                            height: ScreenAdapter.height(10),
//                                            alignment: Alignment.bottomLeft,
//                                            child: Icon(Icons.arrow_drop_up,size: 16,color: item['isSelected']&&item['direction']!=null&&item['direction']=="up"?Colors.black:Colors.black26,),
//                                          ),
//                                          Container(
//                                            height: ScreenAdapter.height(10),
//                                            margin: EdgeInsets.only(bottom: 6),
//                                            alignment: Alignment.topLeft,
//                                            child: Icon(Icons.arrow_drop_down,size: 16,color: !item['isSelected']&&item['direction']!=null&&item['direction']=="down"?Colors.black:Colors.black26),
//                                          )
//                                        ],
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            );
//                          }else{
//                            return Expanded(
//                              child: InkWell(
//                                onTap: (){
//                                  navList.forEach((val){
//                                    val['isSelected']=false;
//                                    val['direction']=null;
//                                  });
//
//                                  // 筛选点击
//                                  String sorts;
//                                  switch(item['index']){
//                                    case 0:
//                                      sorts = 'c.soldCount DESC';
//                                      break;
//                                    case 2:
//                                      sorts = 'arrivingDate DESC';
//                                      break;
//                                  }
//                                  setState(() {
//                                    item['isSelected'] = !item['isSelected'];
//                                    sort = sorts;
//                                  });
//                                  pageNo = 1;
//                                  _commodityListProvide.clearList();
//                                  _loadList(pageNos: pageNo);
//                                },
//                                child: Container(
//                                  color: Colors.white,
//                                  alignment: Alignment.center,
//                                  child: Text(item['title'],style: TextStyle(color: item['isSelected']?Colors.black:Colors.black26),),
//                                ),
//                              ),
//                            );
//                          }
//                        }).toList(),
//                      ),
//                    )
//                ),
//                pinned: true,
//              )
//            ];
//          },
////        body: TabBarView(
////          controller: _tabController,
////          children: <Widget>[
////            _listWidget(),
////            _listWidget()
////          ],
////        ),
//          body: _listWidget(),
//      )


      Stack(
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    alignment: Alignment.bottomLeft,
                                    child: Icon(Icons.arrow_drop_up,size: 16,color: item['isSelected']&&item['direction']!=null&&item['direction']=="up"?Colors.black:Colors.black26,),
                                  ),
                                  Container(
                                    height: ScreenAdapter.height(10),
                                    margin: EdgeInsets.only(bottom: 6),
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
    _searchProvide ??= widget._searchProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;

    _easyRefreshController = EasyRefreshController();
    _tabController = TabController(length: 2,vsync: this);
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
    double itemWidth = (ScreenAdapter.getScreenWidth()-30)/2;
    return Provide<CommodityListProvide>(
      builder: (BuildContext context,Widget widget,CommodityListProvide provide){
        return new ListWidgetPage(
          controller: _easyRefreshController,
          onRefresh:() async{
            print('onRefresh');
            this.pageNo = 1;
            _commodityListProvide.clearList();
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
                      children: _commodityListProvide.list.length>0? _commodityListProvide.list.map((item){
                        print(item);
                        return new InkWell(
                          onTap: (){
                            /// 跳转详情
                            _loadDetail(item.prodID,item.shopID);

                          },
                          child: new Container(
                            width: itemWidth,
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: new Column(
                              children: <Widget>[
                                // 商品图片
                                _imageWidget(item.prodPic,item.badges),
                                // 价格 购物车图标
                                _priceAndCartWidget(item.salesPriceRange.toString(),item.originalPrice.toString(),item.prodID,item.shopID),
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
  Widget _imageWidget(String image,List<CommodityBadgesModel> badges){
    return Stack(
      children: <Widget>[
        new Container(
            width: double.infinity,
            height: ScreenAdapter.height(320),
            child: image!=null? CachedNetworkImage(
              imageUrl:"$image${ConstConfig.BANNER_TWO_SIZE}",
              fit: BoxFit.fitWidth,
            ):Image.asset("assets/images/default/default_img.png",fit: BoxFit.fitWidth,)
        ),
        Positioned(
          top: 0,
          right: 0,
          child: badges!=null&&badges.length>0?
          Row(
            children: badges.map((item){
              return Container(
                width: ScreenAdapter.width(80),
                height: ScreenAdapter.height(40),
                color: AppConfig.blueBtnColor,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 5),
                child: Text(item.name,style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenAdapter.size(24)
                ),),
              );
            }).toList(),
          ):Container(width: 0,height: 0,),
        )
      ],
    );
  }

  /// 价格和购物车
  Widget _priceAndCartWidget(String price,String originalPrice,int prodID,int shopID){
    Widget widgets = Container();
    if(originalPrice!='null'){
      String _price = price;
      if(price.indexOf("-")>-1){
        _price = price.split("-")[0].toString();
      }
      if(double.parse(_price)<double.parse(originalPrice)){
        widgets = Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomsWidget().priceTitle(price: originalPrice,decoration: TextDecoration.lineThrough,fontSize: ScreenAdapter.size(20),
              fontWeight: FontWeight.w400,color: Colors.grey
          ),
        );
      }
    }
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomsWidget().priceTitle(price: price),
                widgets
              ],
            ),
          ),
          new Container(
            width: ScreenAdapter.width(28),height: ScreenAdapter.height(28),
            child: new InkWell(
              onTap: (){
                // 购物车
                _loadDetail(prodID,shopID);
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
        if(url.indexOf("/api/promotion")>-1){
          setState(() {
            _commodityListProvide.addList(CommodityList.fromJson(items.data['products']).list);
          });
        }else{
          setState(() {
            _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
          });
        }
      }

    }, onError: (e) {});
  }

  _loadDetail(int prodID,int shopID){
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
    /// 加载详情数据
//    Loading.ctx=context;
//    Loading.show();
    _detailProvide.detailData(prodId: prodID,types: shopID,context: context)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
//          Loading.remove();
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        _detailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
        _detailProvide.setInitData();
        _cartProvide.setInitCount();
        _detailProvide.isBuy = false;
        Navigator.push(context, MaterialPageRoute(
            builder:(context){
              return new CommodityDetailPage(pages: widget.pages);
            }
        )
        );
      }

//      _provide
    }, onError: (e) {});
  }
}
