import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:innetsect/app_navigation_bar.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/base/const_config.dart';
import 'package:innetsect/data/main/activity_model.dart';
import 'package:innetsect/data/main/splash_model.dart';
import 'package:innetsect/entrance_page.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/mall/web_view.dart';
import 'package:innetsect/view/widget/video_widget_page.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:rammus/rammus.dart' as rammus;

class App extends PageProvideNode {
  final MainProvide _provide = MainProvide.instance;
  final AppNavigationBarProvide _appNavigationBarProvide = AppNavigationBarProvide.instance;
  App() {
    mProviders.provide(Provider<MainProvide>.value(_provide));
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_appNavigationBarProvide));
    //可以添加多个数据
    // mProviders.provideAll({MainProvide: Provider.value(MainProvide()), double : Provider.value(30.0)});
  }

  @override
  Widget buildContent(BuildContext context) {
    return _AppContentPage(_provide,_appNavigationBarProvide);
  }
}

class _AppContentPage extends StatefulWidget {
  final MainProvide _provide;
  final AppNavigationBarProvide _appNavigationBarProvide;
  _AppContentPage(this._provide,this._appNavigationBarProvide);
  @override
  __AppContentPageState createState() => __AppContentPageState();
}

class __AppContentPageState extends State<_AppContentPage> with TickerProviderStateMixin{
  MainProvide _provide;
  // 可见图片透明
  double opacityLevel = 1.0;
  AppNavigationBarProvide _appNavigationBarProvide;
  // 扩散动画
//  AnimationController _animationController;
  @override
  void initState() {
    _provide ??= widget._provide;
    _appNavigationBarProvide ??= widget._appNavigationBarProvide;
    super.initState();

    _loadAndroidDevice().then((item){
      _deviceID().then((val){
        UserTools().setDeviceInfo(deviceInfo: item,deviceID:val);
      });
    });
//    _provide.img = ExactAssetImage('assets/images/mall/welcome.png');
    _loadData();
  }

  Future<String> _deviceID() async{
    String device = await rammus.deviceId;
    return device;
  }

  ///完成
  void onDone() {
//    Navigator.of(context).pushNamed('/appNavigationBarPage');
    if(_provide.splashModel.attended){
      _appNavigationBarProvide.currentIndex = 2;
      Navigator.of(context).pushNamedAndRemoveUntil('/appNavigationBarPage',
              (Route route)=>false);
    }else if(_provide.splashModel.exhibitionID!=null&&
      !_provide.splashModel.attended){
      Navigator.of(context).pushNamedAndRemoveUntil('/entrancePage',
          (Route route)=>false);
    }else if(_provide.splashModel.exhibitionID==null){
      Navigator.of(context).pushNamedAndRemoveUntil('/mallPage',
              (Route route)=>false);
    }
    _provide.isDone = true;
    setState(() {
      opacityLevel = 0.0;
    });
  }

  Future<AndroidDeviceInfo> _loadAndroidDevice() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return await deviceInfo.androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    print('进入欢迎界面');
    ScreenAdapter.init(context);

    return Material(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          welcomeAnimation(),
          enterAPP(),
        ],
      ),
    );
  }

  Provide<MainProvide> welcomeAnimation() {
    return Provide<MainProvide>(
      builder: (BuildContext context, Widget child, MainProvide provide) {
        if(provide.openImage.indexOf(".mp4")>-1){
          return InkWell(
            onTap: (){
              if(provide.splashModel.splashes!=null
                  && provide.splashModel.splashes[0].redirectType!=null
                  && provide.splashModel.splashes[0].redirectTo!=null){
                if(provide.splashModel.splashes[0].redirectType ==
                ConstConfig.URL){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context){
                      return WebView(
                        url: _provide.splashModel.splashes[0].redirectTo,
                        pages: "main",
                        attended: _provide.splashModel.attended,
                        appProvide: _appNavigationBarProvide
                      );
                    }
                  ));
                }
              }
            },
            child: new Container(
                width: double.infinity,
                height: double.infinity,
                child:provide.isDone
                    ? Container()
                    : VideoWidgetPage(
                  url: provide.openImage,
                  previewImgUrl: 'assets/res/welcome.jpg',
                  positionTag: 0,
                )
            )
          );
        }else{
          return InkWell(
            onTap: (){
              if(provide.splashModel.splashes!=null
                  && provide.splashModel.splashes[0].redirectType!=null
                  && provide.splashModel.splashes[0].redirectTo!=null){
                if(provide.splashModel.splashes[0].redirectType ==
                    ConstConfig.URL){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context){
                        return WebView(
                          url: _provide.splashModel.splashes[0].redirectTo,
                          pages: "main",
                          attended: _provide.splashModel.attended,
                          appProvide: _appNavigationBarProvide
                        );
                      }
                  ));
                }
              }
            },
            child: new Container(
                width: double.infinity,
                height: double.infinity,
                child:provide.isDone
                    ? Container()
                    : Image.network(provide.openImage,fit: BoxFit.fill,)
            )
          );
        }
      },
    );
  }

  Provide<MainProvide> enterAPP() {
    return Provide<MainProvide>(
      builder: (BuildContext context, Widget child, MainProvide provide) {
        return Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 60,right: 20),
            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
            child: GestureDetector(
              onTap: () {
                onDone();
              },
              child: Text(
//                '${IntlUtil.getString(context, Ids.x_jump_welcome)}(${provide.countdown})',
              '跳过 ${provide.countdown}',
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: Color(0x66000000),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(width: 0.33, color: Colors.grey)),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (null != _provide.timerDone) {
      _provide.timerDone.cancel();
    }
    if (null != _provide.timerCountdown) {
      _provide.timerCountdown.cancel();
    }
    super.dispose();
  }

  _loadData(){
    _provide.getSplash()
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
        SplashModel model = SplashModel.fromJson(item.data);
        _provide.splashModel = model;
        // 活动请求
        _loadExhibition(model.exhibitionID);
        if(model.splashes!=null&&model.splashes.length>0){

          _provide.countdown = model.splashes[0].playSeconds;
          _provide.openImage = model.splashes[0].splashFile;

          //退出计时器
          _provide.timerDone =
              Timer(Duration(seconds: model.splashes[0].playSeconds), () {
                onDone();
              });

          ///计时器开始倒计时
          _provide.startTimerCountdown();
        }else{
          if(model.attended){
            Future.delayed(Duration(seconds: 1),(){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context){
                    _appNavigationBarProvide.currentIndex = 2;
                    return AppNavigationBar();
                  }
              ), ModalRoute.withName('/appNavigationBarPage'));
            });
          }else{
            Future.delayed(Duration(seconds: 1),(){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context){
                    return EntrancePage();
                  }
              ));
            });
          }
        }
      }

    }, onError: (e) {});
  }

  _loadExhibition(int exhibitionID){
    _provide.getExhibition(exhibitionID)
        .doOnListen(() {
      print('doOnListen');
    })
        .doOnCancel(() {})
        .listen((item) {
      ///加载数据
      print('listen data->$item');
      if(item!=null&&item.data!=null){
       _appNavigationBarProvide.activityList = ActivityModelList.fromJson(item.data['sessions']).list;
      }
    }, onError: (e) {});
  }
}
