import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/api/loading.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/exhibition/brand_mall_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/brand/brand_mall_provide.dart';
import 'package:innetsect/view/login/login_page.dart';
import 'package:innetsect/view/mall/commodity/commodity_detail_page.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:innetsect/view_model/mall/commodity/commodity_detail_provide.dart';
import 'package:innetsect/view_model/widget/commodity_and_cart_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BrandMallPage extends PageProvideNode {
  final BrandMallPrvide _prvide = BrandMallPrvide();
  final CommodityDetailProvide _detailProvide = CommodityDetailProvide.instance;
  final CommodityAndCartProvide _cartProvide = CommodityAndCartProvide.instance;
  final MainProvide _mainProvide = MainProvide.instance;
  final HomeProvide _homeProvide = HomeProvide();
  String brandName;
  String pic;
  BrandMallPage(this.brandName,this.pic) {
    mProviders.provide(Provider<BrandMallPrvide>.value(_prvide));
    mProviders.provide(Provider<CommodityDetailProvide>.value(_detailProvide));
    mProviders.provide(Provider<CommodityAndCartProvide>.value(_cartProvide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
    mProviders.provide(Provider<HomeProvide>.value(_homeProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BrandMallContentPage(_prvide, brandName,pic,_detailProvide,
        _cartProvide,_mainProvide,_homeProvide);
  }
}

class BrandMallContentPage extends StatefulWidget {
  final BrandMallPrvide _prvide;
  final CommodityDetailProvide _detailProvide;
  final CommodityAndCartProvide _cartProvide;
  final MainProvide _mainProvide;
  final HomeProvide _homeProvide;
  String brandName;
  String pic;
  BrandMallContentPage(this._prvide, this.brandName,this.pic,
      this._detailProvide,this._cartProvide,
      this._mainProvide,this._homeProvide);
  @override
  _BrandMallContentPageState createState() => _BrandMallContentPageState();
}

class _BrandMallContentPageState extends State<BrandMallContentPage> {
  BrandMallPrvide _prvide;
  String brandName;

  ///控制器
  EasyRefreshController _controller;
  int pageNo = 1;
  @override
  void initState() {
    super.initState();
    _prvide ??= widget._prvide;
    brandName ??= widget.brandName;
    _controller = EasyRefreshController();
    print('branfName--->$brandName');
    _initBrandMallData();
  }

  _initBrandMallData() {
    _prvide
        .brandMallData(widget._mainProvide.splashModel.exhibitionID,brandName, pageNo,
    context)
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .listen((items) {
      print('brandMallitems=============>${items.data}');
      if (items.data != null) {
        setState(() {
          _prvide.addBrandMall(BrandMallModelList.fromJson(items.data).list);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body:ListWidgetPage(
        controller: _controller,
        onRefresh: () async {
          pageNo = 1;
          _prvide.clranBrandMall();
          _initBrandMallData();
        },
        onLoad: () async {
         pageNo++;
          _initBrandMallData();
        },
        child: <Widget>[
          SliverAppBar(
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context,true);
                },
                child: Icon(Icons.keyboard_arrow_down),
              ),
              pinned:true,
              expandedHeight: 240.0,
              flexibleSpace: FlexibleSpaceBar(
                background: _setupHeand(),
              )
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _setupBody(),
            ]),
          )
        ],
      ),
    );
  }

  Provide<BrandMallPrvide> _setupHeand() {
    return Provide<BrandMallPrvide>(
      builder: (BuildContext context, Widget child, BrandMallPrvide proivde) {
        return Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(400),
          //  color: Colors.yellow,
          child: widget.pic!=null&&(widget.pic).indexOf("http")>-1?
          CachedNetworkImage(
              imageUrl: "${widget.pic}${ConstConfig.BANNER_MINI_SIZE}",
              fit: BoxFit.fitWidth):
          Image.asset("assets/images/default/default_squre_img.png", fit: BoxFit.cover,),
        );
      },
    );
  }

  Provide<BrandMallPrvide> _setupBody() {
    return Provide<BrandMallPrvide>(
      builder: (BuildContext context, Widget child, BrandMallPrvide provide) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: provide.brandMallList.length,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: ScreenAdapter.width(20)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: ScreenAdapter.width(20),
            crossAxisSpacing: ScreenAdapter.width(20),
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                /// 跳转详情
                // 解析二维码
                String result = provide.brandMallList[index].qrCode;
                List list = result.split("&&");
                var json = {
                  "qrType":list[0],
                  "qrCode":list[1]
                };
//                Loading.ctx=context;
//                Loading.show();
                widget._homeProvide.qrCodeWhisk(json,context:context)
                    .doOnListen((){}).doOnCancel((){})
                    .listen((item){
//                      Loading.remove();
                  if(item!=null&&item.data!=null){
                    if(list[0]=="EXHIBIT_PRODUCT"){
                      // 商品详情
                      CommodityModels models = CommodityModels.fromJson(item.data);
                      widget._detailProvide.clearCommodityModels();
                      widget._detailProvide.prodId = models.prodID;
                      /// 加载详情数据
                      widget._detailProvide.setCommodityModels(models);
                      widget._detailProvide.setInitData();
                      widget._cartProvide.setInitCount();
                      widget._detailProvide.isBuy = false;
                      Navigator.push(context, MaterialPageRoute(
                          builder:(context){
                            return new CommodityDetailPage(pages: ConstConfig.EXHIBIT_PRODUCT,);
                          }
                      )
                      );
                    }
                  }else{
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return LoginPage();
                      }
                    ));
                  }
                });
//                _loadDetail(provide.brandMallList[index].prodID,
//                    provide.brandMallList[index].shopID);
              },
              child: Container(
                width: ScreenAdapter.width(340),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(340),
                      child: provide.brandMallList[index].prodPic==null?
                          Image.asset("assets/images/default/default_img.png",
                          fit: BoxFit.fitWidth,):CachedNetworkImage(
                        imageUrl:"${provide.brandMallList[index].prodPic}${ConstConfig.BANNER_FOUR_SIZE}",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                        width: ScreenAdapter.width(340),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Text(
                                '￥ ${provide.brandMallList[index].salesPriceRange}')
                          ],
                        )),
                    Container(
                        width: ScreenAdapter.width(340),
                        height: ScreenAdapter.height(75),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: ScreenAdapter.width(40),
                            ),
                            Container(
                              width: ScreenAdapter.width(300),
                              child: Text(
                                '${provide.brandMallList[index].prodName}',
                                softWrap: true,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  /// 跳转详情
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
      widget._detailProvide.setCommodityModels(CommodityModels.fromJson(item.data));
      widget._detailProvide.setInitData();
      widget._cartProvide.setInitCount();
      widget._detailProvide.isBuy = false;
      Navigator.push(context, MaterialPageRoute(
          builder:(context){
            return new CommodityDetailPage(pages: ConstConfig.EXHIBIT_PRODUCT,);
          }
      )
      );
//      _provide
    }, onError: (e) {});
  }
}
