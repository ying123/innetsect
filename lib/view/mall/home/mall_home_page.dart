import 'package:flutter/material.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/portlets_model.dart';
import 'package:innetsect/data/mall/promotion_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/view/activity/activity_detail_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/mall/information/infor_web_page.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view/mall/web_view.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/home/mall_home_provide.dart';
import 'package:innetsect/view_model/mall/information/information_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MallHomePage extends PageProvideNode {
  final MallHomeProvide _provide = MallHomeProvide();
  final SearchProvide _searchProvide = SearchProvide();
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final InformationProvide _informationProvide = InformationProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;
  final AppNavigationBarProvide _appNavProvide = AppNavigationBarProvide.instance;
  MallHomePage(){
    mProviders.provide(Provider<MallHomeProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<InformationProvide>.value(_informationProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavProvide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return MallHomeContent(_provide,_detailProvide,_commodityListProvide,
        _searchProvide,_cartProvide,_informationProvide,_mainProvide,
        _appNavProvide);
  }

}

class MallHomeContent extends StatefulWidget {

  final MallHomeProvide _provide;
  final CommodityDetailProvide _detailProvide;
  final CommodityListProvide _commodityListProvide;
  final SearchProvide _searchProvide;
  final CommodityAndCartProvide _cartProvide;
  final InformationProvide _informationProvide;
  final MainProvide _mainProvide;
  final AppNavigationBarProvide _appNavProvide;

  MallHomeContent(this._provide,this._detailProvide,
      this._commodityListProvide,this._searchProvide,
      this._cartProvide,this._informationProvide,
      this._mainProvide,this._appNavProvide);

  @override
  _MallHomeContentState createState() => new _MallHomeContentState();
}

class _MallHomeContentState extends State<MallHomeContent> {

  CommodityDetailProvide _detailProvide;
  CommodityListProvide _commodityListProvide;
  SearchProvide _searchProvide;
  CommodityAndCartProvide _cartProvide;
  InformationProvide _informationProvide;
  MainProvide _mainProvide;
  AppNavigationBarProvide _appNavProvide;
  // 控制器
  EasyRefreshController _controller;
  // 分页
  int pageNo = 1;
  
  List<BannersModel> _bannersList=[];

  List<PortletsModel> _portletsModelList = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: Text(
          '首页',
          style: TextStyle(
              fontSize: ScreenAdapter.size(40),
              fontWeight: FontWeight.w600,
              color: AppConfig.fontPrimaryColor),
        ),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          InkWell(
            onTap: (){
              // print('抽签被点击');
              // Navigator.pushNamed(context, '/drawPage');
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20),
              child: Text(
                ''
              ),
            ),
          ),
          _mainProvide.splashModel.exhibitionID!=null?
          InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 20),
              child: Text(
                '去展会',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: ScreenAdapter.size(30),
                  color: AppConfig.fontPrimaryColor,
                ),
              ),
            ),
            onTap: () {
              _appNavProvide.currentIndex = 2;
              Navigator.pushNamed(context, '/appNavigationBarPage');
            },
          ):Container(height: 0.0,width: 0.0,)
        ],
      ),
      body: new ListWidgetPage(
        controller: _controller,
        onRefresh: () async{
          pageNo = 1;
          _clearList();
          await _loadBannerData();
        },
        onLoad: () async{
          await _loadListData();
        },
        child: <Widget>[
            // 数据内容
            SliverList(
              delegate:
                SliverChildListDelegate([
                  _setupSwiperImage(),
                  _setupListItemsContent()
                ])
            )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new EasyRefreshController();
    _detailProvide ??= widget._detailProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _searchProvide ??= widget._searchProvide;
    _cartProvide ??= widget._cartProvide;
    _informationProvide ??= widget._informationProvide;
    _mainProvide ??= widget._mainProvide;
    _appNavProvide ??= widget._appNavProvide;
    // 加载首页数据
    _loadBannerData();
  }

  ///轮播图
  Widget _setupSwiperImage() {
    return Container(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.getPixelRatio()*ScreenAdapter.height(135),
      color: Colors.white,
      margin:EdgeInsets.only(bottom: 20),
      child: Center(
        child: _bannersList.length>0?Swiper(
          loop: false,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print('第$index 页被点击=====${_bannersList[index].toString()}');
                if (index== 0) {
                  print('抽签被点击');
                   Navigator.pushNamed(context, '/drawPage');
                }

                /// 跳转商品详情
                if(_bannersList[index].redirectType==ConstConfig.PRODUCT_DETAIL){
                  List list = _bannersList[index].redirectParam.split(":");
                  _commodityDetail(types:int.parse(list[0]) ,prodID: int.parse(list[1]));
                }else if(_bannersList[index].redirectType==ConstConfig.PROMOTION){
                  /// 跳转集合搜索列表
                  _searchRequest(_bannersList[index].redirectParam);
                }else if(_bannersList[index].redirectType==ConstConfig.CONTENT_DETAIL){
                  /// 跳转资讯详情
                  _informationProvide.contentID =int.parse(_bannersList[index].redirectParam) ;
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return new InforWebPage();
                      }
                  ));
                }else if(_bannersList[index].redirectType==ConstConfig.URL){
                  /// 跳转URL
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return new WebView(url: _bannersList[index].redirectParam,);
                      }
                  ));
                }else if(_bannersList[index].redirectType == ConstConfig.ACTIVITY){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return ActivityDetailPage(activityID: int.parse(_bannersList[index].redirectParam),);
                    }
                  ));
                }
              },
              child: ClipPath(
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width:ScreenAdapter.width(750),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: "${_bannersList[index].bannerPic}${ConstConfig.BANNER_MINI_SIZE}",
                        errorWidget: (context, url, error) {
                          return Icon(Icons.error);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: _bannersList.length,
           pagination: SwiperPagination(
               builder: DotSwiperPaginationBuilder(
                 color: Colors.white70,              // 其他点的颜色
                 activeColor: AppConfig.blueBtnColor,      // 当前点的颜色
                 space: 2,                           // 点与点之间的距离
                 activeSize: 5,                      // 当前点的大小
                 size: 5
               )
           ),
          index: 0,
          duration: 300,
          scrollDirection: Axis.horizontal,
        ):new Container(),
      ),
    );
  }

  /// 商品集合
  Widget _setupListItemsContent() {
    Widget widget;
    if(_portletsModelList.length>0){
      widget = Container(
        width: ScreenAdapter.width(750),
        child: Column(
          children: _portletsModelList.map((item)=>_portletContentList(item)).toList(),
        ),
      );
    }else{
      widget = Container();
    }
    return widget;
  }

  /// 商品集合
  Widget _portletContentList(PortletsModel model){
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10,right: 10),
      child: model!=null? new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _headerContent(model.promotion),
          model.promotion!=null?_commodityContent(model.promotion.products):Container(),
          model.promotion!=null?_bottomContent(model.promotion.promotionCode,model.promotion.promotionName):Container()
        ],
      ):new Container(),
    );
  }

  /// 商品集合--头部样式
  Widget _headerContent(PromotionModel model){
    return model!=null?new FractionallySizedBox(
      child: InkWell(
        onTap: (){
          _searchRequest(model.promotionCode);
        },
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 10,top: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 1,
                      width: ScreenAdapter.width(20),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConfig.assistLineColor),
                      ),
                    ),
                  ),
                  new Text(model.promotionName,softWrap: false,
                    style: TextStyle(color: AppConfig.fontBackColor,fontWeight:FontWeight.w600,fontSize: ScreenAdapter.size(32)),),
                  Expanded(
                    child: Container(
                      height: 1,
                      width: ScreenAdapter.width(20),
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConfig.assistLineColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.getPixelRatio()*ScreenAdapter.height(125),
              child: CachedNetworkImage(imageUrl: "${model.promotionPic}${ConstConfig.BANNER_FOUR_SIZE}",fit: BoxFit.fitWidth,),
            )
          ],
        ),
      )
    ):Container();
  }

  /// 商品列表
  Widget _commodityContent(List<CommodityModels> products){
    return new Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: new Wrap(
        spacing: 10,
        alignment: WrapAlignment.center,
        children: products.map((item){
          String title = item.prodName;
          if(item.prodName.length>10){
            title = title.substring(0,10) + "...";
          }
          Widget widgets=Container();
          if(item.originalPrice!=null&& double.parse(item.salesPriceRange.toString()) < double.parse(item.originalPrice.toString()) ){
            widgets = new Container(
              padding:EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomsWidget().priceTitle(price: item.originalPrice.toString(),color: Colors.grey, decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenAdapter.size(18))
                ],
              ),
            );
          }

          return InkWell(
            onTap: (){
              /// 跳转商品详情
              _commodityDetail(types:37,prodID: item.prodID);
            },
            child: Stack(
              children: <Widget>[
                new Container(
                width: ScreenAdapter.getScreenWidth()/3.8,
                margin: EdgeInsets.only(top: 10),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SizedBox(
                      height: ScreenAdapter.height(180),
                      child: item.prodPic!=null?new CachedNetworkImage(imageUrl:"${item.prodPic}${ConstConfig.BANNER_TWO_SIZE}",fit: BoxFit.fitWidth):
                      Image.asset("assets/images/default/default_squre_img.png",fit: BoxFit.fitWidth,),
                    ),
                    new Container(
                      padding:EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(title,overflow: TextOverflow.ellipsis,softWrap: false,
                            style: TextStyle(fontSize: ScreenAdapter.size(24),fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ),
                    new Container(
                      padding:EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomsWidget().priceTitle(price: item.salesPriceRange,
                              fontWeight: FontWeight.w500,fontSize: ScreenAdapter.size(24))
                        ],
                      ),
                    ),
                    widgets
                  ],
                )),
                Positioned(
                  top: 0,
                  right: 0,
                  child: item.badges!=null&&item.badges.length>0?
                  Row(
                    children: item.badges.map((items){
                      return Container(
                        width: ScreenAdapter.width(80),
                        height: ScreenAdapter.height(40),
                        color: AppConfig.blueBtnColor,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 5),
                        child: Text(items.name,style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdapter.size(24)
                        ),),
                      );
                    }).toList(),
                  ):Container(width: 0,height: 0,),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _bottomContent(String promotionCode,String name){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 10,top: 20),
      child: InkWell(
        onTap: (){
          _searchRequest(promotionCode);
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("查看全部",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: ScreenAdapter.size(26)),),
            new Icon(Icons.arrow_right)
          ],
        ),
      )
    );
  }

  _loadBannerData(){
    widget._provide.bannerData(context:context)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      if(item.data!=null){
        setState(() {
          _bannersList=BannersModelList.fromJson(item.data['banners']).list;
          _portletsModelList= PortletsModelList.fromJson(item.data['portlets']).list;
        });
      }
      print('listen data->$item');
//      _provide
    }, onError: (e) {});
  }

  _loadListData(){
    pageNo = pageNo +1;
    Loading.ctx=context;
    Loading.show();
    widget._provide.listData(pageNo,context:context).doOnListen((){}).doOnCancel((){})
        .listen((item){
          Loading.remove();
        setState(() {
          _portletsModelList.addAll( PortletsModelList.fromJson(item.data).list);
        });
    },onError: (e){});
  }

  _clearList(){
    setState(() {
      _bannersList.clear();
      _portletsModelList.clear();
    });
  }

  /// 搜索请求
  void _searchRequest(String code){
    // 清除原数据
    _commodityListProvide.clearList();
    _commodityListProvide.requestUrl = "/api/promotion/promotions/$code/products?";
    Loading.ctx=context;
    Loading.show();
    _searchProvide.onSearch(_commodityListProvide.requestUrl+'pageNo=1&sort=&pageSize=8',
    context:context).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      Loading.remove();
    ///加载数据
    print('listen data->$items');
    if(items!=null&&items.data!=null){
    _searchProvide.searchValue = items.data['promotionName'];
    _commodityListProvide.addList(CommodityList.fromJson(items.data['products']).list);
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return SearchScreenPage();
      }
    ));
    }

    }, onError: (e) {});
  }

  /// 商品详情
  _commodityDetail({int types,int prodID}){
    /// 跳转商品详情
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
//    Loading.ctx=context;
//    Loading.show();
    /// 加载详情数据
    _detailProvide.detailData(types: types,prodId:prodID,context:context)
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
                return new CommodityDetailPage();
              }
          )
          );
        }
  //      _provide
    }, onError: (e) {});
  }
}