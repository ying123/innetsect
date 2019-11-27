import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/brand_mall_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/brand/brand_mall_provide.dart';
import 'package:innetsect/view/widget/list_widget_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BrandMallPage extends PageProvideNode {
  final BrandMallPrvide _prvide = BrandMallPrvide();
  String brandName;
  BrandMallPage(this.brandName) {
    mProviders.provide(Provider<BrandMallPrvide>.value(_prvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BrandMallContentPage(_prvide, brandName);
  }
}

class BrandMallContentPage extends StatefulWidget {
  final BrandMallPrvide _prvide;
  String brandName;
  BrandMallContentPage(this._prvide, this.brandName);
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
    print('branfName--->$brandName');
    _initBrandMallData();
  }

  _initBrandMallData() {
    _prvide
        .brandMallData(brandName, pageNo)
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .listen((items) {
      print('brandMallitems=============>${items.data}');
      if (items.data != null) {
        _prvide.addBrandMall(BrandMallModelList.fromJson(items.data).list);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('品牌商城'),
      //   centerTitle: true,
      // ),
      body: ListWidgetPage(
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
          SliverList(
            delegate: SliverChildListDelegate([
              _setupHeand(),
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
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(518),
              //  color: Colors.yellow,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(40),
              top: ScreenAdapter.height(80),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/images/xiangxia.png',
                  fit: BoxFit.none,
                  width: ScreenAdapter.width(38),
                  height: ScreenAdapter.width(38),
                ),
              ),
            )
          ],
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
            return Container(
              width: ScreenAdapter.width(340),
              height: ScreenAdapter.height(600),
              // color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(340),
                    height: ScreenAdapter.height(400),
                    child: Image.network(
                      provide.brandMallList[index].prodPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      width: ScreenAdapter.width(340),
                      height: ScreenAdapter.height(50),
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
            );
          },
        );
      },
    );
  }
  // _loadBrandMallData(){
  //   print('brandName}}}}}}}}}}}}]=>$brandName');
  //   print('pageNo}}}}}}}}}}}}]=>$pageNo');
  //   _prvide.brandMallData(this.brandName, pageNo++).doOnListen((){
      
  //   }).doOnError((){

  //   }).listen((item){
  //     print('item===============>${item.data}');
  //   });
  // }
}
