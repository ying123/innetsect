import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_brand_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/data/coupons/access_coupon.dart';
import 'package:innetsect/data/coupons/list_of_coupons.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/common_util.dart';
import 'package:innetsect/view/draw/btn_sheet.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/commodity/qimo_page.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:innetsect/view/widget/commodity_modal_bottom.dart';

///yan商品详情
class CommodityDetailPage extends PageProvideNode {
  final CommodityDetailProvide _provide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final CommodityListProvide _commodityListProvide =
      CommodityListProvide.instance;
  final SearchProvide _searchProvide = SearchProvide.instance;
  final String pages;

  CommodityDetailPage({
    this.pages,
  }) {
    mProviders.provide(Provider<CommodityDetailProvide>.value(_provide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders
        .provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return CommodityDetailContent(
        _provide, _cartProvide, _commodityListProvide, _searchProvide,
        pages: this.pages);
  }
}

class CommodityDetailContent extends StatefulWidget {
  final CommodityDetailProvide _provide;
  final CommodityAndCartProvide _cartProvide;
  final CommodityListProvide _commodityListProvide;
  final SearchProvide _searchProvide;
  final String pages;
  CommodityDetailContent(this._provide, this._cartProvide,
      this._commodityListProvide, this._searchProvide,
      {this.pages});
  @override
  _CommodityDetailContentState createState() =>
      new _CommodityDetailContentState();
}

class _CommodityDetailContentState extends State<CommodityDetailContent>
    with SingleTickerProviderStateMixin {
//  TabController _tabController;
  ScrollController _scrollController;
  CommodityDetailProvide _provide;
  CommodityAndCartProvide _cartProvide;
  CommodityListProvide _commodityListProvide;
  SearchProvide _searchProvide;
  bool _isShowBottom = true;
  // webview
  String html;

  int pageNo = 1;

  /// 推荐商品
//  List<List<CommodityModels>> recommedList = new List();
  List<Widget> _listImage = List();

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return new Scaffold(
      appBar: CustomsWidget().customNav(
          context: context,
          widget: Container(),
          width: ScreenAdapter.width(ScreenAdapter.getScreenWidth() - 120)),
      body: _contentWidget(),
      bottomSheet: !_isShowBottom
          ? Container(
              height: 0,
              width: 0,
            )
          : _bottomBar(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    _provide ??= widget._provide;
    _cartProvide ??= widget._cartProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _searchProvide ??= widget._searchProvide;

//    _tabController = new TabController(length: detailTabBarList.length, vsync: this);
    _scrollController = new ScrollController();

//    _scrollController.addListener((){
//      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
//        _tabController.index=1;
//      }
//    });

//    _loadData();
    // 展会进入
    if (widget.pages == ConstConfig.EXHIBIT_PRODUCT) {
      if (_provide.commodityModels.promptingMessage != null) {
        CustomsWidget()
            .showToast(title: _provide.commodityModels.promptingMessage);
      }
      setState(() {
        _isShowBottom = _provide.commodityModels.orderable;
      });
    }

    /// 显示所有sku图片
    List<CommoditySkusModel> skuList = _provide.colorSkuList;
    if (skuList != null) {
      if (skuList.length > 0) {
        skuList.forEach((item) {
          _listImage
            ..add(CachedNetworkImage(
                imageUrl: "${item.skuPic}${ConstConfig.BANNER_TWO_SIZE}",
                fit: BoxFit.fitWidth));
        });
      } else {
        _listImage
          ..add(Image.asset("assets/images/default/default_hori_img.png",
              fit: BoxFit.fitWidth));
      }
    }

    _loadHtml();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    _tabController.dispose();
  }

  ///TODO 商品顶部导航（暂时隐藏)
  /**Widget _topNavTabBar(){
    return new TabBar(
        isScrollable: false,
        controller: _tabController,
        indicatorColor: Colors.red,
        indicatorSize:TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: new TextStyle(fontSize: ScreenAdapter.size(24)),
        labelColor: Colors.black,
        labelStyle: new TextStyle(fontSize: ScreenAdapter.size(24)),
        tabs: detailTabBarList.map((item){
          return new Container(
            height: ScreenAdapter.height(40),
            width: ScreenAdapter.width(ScreenAdapter.getScreenWidth()/6),
            alignment: Alignment.center,
            child: new Text(item.title),
          );
        }).toList()
    );
  }*/

  ///TODO tabBarView视图组件（暂时隐藏)
  /**Widget _tabBarView(){
    return new TabBarView(
        controller: _tabController,
        children: [
          _contentWidget(),
          new Container(
            child: WebViewWidget(url: "https://www.baidu.com",),
          )
        ]
    );
  }*/

  /// 商品详情内容区域
  Widget _contentWidget() {
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
        _comTitle(),
        _brandCol(),
        _couponsPromotions(),
        _selCol(),
        _selCommodityPlicy(),
        _showDesc(),
        html != null
            ? new Container(
                child: Html(
                  data: html,
                ),
              )
            : new Container(),
        SizedBox(
          width: double.infinity,
          height: ScreenAdapter.height(80),
        )
      ],
    );
  }

  Widget _couponsPromotions() {
    return _provide.commodityModels.promotions.length == 0
        ? Container()
        : Container(
            width: double.infinity,
            height: ScreenAdapter.height(80),
            color: Colors.white,
            margin: EdgeInsets.only(top: 10, bottom: 10),
            padding: EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                // _searchRequest(
                //     catCode: _provide.commodityModels.catCode,
                //     brands: brandModel.brandName);
                print('优惠卷被点击');
                _provide
                    .listOfCoupons(prodid: _provide.commodityModels.prodID)
                    .doOnListen(() {})
                    .doOnError((e, errorT) {})
                    .listen((items) {
                  print('商品详情优惠卷====================>${items.data}');
                  if (items.data != null) {
                    _provide.addListOfCouponsModel(
                        ListOfCouponsModelList.fromJson(items.data).list);
                    print(
                        'listOfCouponsModel===================>${_provide.listOfCouponsModel.length}');
                    selectCoupons();
                  }
                });
              },
              child: Row(
                children: <Widget>[
                  Text(
                    '优惠',
                    style: TextStyle(
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(20),
                  ),
                  Container(
                    // width: ScreenAdapter.width(180),
                    //height: ScreenAdapter.height(50),
                    color: Color.fromRGBO(143, 168, 205, 1.0),
                    child: Text(
                      _provide.commodityModels.promotions[0].promotionBrief,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(25),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // Image.network(
                            //   brandModel.brandLogo,
                            //   fit: BoxFit.fitWidth,
                            // ),
                            Icon(Icons.chevron_right),
                          ],
                        )),
                  )
                ],
              ),
            ),
          );
  }

  selectCoupons() {
    showYanModalBottomSheet(
        //showYanModalBottomSheet
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context1, setBottomSheetState) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 25,
                      width: double.infinity,
                      color: Colors.black54,
                    ),
                    Container(
                        height: ScreenAdapter.height(1500),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(ScreenAdapter.size(25)),
                              topRight: Radius.circular(ScreenAdapter.size(25)),
                            )),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.width(750),
                              height: ScreenAdapter.height(80),
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  Text(
                                    '优惠',
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.clear)),
                                  SizedBox(
                                    width: ScreenAdapter.width(20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenAdapter.width(680),
                              height: ScreenAdapter.height(80),
                              // color: Colors.yellow,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '可领取优惠卷',
                                style: TextStyle(
                                    fontSize: ScreenAdapter.size(28),
                                    color: Colors.grey),
                              ),
                            ),
                            Container(
                              height: ScreenAdapter.height(835),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: _provide.listOfCouponsModel.length,
                                  itemBuilder: (BuildContext build, int index) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        //margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                                        // width: double.infinity,
                                        height: ScreenAdapter.height(200),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: ScreenAdapter.width(20),
                                            ),
                                            Container(
                                              width: ScreenAdapter.width(200),
                                              height: ScreenAdapter.height(160),
                                              child: Stack(
                                                children: <Widget>[
                                                  _provide
                                                              .listOfCouponsModel[
                                                                  index]
                                                              .csType ==
                                                          0
                                                      ? Image.asset(
                                                          'assets/images/立减券.png',
                                                          fit: BoxFit.contain,
                                                        )
                                                      : _provide
                                                                  .listOfCouponsModel[
                                                                      index]
                                                                  .csType ==
                                                              1
                                                          ? Image.asset(
                                                              'assets/images/满减券.png',
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : _provide
                                                                      .listOfCouponsModel[
                                                                          index]
                                                                      .csType ==
                                                                  2
                                                              ? Image.asset(
                                                                  'assets/images/折扣券.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                )
                                                              : _provide.listOfCouponsModel[index]
                                                                          .csType ==
                                                                      4
                                                                  ? Image.asset(
                                                                      'assets/images/运费券.png',
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    )
                                                                  : Image.asset(
                                                                      'assets/images/优惠券-灰.png',
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                  Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: ScreenAdapter
                                                            .height(20),
                                                      ),
                                                      _provide
                                                                  .listOfCouponsModel[
                                                                      index]
                                                                  .csType !=
                                                              2
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  '￥',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          ScreenAdapter.size(
                                                                              28),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Text(
                                                                  _provide
                                                                      .listOfCouponsModel[
                                                                          index]
                                                                      .couponValue
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          ScreenAdapter.size(
                                                                              50),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  _provide
                                                                      .listOfCouponsModel[
                                                                          index]
                                                                      .couponValue
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          ScreenAdapter.size(
                                                                              50),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900),
                                                                ),
                                                                Text(
                                                                  '折',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          ScreenAdapter.size(
                                                                              28),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ],
                                                            ),
                                                      Text(
                                                        _provide
                                                            .listOfCouponsModel[
                                                                index]
                                                            .useLimitDesc,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenAdapter
                                                                    .size(20)),
                                                      ),
                                                      SizedBox(
                                                        height: ScreenAdapter
                                                            .height(20),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                             SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                              width: ScreenAdapter.width(460),
                              height: ScreenAdapter.height(166),
                              //  color: Colors.yellow,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: ScreenAdapter.height(10),
                                      ),
                                      Container(
                                          child: ExtendedText.rich(
                                              TextSpan(children: <InlineSpan>[
                                        WidgetSpan(
                                          child: _provide.listOfCouponsModel[index]
                                                      .csType ==
                                                  0
                                              ? Image.asset(
                                                  'assets/images/lj.jpg',
                                                  width:
                                                      ScreenAdapter.width(100),height: ScreenAdapter.height(50)
                                                )
                                              : _provide.listOfCouponsModel[index]
                                                          .csType ==
                                                      1
                                                  ? Image.asset(
                                                      'assets/images/mj.jpg',
                                                      width:
                                                          ScreenAdapter.width(
                                                              100),height: ScreenAdapter.height(50)
                                                    )
                                                  : _provide.listOfCouponsModel[index]
                                                              .csType ==
                                                          2
                                                      ? Image.asset(
                                                          'assets/images/zk.jpg',
                                                          width: ScreenAdapter
                                                              .width(100),height: ScreenAdapter.height(50),
                                                        )
                                                      : _provide.listOfCouponsModel[index]
                                                                  .csType ==
                                                              4
                                                          ?
                                                           Image.asset(
                                                              'assets/images/yf.jpg', width: ScreenAdapter
                                                              .width(100),height: ScreenAdapter.height(50),
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : Container(),
                                        ),
                                        TextSpan(text: ' '),
                                        TextSpan(
                                            text: _provide.listOfCouponsModel[index].csName,
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenAdapter.size(23
                                                  ),fontWeight: FontWeight.w600
                                                  )),
                                      ]))),
                                    ],
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: ScreenAdapter.height(78),
                                      child: Container(
                                        width: ScreenAdapter.width(460),
                                        height: ScreenAdapter.height(65),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              _provide.listOfCouponsModel[index]
                                                      .givenTime
                                                      .split(' ')[0] +
                                                  '-' +
                                                 _provide.listOfCouponsModel[index].endTime
                                                      .split(' ')[0],
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.size(20)),
                                            ),
                                            Expanded(child: Container()),
                                            //  SizedBox(
                                            //   width: ScreenAdapter.width(120),
                                            // ),
                                             InkWell(
                                               onTap: (){
                                                 
                                                 _provide.couponByID(
                                                   csID: _provide.listOfCouponsModel[index].csID).doOnData((item){

                                                   }).doOnError((e,t){

                                                   }).listen((items){
                                                     print('============================${items.data}');
                                                     if (items.data != null) {
                                                         _provide.accessCouponModel = AccessCouponModel.fromJson(items.data);
                                                        Fluttertoast.showToast(msg: '领取成功',gravity: ToastGravity.CENTER);
                                                     }
                                                    
                                                   });
                                               },
                                               child: Container(
                                                      alignment: Alignment.center,
                                                      width: ScreenAdapter.width(
                                                          130),
                                                      height:
                                                          ScreenAdapter.height(
                                                              44),
                                                      decoration: BoxDecoration(

                                                         color: _provide.listOfCouponsModel[index].csType == 0? Color.fromRGBO(
                                                              68, 141, 227, 1.0)
                                                              :_provide.listOfCouponsModel[index].csType == 1? Color.fromRGBO(135, 170, 207, 1.0)
                                                              :_provide.listOfCouponsModel[index].csType == 2? Color.fromRGBO(0, 180, 202, 1.0)
                                                              :_provide.listOfCouponsModel[index].csType == 4? Color.fromRGBO(0, 194, 136, 1.0)
                                                              :Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      ScreenAdapter.width(
                                                                          25)))),
                                                      child: Text(
                                                        '点击领取',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenAdapter
                                                                    .size(20)),
                                                      )),
                                             )
                                                
                                            // SizedBox(
                                            //   width: ScreenAdapter.width(10),
                                            // ),
                                          ],
                                        ),
                                      )),
                                 
                                     
                                ],
                              ))

                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ))
                  ],
                ),
              );
            },
          );
        });
  }

  /// _swiperWidget
  Widget _swiperWidget() {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {
        return _listImage[index];
      },
      itemCount: _listImage.length,
      loop: false,
      pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
              color: Colors.white70, // 其他点的颜色
              activeColor: AppConfig.blueBtnColor, // 当前点的颜色
              space: 2, // 点与点之间的距离
              activeSize: 5, // 当前点的大小
              size: 5)),
    );
  }

  /// 标题
  Widget _comTitle() {
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _comTitleProdName(),
          new Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[_comTitleSalesPrice(), _comSalesPrice()],
              )),
        ],
      ),
    );
  }

  /// 标题 prodName
  Provide<CommodityDetailProvide> _comTitleProdName() {
    return Provide<CommodityDetailProvide>(builder:
        (BuildContext context, Widget widget, CommodityDetailProvide provide) {
      CommodityModels models = provide.commodityModels;
      return new Text(
        models != null ? models.prodName : "",
        style: TextStyle(
            fontSize: ScreenAdapter.size(38), fontWeight: FontWeight.w800),
      );
    });
  }

  /// 标题价格
  Provide<CommodityDetailProvide> _comTitleSalesPrice() {
    return Provide<CommodityDetailProvide>(builder:
        (BuildContext context, Widget widget, CommodityDetailProvide provide) {
      CommodityModels models = provide.commodityModels;
      String price = models.salesPriceRange.toString();
      if (models != null &&
          models.salesPriceRange == null &&
          models.originalPrice != null) {
        price = models.originalPrice.toString();
      }
      return CustomsWidget().priceTitle(price: price);
    });
  }

  /// 原价
  Provide<CommodityDetailProvide> _comSalesPrice() {
    return Provide<CommodityDetailProvide>(builder:
        (BuildContext context, Widget widget, CommodityDetailProvide provide) {
      CommodityModels models = provide.commodityModels;
      String _price = models.salesPriceRange;
      if (_price.indexOf("-") > -1) {
        _price = models.salesPriceRange.split("-")[0].toString();
      }
      if (models.originalPrice == null) {
        return Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomsWidget().priceTitle(
              price: models.salesPriceRange.toString(),
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: ScreenAdapter.size(20)),
        );
      } else if (double.parse(_price) <
          double.parse(models.originalPrice.toString())) {
        return Padding(
          padding: EdgeInsets.only(left: 10),
          child: CustomsWidget().priceTitle(
              price: models.originalPrice.toString(),
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: ScreenAdapter.size(20)),
        );
      }
      return Container();
    });
  }

  /// 品牌
  Widget _brandCol() {
    CommodityBrandModel brandModel = _provide.commodityModels.brandModel;
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(80),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () {
          _searchRequest(
              catCode: _provide.commodityModels.catCode,
              brands: brandModel.brandName);
        },
        child: Row(
          children: <Widget>[
            Text(brandModel.brandName),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.network(
                        brandModel.brandLogo,
                        fit: BoxFit.fitWidth,
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  /// 已选栏目
  Provide<CommodityDetailProvide> _selCol() {
    return Provide<CommodityDetailProvide>(builder:
        (BuildContext context, Widget widget, CommodityDetailProvide provide) {
      Widget skuText = Container();
      String text = "请选择";
      String colorText = "颜色";
      String sizeText = "尺码";
      if (provide.colorSkuList.length > 3) {
        skuText = Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppConfig.blueBtnColor,
          ),
          child: Text(
            "其他颜色",
            style: TextStyle(
                color: Colors.white, fontSize: ScreenAdapter.size(24)),
          ),
        );
      }
      if (provide.skusModel != null &&
          (provide.skusModel.features[0].featureValue != null ||
              provide.skusModel.features[1].featureValue != null)) {
        text = "已选";
        if (provide.skusModel.features[0].featureValue != null) {
          sizeText = provide.skusModel.features[0].featureValue;
        }
        if (provide.skusModel.features[1].featureValue != null) {
          colorText = provide.skusModel.features[1].featureValue;
        }
      }
      List<CommoditySkusModel> list = _provide.colorSkuList;
      if (list.length > 3) {
        list = list.sublist(0, 3);
      }
      return new InkWell(
          onTap: () {
            /// 弹出颜色，尺码选择
//        _provide.setInitData();
            _cartProvide.setInitCount();
            provide.isBuy = false;
            if (_provide.commodityModels.promptingMessage != null) {
              CustomsWidget()
                  .showToast(title: provide.commodityModels.promptingMessage);
            } else {
              CommodityModalBottom.showBottomModal(context: context);
            }
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, left: 20, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 选择
                new Expanded(
                    flex: 1,
                    child: Text(
                      "选择",
                      style: TextStyle(
                          color: Colors.grey, fontSize: ScreenAdapter.size(28)),
                    )),
                // 中间
                new Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$text $colorText $sizeText",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenAdapter.size(28)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: list.map((items) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey)),
                                child: items.skuPic != null
                                    ? Image.network(
                                        items.skuPic,
                                        fit: BoxFit.fitHeight,
                                        width: ScreenAdapter.width(50),
                                        height: ScreenAdapter.height(60),
                                      )
                                    : Image.asset(
                                        "assets/images/default/default_img.png",
                                        fit: BoxFit.fitHeight,
                                        width: ScreenAdapter.width(50),
                                        height: ScreenAdapter.height(60),
                                      ),
                              );
                            }).toList()
                              ..add(skuText),
                          ),
                        )
                      ],
                    )),
                // 箭头
                new Expanded(flex: 1, child: new Icon(Icons.chevron_right))
              ],
            ),
          ));
    });
  }

  /// 策略
  Widget _selCommodityPlicy() {
    String title = '';
    String content = '';
    // 0:不退不换，1：可退 2：可换 3：可退可换
    switch (widget._provide.commodityModels.rmaPolicy) {
      case 0:
        title = '不支持退换';
        content = '该商品不支持退换';
        break;
      case 1:
        title = '七天退货';
        content = '签收7天内可无条件申请退货。INNERSECT收到并确定商品符合退货标准后，将原路返还您所支付的钱款。';
        break;
      case 2:
        title = '七天换货';
        content = '签收7天内可无条件申请换货。INNERSECT收到并确定商品符合换货标准后,将给予换货服务。';
        break;
      case 3:
        title = '七天退换';
        content = '签收7天内可无条件申请退换货。INNERSECT收到并确定商品符合退换货标准后，将原路返还您所支付的钱款。';
        break;
    }
    List list = [
      {
        'icon': 'assets/images/mall/zhengpin1.png',
        'title': '100%正品',
        'content': 'INNERSECT所售商品皆由品牌官方认证授权，100%官方品牌，请您放心购买。'
      },
      {
        'icon': 'assets/images/mall/zhengpin2.png',
        'title': title,
        'content': content
      },
      {
        'icon': 'assets/images/mall/zhengpin3.png',
        'title': '全国配送',
        'content': '支持全国配送，包括港澳台地区。'
      },
    ];
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(80),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(left: 20),
      child: InkWell(
        onTap: () {
          // 蒙版
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    children: list.map((item) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                item['icon'],
                                fit: BoxFit.fitWidth,
                                width: ScreenAdapter.width(36),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(item['title']),
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(item['content']))
                        ],
                      );
                    }).toList(),
                  ),
                );
              });
        },
        child: Row(
          children: <Widget>[
            Image.asset(
              list[0]['icon'],
              fit: BoxFit.fitWidth,
              width: ScreenAdapter.width(36),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(list[0]['title']),
            ),
            Image.asset(
              list[1]['icon'],
              fit: BoxFit.fitWidth,
              width: ScreenAdapter.width(36),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(list[1]['title']),
            ),
            Image.asset(
              list[2]['icon'],
              fit: BoxFit.fitWidth,
              width: ScreenAdapter.width(36),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(list[2]['title']),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Icon(Icons.chevron_right),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showDesc() {
    if (widget._provide.commodityModels.presaleDesc != null) {
      return Container(
          color: Colors.white,
          height: ScreenAdapter.height(110),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            widget._provide.commodityModels.presaleDesc,
            style: TextStyle(color: Colors.grey),
          ));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  /// 已选skuName
  Provide<CommodityDetailProvide> _selColSkuName() {
    return Provide<CommodityDetailProvide>(builder:
        (BuildContext context, Widget widget, CommodityDetailProvide provide) {
      CommoditySkusModel model = provide.skusModel;
      List list = List();
      if (model != null) {
        list = CommonUtil.skuNameSplit(model.skuName);
      }
      if (list != null && list.length > 0) {
        return new Text(
            list != null ? list[1] : model != null ? model.skuName : "");
      } else {
        return Text("");
      }
    });
  }

  ///TODO 推荐（暂时隐藏)
  /**Widget _recommendWidget(){
    double childHeight = ScreenAdapter.getScreenHeight()/1.5;
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(1100),
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: CustomsWidget().subTitle(
              title: "商品推荐", color: AppConfig.primaryColor,
            ),
          ),
          new Container(
            width: double.infinity,
            height: childHeight,
            color: Colors.white,
            child: new Swiper(
              itemCount: recommedList.length>0?recommedList.length:1,
              index: 0,
              loop: false,
              scrollDirection: Axis.horizontal,
              pagination: new SwiperPagination(
                margin: EdgeInsets.only(top: 20),
                builder: DotSwiperPaginationBuilder(
                  activeColor: AppConfig.primaryColor,
                  color: AppConfig.assistLineColor
                )
              ),
              itemBuilder: (BuildContext context,int index) {
                return new Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: recommedList.length>0 ?
                      new Wrap(
                        spacing: 10,
                        runSpacing: 5,
                        children: recommedList[index].map((item){
                          return new Container(
                            width: ScreenAdapter.getScreenWidth()/2-10,
                            height: childHeight/2-15,
                            alignment: Alignment.topCenter,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Image.network(item.prodPic,height: ScreenAdapter.height(280),),
                                new Container(
                                  width: ScreenAdapter.getScreenWidth()/2-10,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(top: 10,bottom: 5),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new CustomsWidget().priceTitle(price: item.defSalesPrice.toString())
                                    ],
                                  )
                                ),
                                new Container(
                                  width: ScreenAdapter.getScreenWidth()/2-10,
                                  alignment: Alignment.center,
                                  child: new Text(item.prodName,style: TextStyle(fontSize: ScreenAdapter.size(24)),
                                    maxLines: 2,),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                      :new Container(),
                );
              },
            ),
          )
        ],
      ),
    );
  }*/

  /// 底部：客服、购物车、加入购物车、立即购买
  Widget _bottomBar(BuildContext context) {
//    if(widget.pages=="EXHIBIT_PRODUCT"){
//      return new Container(height: 0.0,width: 0.0,);
//    }
    List<Widget> bottomAction = [
      Expanded(
        flex: 3,
        child: new Padding(
          padding: EdgeInsets.only(left: 10),
          child: new InkWell(
              onTap: () {
                _provide.setInitData();
                _cartProvide.setInitCount();
                _provide.isBuy = false;
                _cartProvide.setMode(mode: "single");
                CommodityModalBottom.showBottomModal(context: context);
              },
              child: new Container(
                width: ScreenAdapter.width(230),
                height: ScreenAdapter.height(80),
                color: Colors.black,
                alignment: Alignment.center,
                child: new Text(
                  "加入购物车",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenAdapter.size(32)),
                ),
              )),
        ),
      ),
      Expanded(
          flex: 3,
          child: new Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                _provide.setInitData();
                _cartProvide.setInitCount();
                _provide.isBuy = true;
                _cartProvide.setMode(mode: "single");
                // 存储当前商品信息
                CommodityModalBottom.showBottomModal(context: context);
              },
              child: new Container(
                width: ScreenAdapter.width(230),
                height: ScreenAdapter.height(80),
                color: AppConfig.blueBtnColor,
                alignment: Alignment.center,
                child: new Text(
                  "立即购买",
                  style: TextStyle(
                      color: AppConfig.whiteBtnColor,
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenAdapter.size(32)),
                ),
              ),
            ),
          ))
    ];
    if (_provide.commodityModels.badges != null &&
        _provide.commodityModels.badges.length > 0) {
      _provide.commodityModels.badges.forEach((items) {
        if (items.name == "售罄") {
          bottomAction = [
            Expanded(
              flex: 6,
              child: RaisedButton(
                disabledColor: Colors.black12,
                disabledTextColor: Colors.black54,
                child: Text(
                  "已售罄",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            )
          ];
        }
      });
    }
    return new Container(
      width: double.infinity,
      height: ScreenAdapter.height(100),
      color: Colors.white,
      padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 12),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _iconAndTextMerge(
                title: "客服",
                icon: "assets/images/mall/service_p_icon.png",
                onTap: () {
                  print('客服被点击');
                  if (UserTools().getUserToken() == '') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  } else {
                    UserInfoModel userInfoModel = UserTools().getUserInfo();
                    int prodId = _provide.commodityModels.skus[0].prodID;
                    String skuPic = _provide.commodityModels.skus[0].skuPic;
                    String skuName = _provide.commodityModels.skus[0].skuName;
                    if (_provide.skusModel != null &&
                        _provide.skusModel.features[0]?.featureGroup != null) {
                      prodId = _provide.skusModel.prodID;
                      skuPic = _provide.skusModel.skuPic;
                      skuName = _provide.skusModel.skuName;
                    }
                    // 数据结构组装
                    var url = Uri.encodeComponent(
                        "https://proadmin.innersect.net/eshop/stores/shopProductDetail?id=$prodId&shopId=${_provide.commodityModels.shopID}");
                    var json = {
                      "nickName": userInfoModel.nickName == null
                          ? userInfoModel.mobile
                          : userInfoModel.nickName,
                      "peerId": "10052522",
                      "cardInfo": {
                        "left": {"url": skuPic},
                        "right1": {
                          "text": skuName, // 首行文字内容，展示时超出两行隐藏，卡片上单行隐藏
                          "color":
                              "#595959", // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
                          "fontSize": 12
                        },
                        "right2": {
                          "text":
                              "¥${_provide.commodityModels.salesPriceRange}", // 第二行文字内容，展示时超出两行隐藏，卡片上单行隐藏
                          "color":
                              "#595959", // 字体颜色，支持十六位 #ffffff 格式的颜色，不填或错误格式默认#595959
                          "fontSize": 12 // 字体大小， 默认12 ， 请传入number类型的数字
                        },
                        "url": url
                      }
                    };
                    var otherParams = jsonEncode(json);
                    // 用户id
                    var clientId = "1000${userInfoModel.acctID}";
                    // 自定义字段
                    var userInfo = {"手机号": userInfoModel.mobile};

                    var qimoPath =
                        "https://webchat.7moor.com/wapchat.html?accessId=20ed0990-2268-11ea-a2c3-49801d5a0f66" +
                            "&fromUrl=m3.innersect.net&urlTitle=innersect" +
                            "&otherParams=" +
                            Uri.encodeFull(otherParams) +
                            "&clientId=" +
                            clientId +
                            "&customField=" +
                            Uri.encodeFull(jsonEncode(userInfo));
                    print(qimoPath);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QimoPage(
                        url: qimoPath,
                      );
                    }));
                  }
//                  CustomsWidget().serviceWidget(context: context);
                }),
          ),
          Expanded(
            flex: 1,
            child: new Padding(
              padding: EdgeInsets.only(left: 10),
              child: _iconAndTextMerge(
                  title: "购物车",
                  icon: "assets/images/mall/cart_icon.png",
                  onTap: () {
                    // 跳转到购物车
                    // 如果需要返回，设置isBack为true,
                    // 设置settings为传参
                    // 默认为false,不返回
                    _cartProvide.setMode(mode: "multiple");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              return CommodityCartPage();
                            },
                            settings: RouteSettings(
                                arguments: {'isBack': true, 'page': 'mall'})));
                  }),
            ),
          ),
        ]..addAll(bottomAction),
      ),
    );
  }

  /// 图片和文字结合，垂直布局
  Widget _iconAndTextMerge({String title, String icon, Function() onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              icon,
              width: ScreenAdapter.width(32),
              height: ScreenAdapter.height(32),
              fit: BoxFit.fitWidth,
            ),
            new Text(
              title,
              style: TextStyle(fontSize: ScreenAdapter.size(18)),
            )
          ],
        ),
      ),
    );
  }

  /// 加载数据
