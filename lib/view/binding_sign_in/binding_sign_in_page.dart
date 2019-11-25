import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/binding_sign_in/binding_sign_in_proivde.dart';
import 'package:provide/provide.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BindingSignInPage extends PageProvideNode {
  final BingdingSignInProvide _provide = BingdingSignInProvide();
  BindingSignInPage() {
    mProviders.provide(Provider<BingdingSignInProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return BindingSignInContentPage(_provide);
  }
}

class BindingSignInContentPage extends StatefulWidget {
  final BingdingSignInProvide _provide;
  BindingSignInContentPage(this._provide);
  @override
  _BindingSignInContentPageState createState() =>
      _BindingSignInContentPageState();
}

class _BindingSignInContentPageState extends State<BindingSignInContentPage> {
  BingdingSignInProvide _provide;
  @override
  void initState() {
    super.initState();
    _provide ??= widget._provide;
    _loadQrcodeData();
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
      appBar: AppBar(
        elevation: 0.0,
        title: Text('绑定签到'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
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
                    '二维码一分钟内有效',
                    style: TextStyle(fontSize: ScreenAdapter.size(40)),
                  ),
                  SizedBox(
                    height: ScreenAdapter.height(60),
                  ),
                  InkWell(
                    onTap: (){
                      _provide.qrcodeData().doOnListen((){

                      }).doOnError((e,stack){

                      }).listen((item){
                       if (item.data['status'] == true) {
                         Fluttertoast.showToast(
                           msg: '二维码刷新成功',
                           gravity: ToastGravity.CENTER,
                         );
                         setState(() {
                           _provide.qrCode = item.data['qrCode'];
                         });
                       }
                      });
                    },
                    child: Container(
                      width: ScreenAdapter.width(377),
                      height: ScreenAdapter.height(377),
                      child: QrImage(
                        data: _provide.qrCode,
                        version: QrVersions.auto,
                      )
                    ),
                  )
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
          child: Container(
            width: ScreenAdapter.width(697),
            height: ScreenAdapter.height(80),
            color: Colors.black,
            child: Center(
              child: Text(
                '下一步',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenAdapter.size(40)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
