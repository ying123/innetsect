import 'dart:async';

import 'package:innetsect/base/base.dart';
import 'package:innetsect/entrance_page.dart';
import 'package:innetsect/main_provide.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class App extends PageProvideNode {
  final MainProvide _provide = MainProvide.instance;
  App() {
    mProviders.provide(Provider<MainProvide>.value(_provide));
    //可以添加多个数据
    // mProviders.provideAll({MainProvide: Provider.value(MainProvide()), double : Provider.value(30.0)});
  }

  @override
  Widget buildContent(BuildContext context) {
    return _AppContentPage(_provide);
  }
}

class _AppContentPage extends StatefulWidget {
  final MainProvide _provide;
  _AppContentPage(this._provide);
  @override
  __AppContentPageState createState() => __AppContentPageState();
}

class __AppContentPageState extends State<_AppContentPage> with TickerProviderStateMixin{
  MainProvide _provide;
  // 可见图片透明
  double opacityLevel = 1.0;
  // 扩散动画
//  AnimationController _animationController;
  @override
  void initState() {
    _provide ??= widget._provide;
    super.initState();
//    _provide.img = ExactAssetImage('assets/images/mall/welcome.png');
    _provide.countdown = _provide.WELCOME_TIMER_OUT_IN_SECS;

    //退出计时器
    _provide.timerDone =
        Timer(Duration(seconds: _provide.WELCOME_TIMER_OUT_IN_SECS), () {
      onDone();
    });

    ///计时器开始倒计时
    _provide.startTimerCountdown();
  }

  ///完成
  void onDone() {
    setState(() {
      opacityLevel = 0.0;
    });
    _provide.isDone = true;
//    Navigator.of(context).pushNamed('/appNavigationBarPage');
    Navigator.push(context, MaterialPageRoute(
      builder: (context){
        return new EntrancePage();
      }
    ));
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
        return new Container(
            width: double.infinity,
            height: double.infinity,
            child:provide.isDone
                ? Container()
                : Image.asset("assets/images/main/open_app.jpg",fit: BoxFit.fill,)
        );
//                  VideoWidgetPage(
//                    url: "assets/res/welcome.mp4",
//                    previewImgUrl: 'assets/res/welcome.jpg',
//                    positionTag: 0,
//                  ));
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
}
