import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/hot_spots/hot_spots_home_provide.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/mall/information/infor_web_page.dart';
import 'package:innetsect/view/mall/search/search_screen_page.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_list_provide.dart';
import 'package:innetsect/view_model/mall/information/information_provide.dart';
import 'package:innetsect/view_model/mall/search/search_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

///热区首页

class HotSpotsHomePage extends PageProvideNode {
  final Map redirectParam;
  final HotSpotsHomeProvide _provide = HotSpotsHomeProvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final CommodityListProvide _commodityListProvide =
      CommodityListProvide.instance;
  final InformationProvide _informationProvide = InformationProvide.instance;
  final SearchProvide _searchProvide = SearchProvide.instance;
  HotSpotsHomePage({this.redirectParam}) {
    mProviders.provide(Provider<HotSpotsHomeProvide>.value(_provide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<InformationProvide>.value(_informationProvide));
    mProviders
        .provide(Provider<CommodityListProvide>.value(_commodityListProvide));
    mProviders.provide(Provider<SearchProvide>.value(_searchProvide));
    _provide.activitiedId = redirectParam['redirectParam'];
    print('activitiedId=========>${_provide.activitiedId}');

  }
  @override
  Widget buildContent(BuildContext context) {
    return HotSpotsHomeContentPage(_provide, _detailProvide, _cartProvide,
        _informationProvide, _commodityListProvide, _searchProvide);
  }
}

class HotSpotsHomeContentPage extends StatefulWidget {
  final HotSpotsHomeProvide provide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final InformationProvide _informationProvide;
  final CommodityListProvide _commodityListProvide;
  final SearchProvide _searchProvide;
  HotSpotsHomeContentPage(
      this.provide,
      this._detailProvide,
      this._cartProvide,
      this._informationProvide,
      this._commodityListProvide,
      this._searchProvide);
  @override
  _HotSpotsHomeContentPageState createState() =>
      _HotSpotsHomeContentPageState();
}

class _HotSpotsHomeContentPageState extends State<HotSpotsHomeContentPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  HotSpotsHomeProvide provide;
  CommodityDetailProvide _detailProvide;
  CommodityAndCartProvide _cartProvide;
  InformationProvide _informationProvide;
  CommodityListProvide _commodityListProvide;
  SearchProvide _searchProvide;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    _detailProvide ??= widget._detailProvide;
    _cartProvide ??= widget._cartProvide;
    _informationProvide ??= widget._informationProvide;
    _commodityListProvide ??= widget._commodityListProvide;
    _searchProvide ??= widget._searchProvide;
  }

  /// 商品详情
  _commodityDetail({int types, int prodID}) {
    print('商品详情');

    /// 跳转商品详情
    _detailProvide.clearCommodityModels();
    _detailProvide.prodId = prodID;
//    Loading.ctx=context;
//    Loading.show();
    /// 加载详情数据
    _detailProvide
        .detailData(types: types, prodId: prodID, context: context)
        .doOnListen(() {
          print('doOnListen');
        })
        .doOnCancel(() {})
        .listen((item) {
//          Loading.remove();
          ///加载数据
          print('listen data->$item');
          if (item != null && item.data != null) {
            _detailProvide
                .setCommodityModels(CommodityModels.fromJson(item.data));
            _detailProvide.setInitData();
            _cartProvide.setInitCount();
            _detailProvide.isBuy = false;
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new CommodityDetailPage();
            }));
          }
          //      _provide
        }, onError: (e) {});
  }

   /// 品牌列表
  void _searchRequest(String name){
    print('<==============================>');
//    Loading.ctx = context;
//    Loading.show();
    // 清除原数据
    _commodityListProvide.clearList();
    _commodityListProvide.requestUrl = "/api/eshop/app/products/filterByBrand?brand=$name";
    _searchProvide.onSearch(_commodityListProvide.requestUrl+'&pageNo=1&pageSize=8',
    context: context).doOnListen(() { }).doOnCancel(() {}).listen((items) {
      ///加载数据
      print('listen data->$items');
//      Loading.remove();
      if(items!=null&&items.data!=null){
        
        _commodityListProvide.addList(CommodityList.fromJson(items.data).list);
        
      }

    }, onError: (e) {});

    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return SearchScreenPage();
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('热区'),
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: ScreenAdapter.size(60),
          ),
        ),
      ),
      body: WebView(
        initialUrl:
            'http://test.innersect.net/api/promotion/proartifacts/${provide.activitiedId}/detail',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request) {
          // print('request====================>${request.url}');
          if (request.url.startsWith('https://test.innersect.net/')) {
            print('blocking navigation to =====>${request.url}}');
            String url = request.url;
            String subUrl = url.split('?')[1];
            print('subUrl======>$subUrl');
            List param = subUrl.split('&');
            String redirectTypeParam = param[0];
            print('redirectTypeParam=========>$redirectTypeParam');
            String redirectParam = param[1];
            print('redirectParam=========>$redirectParam');
            if (redirectTypeParam.split('=')[1] == ConstConfig.PRODUCT_DETAIL) { //ok
              print('跳转商品详情');
              print('=========>${redirectParam.split(':')[0]}');
              print('=========>${redirectParam.split(':')[1]}');
              String spl = redirectParam.substring(
                  "redirectParam=".length, redirectParam.length);
              print('spl===========>$spl');
              _commodityDetail(
                  types: int.parse(spl.split(":")[0]),
                  prodID: int.parse(spl.split(":")[1]));
              //Navigator.pushNamed(context, '/loginPage');
            } else if (redirectTypeParam.split('=')[1] ==
                ConstConfig.CONTENT_DETAIL) {//ok
              print('资讯详情======>${int.parse(redirectParam.split('=')[1])}');
              _informationProvide.contentID =
                  int.parse(redirectParam.split('=')[1]);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return new InforWebPage();
              }));
            } else if (redirectTypeParam.split('=')[1] ==
                'CATALOG_PRODUCT_LIST') {
               print('品类列表	=======>${redirectParam.split(':')[1]}');
               _searchProvide.searchValue = '品类';
              _searchRequest(redirectParam.split(':')[1]);

            } else if (redirectTypeParam.split('=')[1] == 'PROMOTION') {
              print('促销活动	');
            } else if (redirectTypeParam.split('=')[1] == 'URL') {
              print('URL');
              Navigator.pushNamed(context, '/hotSpotsHomeUrlPage',arguments:{
                'url':redirectParam.split('=')[1],
              } );
              // return NavigationDecision.navigate;
              // return NavigationDecision.prevent;
            } else if (redirectTypeParam.split('=')[1] ==
                'PRODUCT_COLLECTION') {
              print('产品系列');
              String code = redirectParam.split(':')[1];
              print('==========>$code');
              print('产品系列');
              _searchProvide.searchValue = '';
           //   _searchRequest(code);
              // //清除源数据
              _commodityListProvide.clearList();
              _commodityListProvide.requestUrl =
                  "/api/promotion/promotions/$code/products?";
              // Loading.ctx = context;
              // Loading.show();
              _searchProvide
                  .onSearch(
                      _commodityListProvide.requestUrl +
                          'pageNo=1&sort=&pageSize=8',
                      context: context)
                  .doOnListen(() {})
                  .doOnCancel(() {})
                  .listen((items) {
                // Loading.remove();

                ///加载数据
                print('listen data===========->$items');
                if (items != null && items.data != null) {
                  _searchProvide.searchValue = items.data['promotionName'];
                  _commodityListProvide.addList(
                      CommodityList.fromJson(items.data['products']).list);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchScreenPage();
                  }));
                }
              }, onError: (e) {});
            } else if (redirectTypeParam.split('=')[1] == 'DRAW') {
              print('抽签');
              Navigator.pushNamed(context, '/drawPage',
                  arguments: {'redirectParam': redirectParam.split('=')[1]});
            } else if (redirectTypeParam.split('=')[1] ==
                'BRAND_PRODUCT_LIST') {
                  print('品牌列表');
                  _searchProvide.searchValue = '品牌列表';
                  _searchRequest(redirectParam.split(':')[1]);
                }

            return NavigationDecision.prevent;
          }
          print('allowing navigation to =====>$request');

          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print('Page started loading---->: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading--->: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
