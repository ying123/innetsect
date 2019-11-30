import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/user_info_model.dart';
import 'package:innetsect/view/mall/home/mall_home_page.dart';
import 'package:innetsect/view/mall/information/information_page.dart';
import 'package:innetsect/view/mall/series/series_main_page.dart';
import 'package:innetsect/view/my/my_page.dart';
import 'package:innetsect/view_model/login/login_provide.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/mall_provide.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/view/mall/commodity/commodity_page.dart';

import 'package:rammus/rammus.dart' as rammus;

///商城页面
class MallPage extends PageProvideNode{
  final MallProvide _provide = MallProvide.instance;
  final LoginProvide _loginProvide = LoginProvide();
  MallPage(){
    mProviders.provide(Provider<MallProvide>.value(_provide));
    mProviders.provide(Provider<LoginProvide>.value(_loginProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
  
    return MallContentPage(_provide);
  }
}

class MallContentPage extends StatefulWidget {
  final MallProvide _provide;
  MallContentPage(this._provide);

  @override
  _MallContentPageState createState() => _MallContentPageState();
}

class _MallContentPageState extends State<MallContentPage> {
  LoginProvide _loginProvide;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvide=LoginProvide.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          _initTabBarView()
        ],
      ),
      bottomNavigationBar: _initBottomNavBar(),
    );
  }

  /// 切换页面
  Provide<MallProvide>_initTabBarView(){
    return Provide<MallProvide>(
      builder: (BuildContext context, Widget child, MallProvide provide ){
        return IndexedStack(
          index: widget._provide.currentIndex,
          children: [
            InformationPage(),
            SeriesMainPage(),
            MallHomePage(),
            CommodityPage(),
            MyPage(page:'mall')
          ],
        );
      },
    );
  }

  /// 底部导航
  Provide<MallProvide> _initBottomNavBar(){
    return Provide<MallProvide>(
      // ignore: non_constant_identifier_names
      builder: (BuildContext context,Widget child,MallProvide MallProvide){
        return Theme(
          data: new ThemeData(
            canvasColor:  Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
          ),
          child: new BottomNavigationBar(
              elevation: 0.0,
              fixedColor: AppConfig.fontBackColor,
              currentIndex: widget._provide.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: _onBottomTap,
              items: _bottomNavList())
        );
      },
    );
  }

  /// 底部导航循环解析
  List<BottomNavigationBarItem> _bottomNavList(){
    List<BottomNavigationBarItem> list = new List();
    mallNavBarList.forEach((PlatFormMenu menu){
      list..add(
          new BottomNavigationBarItem(
            icon:  new Image.asset(menu.icon,
              width: 30.0, height: 30.0,),
            activeIcon: Image.asset(menu.selIcon,
              width: 30.0, height: 30.0,),
            title: Text(menu.title),
          )
      );
    });
    return list;
  }

  /// 底部点击导航
  void _onBottomTap(int index){
    widget._provide.currentIndex = index;
      if(index==4){
        this._loginProvide.getUserInfo(context:context).doOnListen((){}).doOnCancel((){}).listen((userItem){
          if(userItem!=null&&userItem.data!=null){
            UserInfoModel model = UserInfoModel.fromJson(userItem.data);
            rammus.bindAccount(model.acctID.toString());
            this._loginProvide.setUserInfoModel(model);
          }
        },onError: (e){
        });
      }
  }


}