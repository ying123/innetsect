import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/data/order_detail_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/check_the_registration_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:innetsect/view_model/mall/commodity/order_detail_provide.dart';
import 'package:provide/provide.dart';

class CheckTheRegistrationPage extends PageProvideNode {
  final CheckTheRegistrationProvide _provide = CheckTheRegistrationProvide();
  final OrderDetailProvide _orderDetailProvide = OrderDetailProvide.instance;
  final Map draweeModel;
  CheckTheRegistrationPage({this.draweeModel}) {
    mProviders.provide(Provider<CheckTheRegistrationProvide>.value(_provide));
    _provide.id = draweeModel['drawID'];
    _provide.shopId = draweeModel['shopID'];
    _provide.longitude = draweeModel['longitude'];
    _provide.latitude = draweeModel['latitude'];
    _provide.drawAwardType = draweeModel['drawAwardType'];
    // _provide.skuSpecs = draweeModel['skuSpecs'];

    print('_provide.draweeModel.drawID=====>${_provide.id}');
    print('_provide.draweeModel.shopID=====>${_provide.shopId}');
    print('CheckTheRegistrationPage->longitude=====>${_provide.longitude}');
    print('CheckTheRegistrationPage->latitude=====>${_provide.latitude}');
    print(
        'CheckTheRegistrationPage->drawAwardType=====>${_provide.drawAwardType}');
  }
  @override
  Widget buildContent(BuildContext context) {
    return CheckTheRegistrationContentPage(_provide, _orderDetailProvide);
  }
}

class CheckTheRegistrationContentPage extends StatefulWidget {
  final CheckTheRegistrationProvide provide;
  final OrderDetailProvide orderDetailProvide;
  CheckTheRegistrationContentPage(this.provide, this.orderDetailProvide);
  @override
  _CheckTheRegistrationContentPageState createState() =>
      _CheckTheRegistrationContentPageState();
}

