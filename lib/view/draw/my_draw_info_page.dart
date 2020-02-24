import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/data/draw/shops_data.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/my_draw_info_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:provide/provide.dart';

///我的抽签详情

class MyDrawInfoPage extends PageProvideNode {
  final MyDrawInfoProvide _provide = MyDrawInfoProvide();
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  
  final Map myDrawDataModel;
  MyDrawInfoPage({this.myDrawDataModel}) {
    mProviders.provide(Provider<MyDrawInfoProvide>.value(_provide));
    _provide.dataModel = myDrawDataModel['myDrawDataModel'];
  }
  @override
  Widget buildContent(BuildContext context) {
    return MyDrawInfoContentPage(_provide, _orderDetailProvide);
  }
}

class MyDrawInfoContentPage extends StatefulWidget {
  final MyDrawInfoProvide provide;
  final OrderDetailProvide orderDetailProvide;
  MyDrawInfoContentPage(this.provide, this.orderDetailProvide);
  @override
  _MyDrawInfoContentPageState createState() => _MyDrawInfoContentPageState();
}

class _MyDrawInfoContentPageState extends State<MyDrawInfoContentPage> {
  MyDrawInfoProvide provide;
  OrderDetailProvide orderDetailProvide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    orderDetailProvide ??= widget.orderDetailProvide;

