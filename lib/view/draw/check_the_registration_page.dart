import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/check_the_registration_provide.dart';
import 'package:innetsect/view/widget/loading_state_widget.dart';
import 'package:provide/provide.dart';

class CheckTheRegistrationPage extends PageProvideNode {
  final CheckTheRegistrationProvide _provide = CheckTheRegistrationProvide();
  final Map draweeModel;
  CheckTheRegistrationPage({this.draweeModel}) {
    mProviders.provide(Provider<CheckTheRegistrationProvide>.value(_provide));
    _provide.id = draweeModel['drawID'];
    _provide.shopId = draweeModel['shopID'];
    _provide.longitude = draweeModel['longitude'];
    _provide.latitude = draweeModel['latitude'];

    print('_provide.draweeModel.drawID=====>${_provide.id}');
    print('_provide.draweeModel.shopID=====>${_provide.shopId}');
    print('CheckTheRegistrationPage->longitude=====>${_provide.longitude }');
    print('CheckTheRegistrationPage->latitude=====>${_provide.latitude}');
  }
  @override
  Widget buildContent(BuildContext context) {
    return CheckTheRegistrationContentPage(_provide);
  }
}

class CheckTheRegistrationContentPage extends StatefulWidget {
  final CheckTheRegistrationProvide provide;
  CheckTheRegistrationContentPage(this.provide);
  @override
  _CheckTheRegistrationContentPageState createState() =>
      _CheckTheRegistrationContentPageState();
}

class _CheckTheRegistrationContentPageState
    extends State<CheckTheRegistrationContentPage> {
  CheckTheRegistrationProvide provide;
  LoadState _loadState = LoadState.State_Loading;
  @override
  void initState() {
    super.initState();
    provide ??= widget.provide;
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
      print('items.data=====>${items.data}');
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
          title: Text(''),
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
                _setupEnd(),
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
              height: ScreenAdapter.height(300),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: ScreenAdapter.width(30),
                  ),
                  Container(
                    width: ScreenAdapter.width(210),
                    height: ScreenAdapter.height(210),
                    child: Image.network(
                      provide
                          .viewRegistrationInformationModel.shopProduct.prodPic,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: ScreenAdapter.width(40),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(400),
                        child: Text(
                          provide.viewRegistrationInformationModel.shopProduct
                              .prodName,
                          style: TextStyle(
                              fontSize: ScreenAdapter.size(30),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(10),
                      ),
                      SizedBox(
                        height: ScreenAdapter.height(30),
                      ),
                      Container(
                        width: ScreenAdapter.width(400),
                        child: Text(
                          '${provide.viewRegistrationInformationModel.shopProduct.shopName}   |   ￥${provide.viewRegistrationInformationModel.shopProduct.prodPrice}',
                          style: TextStyle(
                            fontSize: ScreenAdapter.size(30),
                            color: Color.fromRGBO(160, 160, 160, 1.0),
                            //    fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
                    Text(
                      '购买门店: ',
                      style: TextStyle(
                          fontSize: ScreenAdapter.size(30),
                          color: Colors.black54),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      provide.viewRegistrationInformationModel.shopProduct
                          .shopName,
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
                height: ScreenAdapter.height(90),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: ScreenAdapter.height(90),
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
                      height: ScreenAdapter.height(90),
                      child: Text(
                        provide.viewRegistrationInformationModel.shopProduct.addr,
                      //  overflow: TextOverflow.ellipsis,
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
                      provide.viewRegistrationInformationModel.drawee.mobile,
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
              height: ScreenAdapter.height(170),
              child:
                  provide.viewRegistrationInformationModel.drawee.status ==
                          1
                      ?
                       Image.asset(
                          'assets/images/mall/中签大.png',
                          width: ScreenAdapter.width(170),
                          height: ScreenAdapter.height(170),
                        )
                      : Container(),
            ),
            SizedBox(
              height: ScreenAdapter.height(40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/mallPage', (route) => route == null);
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