class _CheckTheRegistrationContentPageState
    extends State<CheckTheRegistrationContentPage> {
  CheckTheRegistrationProvide provide;
  OrderDetailProvide orderDetailProvide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
    orderDetailProvide ??= widget.orderDetailProvide;
    _loadViewRegistrationInformation();
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
      print('items.data==>>>===>${items.data}');
      if (items.data != null) {
        provide.viewRegistrationInformationModel =
            ViewRegistrationInformationModel.fromJson(items.data);
        print(
            'DraweeModel=======>${provide.viewRegistrationInformationModel.drawee.shopID}');
        print(
            'ShopProductModel=======>${provide.viewRegistrationInformationModel.shopProduct.shopID}');
        setState(() {
          _loadState = LoadState.State_Success;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('登记信息'),
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
                //    Expanded(child:Container()),
                _setupEnd(),
                //  SizedBox(
                //     height: ScreenAdapter.height(20),
                //   ),
              ],
            ),
          ),
        ));
  }

  Provide<CheckTheRegistrationProvide> _setupHead() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
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
                        //                 fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenAdapter.width(690),
                    height: ScreenAdapter.height(150),
                    alignment: Alignment.bottomLeft,
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
                            '${provide.viewRegistrationInformationModel.shopProduct.shopName}   |   ￥${provide.viewRegistrationInformationModel.shopProduct.prodPrice}'
                              ,style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
              //               color: Color.fromRGBO(160, 160, 160, 1.0),
              //               //    fontWeight: FontWeight.w700
                              ),
                            ),
                      ],
                    ),
                  )
                ],
              ),
              // child: ,
              // child: Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: ScreenAdapter.width(30),
              //     ),
              //     Container(
              //       width: ScreenAdapter.width(210),
              //       height: ScreenAdapter.height(210),
              //       child: Image.network(
              //         provide
              //             .viewRegistrationInformationModel.shopProduct.prodPic,
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
              //             provide.viewRegistrationInformationModel.shopProduct
              //                 .prodName,
              //             style: TextStyle(
              //                 fontSize: ScreenAdapter.size(30),
              //                 fontWeight: FontWeight.w700),
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
              //               fontSize: ScreenAdapter.size(30),
              //               color: Color.fromRGBO(160, 160, 160, 1.0),
              //               //    fontWeight: FontWeight.w700
              //             ),
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
            ),
            // Positioned(
            //   left: ScreenAdapter.width(560),
            //   top: ScreenAdapter.height(100),
            //   child:provide.viewRegistrationInformationModel.shopProduct.status==1? Image.asset(
            //     'assets/images/mall/中签大.png',
            //     width: ScreenAdapter.width(170),
            //     height: ScreenAdapter.height(170),
            //   ):Container(

            //   ),
            // ),
          ],
        );
      },
    );
  }

  Provide<CheckTheRegistrationProvide> _setupBody() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
        return Column(
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
                          )
                  ],
                )),
            provide.viewRegistrationInformationModel.drawee.drawAwardType != 0
                ? SizedBox(
                    height: ScreenAdapter.height(30),
                  )
                : Container(),
            provide.viewRegistrationInformationModel.drawee.drawAwardType != 0
                ? Container(
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
                        Container(
                          alignment: Alignment.topRight,
                          width: ScreenAdapter.width(500),
                          height: ScreenAdapter.height(140),
                          child: Text(
                            provide.viewRegistrationInformationModel.shopProduct
                                .addr,
                            //  overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
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
                      '有效证件: ',
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(30),
                          color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      provide.viewRegistrationInformationModel.drawee.icNo,
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
                      '手机号: ',
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(30),
                          color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      provide.viewRegistrationInformationModel.drawee.mobile,
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(30),
                          color: Colors.black54),
                    ),
                  ],
                )),
            provide.viewRegistrationInformationModel.drawee.drawAwardType != 0
                ? Container()
                : SizedBox(
                    height: ScreenAdapter.height(30),
                  ),
            provide.viewRegistrationInformationModel.drawee.drawAwardType != 0
                ? Container()
                : Container(
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
                      '登记时间: ',
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(30),
                          color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      provide
                          .viewRegistrationInformationModel.drawee.registerDate,
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
                    provide.viewRegistrationInformationModel.drawee
                                .drawAwardType !=
                            0
                        ? Text(
                            '购买开始时间: ',
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          )
                        : Text(
                            '有效期截至: ',
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          ),
                    Expanded(
                      child: Container(),
                    ),
                    provide.viewRegistrationInformationModel.drawee
                                .drawAwardType !=
                            0
                        ? Text(
                            provide.viewRegistrationInformationModel.shopProduct
                                .startBuyingTime,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          )
                        : Text(
                            provide.viewRegistrationInformationModel.shopProduct
                                .expiryTime,
                            style: TextStyle(
                                fontSize: ScreenAdapter.size(30),
                                color: Colors.black54),
                          )
                  ],
                )),
          ],
        );
      },
    );
  }

  Provide<CheckTheRegistrationProvide> _setupEnd() {
    return Provide<CheckTheRegistrationProvide>(
      builder: (BuildContext context, Widget child,
          CheckTheRegistrationProvide provide) {
        return Column(
          children: <Widget>[
            Container(
                height: ScreenAdapter.height(130),
                child: provide.viewRegistrationInformationModel.drawee.status ==
                        1
                    ? Image.asset(
                        'assets/images/中签.png',
                        width: ScreenAdapter.width(170),
                        height: ScreenAdapter.height(170),
                      )
                    : provide.viewRegistrationInformationModel.drawee.status ==
                            -1
                        ? Image.asset(
                            'assets/images/未中签.png',
                            width: ScreenAdapter.width(170),
                            height: ScreenAdapter.height(170),
                          )
                        : Container()
                        
                        ),
           provide.viewRegistrationInformationModel.drawee.drawAwardType == 0 ?  SizedBox(
              height: ScreenAdapter.height(30),
            ):Container(),
             
            GestureDetector(
                onTap: () {
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, '/mallPage', (route) => route == null);
                  if (provide.viewRegistrationInformationModel.drawee.status ==
                      0) {
                    //已登记
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/mallPage', (route) => route == null);
                  }
                  if (provide.viewRegistrationInformationModel.drawee
                              .drawAwardType ==
                          0 &&
                      provide.viewRegistrationInformationModel.drawee.status ==
                          1) {
                    //线上已中签

                    provide
                        .salesOrder(provide
                            .viewRegistrationInformationModel.drawee.drawID)
                        .doOnListen(() {})
                        .doOnError((e, stack) {})
                        .listen((items) {
                      if (items.data != null) {
                        OrderDetailModel model =
                            OrderDetailModel.fromJson(items.data);
                        print('===========>$model');
                        orderDetailProvide.orderDetailModel = model;
                        Navigator.pushNamed(context, '/orderDetailPage');
                      }
                    });
                  }
                  if (provide.viewRegistrationInformationModel.drawee.status ==
                      2) {
                    //已使用
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mallPage', (route) => route == null);
                  }
                  if (provide.viewRegistrationInformationModel.drawee.status ==
                      -1) {
                    //未中签
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mallPage', (route) => route == null);
                  }
                  if (provide.viewRegistrationInformationModel.drawee.status ==
                      -2) {
                    //黑名单
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mallPage', (route) => route == null);
                  }
                  if (provide.viewRegistrationInformationModel.drawee.status ==
                          1 &&
                      provide.viewRegistrationInformationModel.drawee
                              .drawAwardType !=
                          0) {
                    //线下中签
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/mallPage', (route) => route == null);
                  }
                },
                child: Container(
                  width: ScreenAdapter.width(690),
                  height: ScreenAdapter.height(100),
                  child: Center(
                    child: Container(
                      width: ScreenAdapter.width(690),
                      height: ScreenAdapter.height(90),
                      color: provide.viewRegistrationInformationModel.drawee
                                      .drawAwardType ==
                                  0 &&
                              provide.viewRegistrationInformationModel.drawee
                                      .status ==
                                  0
                          ? Color.fromRGBO(242, 242, 242, 1)
                          : Colors.black,
                      child: Center(
                          child: provide.viewRegistrationInformationModel.drawee
                                      .drawAwardType !=
                                  0
                              ? Text(
                                  '返回',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenAdapter.size(30),
                                      fontWeight: FontWeight.w800),
                                )
                              : provide.viewRegistrationInformationModel.drawee.drawAwardType == 0 &&
                                      provide.viewRegistrationInformationModel
                                              .drawee.status ==
                                          0
                                  ? Text(
                                      '等待结果',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenAdapter.size(30),
                                          fontWeight: FontWeight.w600),
                                    )
                                  : provide.viewRegistrationInformationModel
                                                  .drawee.drawAwardType ==
                                              0 &&
                                          provide.viewRegistrationInformationModel
                                                  .drawee.status ==
                                              1
                                      ? Text(
                                          '立即购买',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenAdapter.size(30),
                                              fontWeight: FontWeight.w800),
                                        )
                                      : provide.viewRegistrationInformationModel
                                                      .drawee.drawAwardType ==
                                                  0 &&
                                              provide.viewRegistrationInformationModel
                                                      .drawee.status ==
                                                  2
                                          ? Text(
                                              '返回',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      ScreenAdapter.size(30),
                                                  fontWeight: FontWeight.w800),
                                            )
                                          : provide.viewRegistrationInformationModel
                                                          .drawee.drawAwardType ==
                                                      0 &&
                                                  provide.viewRegistrationInformationModel.drawee.status == -1
                                              ? Text(
                                                  '返回',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          ScreenAdapter.size(
                                                              30),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )
                                              : provide.viewRegistrationInformationModel.drawee.drawAwardType == 0 && provide.viewRegistrationInformationModel.drawee.status == -2
                                                  ? Text(
                                                      '返回',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              ScreenAdapter
                                                                  .size(30),
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    )
                                                  : Container()),
                    ),
                  ),
                )),
                SizedBox(
                  height: ScreenAdapter.height(20),
                )
          ],
        );
      },
    );
  }
}
