import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/exhibition/sign_model.dart';
import 'package:innetsect/data/exhibition/sign_parent_model.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/binding_sign_in/binding_sign_in_proivde.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:rammus/rammus.dart' as rammus;

class BindingSignInPage extends PageProvideNode {
  final BingdingSignInProvide _provide = BingdingSignInProvide();
  final MainProvide _mainProvide = MainProvide.instance;
  BindingSignInPage() {
    mProviders.provide(Provider<BingdingSignInProvide>.value(_provide));
    mProviders.provide(Provider<MainProvide>.value(_mainProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BindingSignInContentPage(_provide,_mainProvide);
  }
}

class BindingSignInContentPage extends StatefulWidget {
  final BingdingSignInProvide _provide;
  final MainProvide _mainProvide;
  BindingSignInContentPage(this._provide,this._mainProvide);
  @override
  _BindingSignInContentPageState createState() =>
      _BindingSignInContentPageState();
}

class _BindingSignInContentPageState extends State<BindingSignInContentPage> {
  BingdingSignInProvide _provide;
  MainProvide _mainProvide;

  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
    _mainProvide ??= widget._mainProvide;
    _loadQrcodeData();
    rammus.onMessageArrived.listen((data){
        var jsons = json.decode(data.content);
        SignParentModel model = SignParentModel.fromJson(jsons);
        Future.delayed(Duration.zero,(){
          CustomsWidget().customShowDialog(context: context,isCancel: false,
          title: model.data.welcomeTitle,
          content: model.data.welcomeText,
          submitTitle: "下一步",
          submitColor: Colors.blue,
          onPressed: (){
            if(model.redirectType==ConstConfig.EXHIBITION_SIGNED_IN){
              _mainProvide.splashModel.attended = model.data.success;
              Future.delayed(Duration(milliseconds: 500),(){
                Navigator.of(context).popAndPushNamed("/SignProtocolPage");
              });
            }
          });
        });
    });
  }

  _loadQrcodeData() {
    _provide.qrcodeData().doOnListen((){

    }).doOnError((e,stack){

    }).listen((item){
      if (item != null) {
          _provide.qrCode = item.data['qrCode'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomsWidget().customNav(context: context,
      widget: new Text("绑定签到",style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900 ),)
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: ScreenAdapter.width(110),
              top: ScreenAdapter.height(150),
            ),
            child: Container(
              width: ScreenAdapter.width(528),
              height: ScreenAdapter.height(715),
              // color: Colors.yellow,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenAdapter.height(112),
                  ),
                  Text(
                    '二维码三分钟内有效',
                    style: TextStyle(fontSize: ScreenAdapter.size(32),
                    color: AppConfig.blueBtnColor),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(60),
                  ),
                  _bindWidget()
                ],
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(242, 243, 245, 1.0),
                    blurRadius: 3,
                    spreadRadius: 3)
              ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(120),
        child: Center(
          child: InkWell(
            onTap: (){
              /// 验证是否签到
              _provide.validQrcode(_mainProvide.splashModel.exhibitionID).doOnListen(() {
              print('doOnListen');
              })
                  .doOnCancel(() {})
                  .listen((item) {
                ///加载数据
                print('listen data->$item');
                if(item!=null&&item.data!=null){
                  SignModel model = SignModel.fromJson(item.data);
                  if(model.success){
                    CustomsWidget().customShowDialog(context: context,
                      title: model.welcomeTitle,
                      content: model.welcomeText,
                      isCancel: false,
                      submitTitle: "下一步",
                      submitColor: Colors.blue,
                      onPressed: (){
                        Navigator.of(context).popAndPushNamed("/SignProtocolPage");
                      }
                    );
                  }else{
                    CustomsWidget().customShowDialog(context: context,
                        title: model.welcomeTitle,
                      content: model.welcomeText,
                      isCancel: false,
                      submitTitle: "重新扫描",
                    );
                  }
                }
              }, onError: (e) {});

            },
            child: Container(
              width: ScreenAdapter.width(697),
              height: ScreenAdapter.height(80),
              color: Colors.black,
              child: Center(
                child: Text(
                  '下一步',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenAdapter.size(36)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Provide<BingdingSignInProvide> _bindWidget(){
    return Provide<BingdingSignInProvide>(
      builder: (BuildContext context,Widget widget,BingdingSignInProvide provide){
        return InkWell(
          onTap: (){
            provide.qrcodeData().doOnListen((){

            }).doOnError((e,stack){

            }).listen((item){
              if (item.data['status'] == true) {
                Fluttertoast.showToast(
                  msg: '二维码刷新成功',
                  gravity: ToastGravity.CENTER,
                );
                setState(() {
                  provide.qrCode = item.data['qrCode'];
                });
              }
            });
          },
          child: Container(
              width: ScreenAdapter.width(377),
              height: ScreenAdapter.height(377),
              child: provide.qrCode!=""?QrImage(
                data: provide.qrCode,
                size: provide.size,
                version: QrVersions.auto,
                embeddedImage:AssetImage("assets/images/main/logo180x180.png"),
              ):Container(
                width: ScreenAdapter.width(377),
                height: ScreenAdapter.height(377),
                child: Text('请点击刷新二维码',style: TextStyle(
                    color: AppConfig.blueBtnColor,
                    fontSize: ScreenAdapter.size(28)
                ),),
              )
          ),
        );
      },
    );
  }
}