    _loadViewRegistrationInformation();
   
  }
  _loadDrawsData(){
    provide.draws(provide.viewRegistrationInformationModel.drawee.drawID).doOnListen(() {}).listen((items) {
      print('items.data====> ${items.data}');
      if (items.data != null) {
        provide.drawsModel = DrawsModel.fromJson(items.data);
        print('steps=====>${provide.drawsModel.steps.length}');
        print('shops=====>${provide.drawsModel.shops.length}');
        print('pics====>${provide.drawsModel.pics.length}');
        print('drawAwardType====>${provide.drawsModel.drawAwardType}');
        print('drawBySku=========>${provide.drawsModel.drawBySku}');
        print('skus===============>${provide.drawsModel.shops[0].skus}');

        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    });
  }

  _loadViewRegistrationInformation() {
    provide
        .viewRegistrationInformation()
        .doOnListen(() {})
        .doOnError((e, stack) {})
        .doOnDone(() {
      //DraweeModel
      // DraweeModel drawee;
      //ShopProductModel
      //ShopProductModel shopProduct;
    }).listen((items) {
      // print('items.data=====>${items.data}');
      if (items.data != null) {
        provide.viewRegistrationInformationModel =
            ViewRegistrationInformationModel.fromJson(items.data);
            _loadDrawsData();
        // print(
        //     'DraweeModel=======>${provide.viewRegistrationInformationModel.drawee.shopID}');
        // print(
        //     'ShopProductModel=======>${provide.viewRegistrationInformationModel.shopProduct.shopID}');
        // setState(() {
        //   _loadState = LoadState.State_Success;
        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('抽签详情'),
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
        body: LoadStateLayout(
          state: _loadState,
          loadingContent: '加载中...',
          successWidget: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _setupHead(),
                Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(1),
                  color: Colors.black54,
                ),
                SizedBox(
                  height: ScreenAdapter.height(20),
                ),
                _setupBody(),
                // provide.dataModel.drawAwardType != 0
                //     ?
                _setupEnd()
                // : provide.dataModel.drawAwardType == 0
                //     ? provide.dataModel.expiryTime == null ||
                //             provide.dataModel.expiryTime == ''
                //         ? _setupEndWaiting()
                //         : provide.dataModel.drawAwardType == 0 &&
                //                 provide.dataModel.status == 1
                //             ? _setupEndBuy()
                //             : provide.dataModel.drawAwardType == 0 &&
                //                     provide.dataModel.status == -1
                //                 ? _setupEndBuyNoCodes()
                //                 : provide.dataModel.drawAwardType == 0 &&
                //                         provide.dataModel.status == 0
                //                     ? _setupEnd()
                //                     : _setupEndWaiting()
                //     : Container()
              ],
            ),
          ),
        ));
  }

  Provide<MyDrawInfoProvide> _setupHead() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        //  print('status====>${provide.viewRegistrationInformationModel.shopProduct.status}');
        return Stack(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(260),
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(690),
                    height: ScreenAdapter.height(80),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      provide.viewRegistrationInformationModel.shopProduct
                          .prodName,
                      style: TextStyle(
                        fontSize: ScreenAdapter.size(30),
                        // fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      ShopsModel shopsModel = ShopsModel();
                      shopsModel.drawID = provide.viewRegistrationInformationModel.shopProduct.drawID;
                      shopsModel.shopID = provide.viewRegistrationInformationModel.shopProduct.shopID;
                      shopsModel.shopName = provide.viewRegistrationInformationModel.shopProduct.shopName;
                      
                      print('InkWell.......');
                      Navigator.pushNamed(context, '/endOfTheDrawPage'
                      , arguments: {
                          'pics': provide.drawsModel.pics,
                          'shops':shopsModel,
                          'longitude': provide.dataModel.longitude,
                          'latitude': provide.dataModel.latitude,
                          'steps': provide.drawsModel.steps,
                          'drawAwardType': provide.drawsModel.drawAwardType,
                          'drawBySku':provide.drawsModel.drawBySku,
                          'drawProdID':provide.drawsModel.drawProdID,
                          //'suks': provide.dataModel.skus,
                          'endTime':provide.drawsModel.endTime,
                         
                        }
                      );
                      
                    },
                    child: Container(
                      width: ScreenAdapter.width(690),
                      height: ScreenAdapter.height(150),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: ScreenAdapter.width(20),
                          ),
                          Container(
                            width: ScreenAdapter.width(126),
                            height: ScreenAdapter.width(126),
                            child: Image.network(
                              provide.viewRegistrationInformationModel.shopProduct
                                  .prodPic,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: ScreenAdapter.width(65),
                          ),
                          Text(
                            '${provide.viewRegistrationInformationModel.shopProduct.shopName}   |   ￥${provide.viewRegistrationInformationModel.shopProduct.prodPrice}',
                            style: TextStyle(
                              fontSize: ScreenAdapter.size(30),
                              //               color: Color.fromRGBO(160, 160, 160, 1.0),
                              //               //    fontWeight: FontWeight.w700
                            ),
                          ),
                          Expanded(
                            child: Container()
                          ),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // child: Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: ScreenAdapter.width(30),
              //     ),
              //     Container(
              //       width: ScreenAdapter.width(210),
              //       height: ScreenAdapter.height(210),
              //       child: Image.network(
              //         provide.viewRegistrationInformationModel.shopProduct.prodPic,
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //     SizedBox(
              //       width: ScreenAdapter.width(40),
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Container(
              //           width: ScreenAdapter.width(400),
              //           child: Text(
              //             provide.dataModel.drawName,
              //             style: TextStyle(
              //               fontSize: ScreenAdapter.size(30),
              //               // fontWeight: FontWeight.w700
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: ScreenAdapter.height(10),
              //         ),
              //         SizedBox(
              //           height: ScreenAdapter.height(30),
              //         ),
              //         Container(
              //           width: ScreenAdapter.width(400),
              //           child: Text(
              //             '${provide.viewRegistrationInformationModel.shopProduct.shopName}   |   ￥${provide.viewRegistrationInformationModel.shopProduct.prodPrice}',
              //             style: TextStyle(
              //                 fontSize: ScreenAdapter.size(30),
              //                 color: Colors.black54
              //                 //fontWeight: FontWeight.w700
              //                 ),
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ),
          ],
        );
      },
    );
  }

  Provide<MyDrawInfoProvide> _setupBody() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(65),
                  child: Row(
                    children: <Widget>[
                      provide.viewRegistrationInformationModel.drawee
                                  .drawAwardType ==
                              0
                          ? Text(
                              '姓名: ',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.size(30),
                                  color: Colors.black54),
                            )
                          : Text(
                              '购买门店: ',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.size(30),
                                  color: Colors.black54),
                            ),
                      Expanded(
                        child: Container(),
                      ),
                      provide.viewRegistrationInformationModel.drawee
                                  .drawAwardType ==
                              0
                          ? Text(
                              provide.viewRegistrationInformationModel.drawee
                                  .realName,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.size(30),
                                  color: Colors.black54),
                            )
                          : Text(
                              provide.viewRegistrationInformationModel.shopProduct
                                  .shopName,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.size(30),
                                  color: Colors.black54),
                            ),
                    ],
                  )),
              provide.viewRegistrationInformationModel.drawee.drawAwardType == 0
                  ? Container()
                  : SizedBox(
                      height: ScreenAdapter.height(30),
                    ),
              provide.viewRegistrationInformationModel.drawee.drawAwardType == 0
                  ? Container()
                  : Container(
                      width: ScreenAdapter.width(690),
                      height: ScreenAdapter.height(140),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: ScreenAdapter.height(140),
                            child: Text(
                              '门店地址: ',
                              style: TextStyle(
                                  fontSize: ScreenAdapter.size(30),
                                  color: Colors.black54),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          provide.viewRegistrationInformationModel.drawee
                                      .drawAwardType ==
                                  0
                              ? Container()
                              : Container(
                                  alignment: Alignment.topRight,
                                  width: ScreenAdapter.width(500),
                                  height: ScreenAdapter.height(140),
                                  child: Text(
                                    //  '电话你副科级安徽的看法几哈大立科技发哈空间大黄蜂科技的恢复了空间划分即可垃圾少得可怜',
                                    provide.viewRegistrationInformationModel
                                        .shopProduct.addr,
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        color: Colors.black54),
                                  ),
                                ),
                        ],
                      )),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(65),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '手机号: ',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        '+' +
                            provide.dataModel.telPrefix +
                            provide.dataModel.mobile,
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                    ],
                  )),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(65),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '有效证件: ',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        provide.dataModel.icNo,
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                    ],
                  )),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              provide.viewRegistrationInformationModel.drawee.drawAwardType == 0
                  ? Container(
                      width: ScreenAdapter.width(690),
                      height: ScreenAdapter.height(65),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '所选规格: ',
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            provide
                                .viewRegistrationInformationModel.drawee.skuSpecs,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
                        ],
                      ))
                  : Container(),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(65),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '登记时间: ',
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        provide.dataModel.registerDate,
                        style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Colors.black54),
                      ),
                    ],
                  )),
              SizedBox(
                height: ScreenAdapter.height(30),
              ),
              provide.viewRegistrationInformationModel.drawee.drawAwardType != 0
                  ? Container(
                      width: ScreenAdapter.width(690),
                      height: ScreenAdapter.height(65),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '购买开始时间: ',
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            provide.viewRegistrationInformationModel.shopProduct
                                .startBuyingTime,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
                        ],
                      ))
                  : provide.viewRegistrationInformationModel.drawee
                              .drawAwardType ==
                          0
                      ? provide.viewRegistrationInformationModel.drawee
                                  .expiryTime ==
                              null
                          ? Container()
                          : provide.viewRegistrationInformationModel.drawee.status == 0? Container(): Container(
                              width: ScreenAdapter.width(690),
                              height: ScreenAdapter.height(65),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '有效期截至: ',
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        color: Colors.black54),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Text(
                                    provide.viewRegistrationInformationModel
                                        .drawee.expiryTime,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.size(30),
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                            )
                      : Container(),
              Container(
                  alignment: Alignment.center,
                  child: provide.dataModel.status == 1 &&
                          provide.dataModel.expired == false
                      ? Image.asset(
                          'assets/images/中签.png',
                          width: ScreenAdapter.width(170),
                          height: ScreenAdapter.height(170),
                        )
                      : provide.dataModel.status == 1 &&
                              provide.dataModel.expired == true
                          ? Image.asset(
                              'assets/images/已过期.png',
                              width: ScreenAdapter.width(170),
                              height: ScreenAdapter.height(170),
                            )
                          : provide.dataModel.status == -1 &&
                                  provide.dataModel.expired == false
                              ? Image.asset(
                                  'assets/images/未中签.png',
                                  width: ScreenAdapter.width(170),
                                  height: ScreenAdapter.height(170),
                                )
                              : provide.dataModel.status == -1 &&
                                      provide.dataModel.expired == true
                                  ? Image.asset(
                                      'assets/images/未中签.png',
                                      width: ScreenAdapter.width(170),
                                      height: ScreenAdapter.height(170),
                                    )
                                  : provide.dataModel.status == 2
                                      ? Image.asset(
                                          'assets/images/已使用.png',
                                          width: ScreenAdapter.width(170),
                                          height: ScreenAdapter.height(170),
                                        )
                                      : Container(
                                          height: ScreenAdapter.height(170),
                                        )

                  // : provide.dataModel.status == -1
                  //     ? Image.asset(
                  //         'assets/images/未中签.png',
                  //         width: ScreenAdapter.width(170),
                  //         height: ScreenAdapter.height(170),
                  //       )
                  //     : provide.dataModel.status == 0 && provide.viewRegistrationInformationModel.drawee.expired == true
                  //         ? Container(
                  //             height: ScreenAdapter.height(170),
                  //             child: Image.asset(
                  //             'assets/images/已过期.png',
                  //             width: ScreenAdapter.width(170),
                  //             height: ScreenAdapter.height(170),
                  //           ),
                  //           )
                  //         : Container(
                  //           height: ScreenAdapter.height(170),
                  //         )

                  )
            ],
          ),
        );
      },
    );
  }

  ///线下按钮
  Provide<MyDrawInfoProvide> _setupEnd() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            GestureDetector(
              onTap: () {
                // _loadState = LoadState.State_Loading;

                // Navigator.pop(context);
                if (provide.dataModel.drawAwardType != 0 &&
                    provide.dataModel.status == 0) {
                  //线下已登记
                  // Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == 0) {
                  //线上已登记

                }
                if (provide.dataModel.drawAwardType != 0 &&
                    provide.dataModel.status == 0) {
                  //线下中签
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == 1 &&
                    provide.dataModel.expired == false) {
                  //线上已中签

                  Fluttertoast.showToast(
                      msg: '加载中...', gravity: ToastGravity.CENTER);

                  provide
                      .salesOrder(provide
                          .viewRegistrationInformationModel.drawee.drawID)
                      .doOnListen(() {})
                      .doOnError((e, stack) {})
                      .listen((items) {
                    print('items===============>${items.data}');
                    if (items.data != null) {
                      OrderDetailModel model =
                          OrderDetailModel.fromJson(items.data);
                      print('===========>$model');
                      orderDetailProvide.orderDetailModel = model;
                      orderDetailProvide.skuSpecs = provide.viewRegistrationInformationModel.drawee.skuSpecs;
                      orderDetailProvide.prodName = provide.viewRegistrationInformationModel.shopProduct.prodName;

                      Navigator.pushNamed(context, '/orderDetailPage'
                          // arguments: {
                          //   'prodName': provide.viewRegistrationInformationModel
                          //       .shopProduct.prodName,
                          //   'skuSpecs': provide.viewRegistrationInformationModel
                          //       .drawee.skuSpecs
                          // }
                          );
                      // setState(() {
                      //   _loadState = LoadState.State_Success;
                      // });
                    }
                  });
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == 1 &&
                    provide.dataModel.expired == true) {
                  ///线上已过期
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == -1) {
                  ///线上未中签
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType != 0 &&
                    provide.dataModel.status == -1) {
                  //线下未中签
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType != 0 &&
                    provide.dataModel.status == 2) {
                  //线下已使用
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == 2) {
                  //线上已使用
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType == 0 &&
                    provide.dataModel.status == -2) {
                  //线上黑名单
                  Navigator.pop(context);
                }
                if (provide.dataModel.drawAwardType != 0 &&
                    provide.dataModel.status == -2) {
                  //线下黑名单
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                color: provide.dataModel.drawAwardType != 0 &&
                        provide.dataModel.status == 0
                    ? Color.fromRGBO(242, 242, 242, 1.0)
                    : provide.dataModel.drawAwardType == 0 &&
                            provide.dataModel.status == 0
                        ? Color.fromRGBO(242, 242, 242, 1.0)
                        : Colors.black,
                child: Center(
                  child: provide.dataModel.drawAwardType != 0 &&
                          provide.dataModel.status == 0
                      ? Text(
                          //线下已登记
                          '等待结果',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenAdapter.size(30),
                              fontWeight: FontWeight.w800),
                        )
                      : provide.dataModel.drawAwardType == 0 &&
                              provide.dataModel.status == 0 //线上已登记
                          ? Text(
                              '等待结果',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ScreenAdapter.size(30),
                                  fontWeight: FontWeight.w800),
                            )
                          : provide.dataModel.drawAwardType == 0 &&
                                  provide.dataModel.status == 1 &&
                                  provide.dataModel.expired == false //线上已中签
                              ? Text(
                                  '立即购买',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenAdapter.size(30),
                                      fontWeight: FontWeight.w800),
                                )
                              : provide.dataModel.drawAwardType == 0 &&
                                      provide.dataModel.status == 1 &&
                                      provide.dataModel.expired == true //线上已过期
                                  ? Text(
                                      '返回',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenAdapter.size(30),
                                          fontWeight: FontWeight.w800),
                                    )
                                  : Text(
                                      '返回',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenAdapter.size(30),
                                          fontWeight: FontWeight.w800),
                                    ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  ///等待按钮
  Provide<MyDrawInfoProvide> _setupEndWaiting() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                color: Color.fromRGBO(242, 242, 242, 1.0),
                child: Center(
                  child: Text(
                    '等待抽签结果公布',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  ///立即购买
  Provide<MyDrawInfoProvide> _setupEndBuy() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            GestureDetector(
              onTap: () {
                // Fluttertoast.showToast(msg: '加载中...', gravity: ToastGravity.CENTER);
                provide
                    .salesOrder(
                        provide.viewRegistrationInformationModel.drawee.drawID)
                    .doOnListen(() {})
                    .doOnError((e, stack) {})
                    .listen((items) {
                  print('items===============>${items.data}');
                  if (items.data != null) {
                    OrderDetailModel model =
                        OrderDetailModel.fromJson(items.data);
                    print('===========>$model');
                    orderDetailProvide.orderDetailModel = model;

                    Navigator.pushNamed(context, '/orderDetailPage');
                  }
                });
              },
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                color: Colors.black,
                child: Center(
                  child: Text(
                    '立即购买',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  //未中签
  Provide<MyDrawInfoProvide> _setupEndBuyNoCodes() {
    return Provide<MyDrawInfoProvide>(
      builder: (BuildContext context, Widget child, MyDrawInfoProvide provide) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: ScreenAdapter.width(690),
                height: ScreenAdapter.height(90),
                color: Colors.black,
                child: Center(
                  child: Text(
                    '返回',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdapter.size(30),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