//  _loadData() {
//     _provide.detailData(types: _provide.types,prodId: _provide.prodId)
//        .doOnListen(() {
//      print('doOnListen');
//    })
//        .doOnCancel(() {})
//        .listen((item) {
//      ///加载数据
//      print('listen data->$item');
//      if(item!=null&&item.data!=null){
//        _provide.setCommodityModels(CommodityModels.fromJson(item.data));
//        _provide.setInitData();
//        _cartProvide.setInitCount();
//        _provide.isBuy = false;
//      }
////      _provide
//    }, onError: (e) {});
//  }

  /// 加载webview
  _loadHtml() async {
    await _provide.getDetailHtml().then((item) {
      print(item);
      if (item.data != null) {
        setState(() {
          html = item.data;
        });
      }
    });
  }

  /// 品牌搜索跳转
  void _searchRequest({int catCode, String brands}) {
    // 清除原数据
    _commodityListProvide.clearList();
    _commodityListProvide.requestUrl =
        "/api/eshop/app/products/filterByBrand?brand=$brands";
    _searchProvide
        .onSearch(_commodityListProvide.requestUrl + '&pageNo=1&pageSize=8')
        .doOnListen(() {})
        .doOnCancel(() {})
        .listen((items) {
      ///加载数据
      print('listen data->$items');
      if (items != null && items.data != null) {
        _searchProvide.searchValue = brands;
        _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchScreenPage();
        }));
      }
    }, onError: (e) {});
  }

  ///TODO 商品推荐(暂时隐藏)
  /**_loadRemData(int pageNo,int types,int prodID){
    _provide.recommendedListData(pageNo, types, prodID).doOnListen((){}).doOnCancel((){})
        .listen((item){
          if(item.data!=null){
            List<CommodityModels> list = CommodityList.fromJson(item.data).list;
            List<CommodityModels> lists = [];
            list.asMap().keys.forEach((keys){
              if((keys+1)%4==0){
                lists.add(list[keys]);
                setState(() {
                  recommedList.add(lists);
                });
                lists=[];
              }else{
                lists.add(list[keys]);
              }
            });
          }
    },onError: (e){});
  }*/
}
