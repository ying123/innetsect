import 'package:flutter/material.dart';
import 'package:innetsect/app_navigation_bar_provide.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/view/activity/activity_page.dart';
import 'package:innetsect/view/brand/brand_page.dart';
import 'package:innetsect/view/home/home_page.dart';
import 'package:innetsect/view/my/my_page.dart';
import 'package:innetsect/view/widget/commodity_cart_page.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';

import 'package:rammus/rammus.dart' as rammus;

class AppNavigationBar extends PageProvideNode {
  final AppNavigationBarProvide _provide = AppNavigationBarProvide.instance;
  final LoginProvide _loginProvide = LoginProvide();
  AppNavigationBar() {
    mProviders.provide(Provider<AppNavigationBarProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return AppNavigationContentBar();
  }
}

class AppNavigationContentBar extends StatefulWidget {
  @override
  _AppNavigationContentBarState createState() =>
      _AppNavigationContentBarState();
}

class _AppNavigationContentBarState extends State<AppNavigationContentBar>
    with TickerProviderStateMixin<AppNavigationContentBar> {
  AppNavigationBarProvide _provide;
  LoginProvide _loginProvide;
  TabController controller;

  //首页
  HomePage _home = HomePage();
  //品牌
  BrandPage _brandPage = BrandPage();
  //活动
  ActivityPage _activityPage = ActivityPage();
  //购物车
  CommodityCartPage _shoppingPage = CommodityCartPage();
  //我的
  MyPage _myPage = MyPage(page:'exhibition');

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _provide = AppNavigationBarProvide.instance;
    _loginProvide = LoginProvide.instance;
    controller = new TabController(length: 5, vsync: this)..addListener((){
      if(controller.index.toDouble() == controller.animation.value){
        if(controller.index==4){
          // 获取用户信息，如果请求错误弹出登录页面
          /// 获取用户信息
          Future.delayed(Duration.zero,(){
            _loginProvide.getUserInfo(context:context).doOnListen((){}).doOnCancel((){}).listen((userItem){
              if(userItem!=null&&userItem.data!=null){
                // 注册阿里云账号绑定
                UserInfoModel model = UserInfoModel.fromJson(userItem.data);
                rammus.bindAccount(model.acctID.toString());
                _loginProvide.setUserInfoModel(model);
              }
            },onError: (e){
            });
          });
        }
      }
    });
    Future.delayed(Duration.zero,(){
      Map<dynamic,dynamic> mapData = ModalRoute.of(context).settings.arguments;
      _provide.currentIndex = int.parse(mapData['index'].toString());
    });
//    _animationController = new AnimationController(
//      duration: const Duration(milliseconds: 500),
//      vsync: this,
//    );
//    _animation =
//        new CurvedAnimation(parent: _animationController, curve: Curves.linear);
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    print('app释放');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        alignment: AlignmentDirectional.bottomEnd, //底部
        overflow: Overflow.visible,
        children: <Widget>[
          _initTabBarView(),
        ],
      ),
      bottomNavigationBar: _initBottomNavigationBar(),
    );
  }

  Provide<AppNavigationBarProvide> _initTabBarView() {
    return Provide<AppNavigationBarProvide>(
      builder: (BuildContext context, Widget child,
          AppNavigationBarProvide provide) {
        return IndexedStack(
          index: _provide.currentIndex,
          children: <Widget>[
            _activityPage,
            _brandPage,
            _home,
            _shoppingPage,
            _myPage,
          ],
        );
      },
    );
  }

  Provide<AppNavigationBarProvide> _initBottomNavigationBar() {
    return Provide<AppNavigationBarProvide>(
      builder: (BuildContext context, Widget child,
          AppNavigationBarProvide provide) {
        return Theme(
          data: new ThemeData(
              canvasColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.grey))),
          child: BottomNavigationBar(
            elevation: 0.0,
            fixedColor: Color.fromRGBO(58, 130, 240, 1.0),
            currentIndex: _provide.currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(
                icon: new Image.asset(
                  'assets/images/活动.png',
                  width: 30.0,
                  height: 30.0,
                ),
                activeIcon: Image.asset(
                  'assets/images/活动选中.png',
                  width: 30.0,
                  height: 30.0,
                ),
                title: Container(
                  child: Text(
                    '活动',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Image.asset(
                  'assets/images/品牌.png',
                  width: 30.0,
                  height: 30.0,
                ),
                activeIcon: Image.asset(
                  'assets/images/品牌选中.png',
                  width: 30.0,
                  height: 30.0,
                ),
                title: Container(
                  child: Text(
                    '品牌',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Image.asset(
                  'assets/images/首页.png',
                  width: 30.0,
                  height: 30.0,
                ),
                activeIcon: Image.asset(
                  'assets/images/首页-选中.png',
                  width: 30.0,
                  height: 30.0,
                ),
                title: Container(
                  child: Text(
                    '首页',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Image.asset(
                  'assets/images/购物车.png',
                  width: 30.0,
                  height: 30.0,
                ),
                activeIcon: Image.asset(
                  'assets/images/购物车选中.png',
                  width: 30.0,
                  height: 30.0,
                ),
                title: Container(
                  child: Text(
                    '购物车',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              new BottomNavigationBarItem(
                icon: new Image.asset(
                  'assets/images/我的.png',
                  width: 30.0,
                  height: 30.0,
                ),
                activeIcon: Image.asset(
                  'assets/images/我的选中.png',
                  width: 30.0,
                  height: 30.0,
                ),
                title: Container(
                  child: Text(
                    '我的',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onTap(int index) {
    _provide.currentIndex = index;
//    controller.animateTo(index,
//        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }
}
