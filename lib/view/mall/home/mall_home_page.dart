import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/portlets_model.dart';
import 'package:innetsect/data/mall/promotion_model.dart';
import 'package:innetsect/main_provide.dart';
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
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityListProvide _commodityListProvide = CommodityListProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final InformationProvide _informationProvide = InformationProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;
  MallHomePage(){
    mProviders.provide(Provider<MallHomeProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<InformationProvide>.value(_informationProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
  }
  @override
  Widget buildContent(BuildContext context) {

    return MallHomeContent(_provide,_detailProvide,_commodityListProvide,
        _searchProvide,_cartProvide,_informationProvide,_mainProvide);
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

  MallHomeContent(this._provide,this._detailProvide,
      this._commodityListProvide,this._searchProvide,
      this._cartProvide,this._informationProvide,
      this._mainProvide);

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
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('第$index 页被点击=====${_bannersList[index].toString()}');

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
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return new WebView(url: _bannersList[index].redirectParam,);
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
                        imageUrl: _bannersList[index].bannerPic,
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
          autoplay: true,
          loop: true,
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
            new Padding(padding: EdgeInsets.only(bottom: 10,top: 20),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _dividerWidget(width: ScreenAdapter.getScreenWidth()/4,padding: EdgeInsets.only(right: 10),indent: 60),
                  new Text(model.promotionName,softWrap: false,
                    style: TextStyle(color: AppConfig.fontBackColor,fontWeight:FontWeight.w600,fontSize: ScreenAdapter.size(32)),),
                  _dividerWidget(width: ScreenAdapter.getScreenWidth()/4,padding: EdgeInsets.only(left: 10),endIndent: 60),
                ],
              ),
            ),
            SizedBox(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.getPixelRatio()*ScreenAdapter.height(125),
              child: CachedNetworkImage(imageUrl: model.promotionPic+ConstConfig.BANNER_SIZE,fit: BoxFit.fitWidth,),
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
          return InkWell(
            onTap: (){
              /// 跳转商品详情
              _commodityDetail(types:37,prodID: item.prodID);
            },
            child: new Container(
              width: ScreenAdapter.getScreenWidth()/3.8,
              margin: EdgeInsets.only(top: 10),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    height: ScreenAdapter.height(180),
                    child: new Image.network(item.prodPic+ConstConfig.LIST_IMAGE_SIZE,),
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
                  )
                ],
              ),
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

  /// 横线
  Widget _dividerWidget({double width,double height=50.0,EdgeInsetsGeometry padding,double indent=0.0,double endIndent=0.0}){
    return Container(
      width: width,
      height: ScreenAdapter.height(height),
      padding: padding,
      child: new Divider(color: Colors.grey,indent: indent,endIndent: endIndent,height: 5,),
    );
  }

  ///TODO 废弃
  Widget _contentList(PortletsModel model){
    Widget widget;
    switch(model.contents.length) {
      case 1:
        widget = new Container(
          width: double.infinity,
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              new Image.network(model.contents[0].mediaFiles,
                width: double.infinity,
                height:ScreenAdapter.height(420),fit:BoxFit.fitWidth,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 20),
                    child: new Container(
                      color: Colors.black,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      child: new Text(model.contents[0].tags,style: TextStyle(color:Colors.white),),
                    ),
                  )
                ],
              )
            ],
          ),
        );
        break;
      case 2:
        widget = new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: model.contents.map((res){
            return new Container(
              width: ScreenAdapter.getScreenWidth()/2-20 ,
              height: ScreenAdapter.height(480),
              color: Colors.white,
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: new Column(
                children: <Widget>[
                  new Image.network(res.poster,fit: BoxFit.fitHeight,
                  height: ScreenAdapter.height(360),),
                  new Text(res.title,maxLines: 1,style: TextStyle(fontSize: ScreenAdapter.size(24)),),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 20),
                        child: new Container(
                          color: Colors.black,
                          margin: EdgeInsets.only(left: 10,top: 15),
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: new Text(res.tags,style: TextStyle(color:Colors.white,
                              fontSize: ScreenAdapter.size(18)),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        );
        break;
      default:
        widget = new Container();
        break;
    }
    return widget;
  }

  _loadBannerData(){
    widget._provide.bannerData()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      if(item.data!=null){
        setState(() {
          _bannersList=BannersModelList.fromJson(item.data['banners']).list;
          _portletsModelList..addAll( PortletsModelList.fromJson(item.data['portlets']).list);
        });
      }
      print('listen data->$item');
//      _provide
    }, onError: (e) {});
  }

  _loadListData(){
    widget._provide.listData(++pageNo).doOnListen((){}).doOnCancel((){})
        .listen((item){
        setState(() {
          _portletsModelList..addAll( PortletsModelList.fromJson(item.data).list);
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

    _searchProvide.onSearch(_commodityListProvide.requestUrl+'pageNo=1&sort=&pageSize=8').doOnListen(() { }).doOnCancel(() {}).listen((items) {
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
    /// 加载详情数据
    _detailProvide.detailData(types: types,prodId:prodID)
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
    Navigator.push(context, MaterialPageRoute(
        builder:(context){
          return new CommodityDetailPage();
        }
      )
    );
  }


}