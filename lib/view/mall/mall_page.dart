import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:provide/provide.dart';
import 'package:innetsect/view_model/mall/mall_provide.dart';
import 'package:innetsect/base/platform_menu_config.dart';
import 'package:innetsect/view/mall/commodity/commodity_page.dart';

///商城页面
class MallPage extends PageProvideNode{
 final MallProvode _provide = MallProvode();
  MallPage(){
    mProviders.provide(Provider<MallProvode>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
  
    return MallContentPage(_provide);
  }
}

class MallContentPage extends StatefulWidget {
  final MallProvode _provide;
  MallContentPage(this._provide);

  @override
  _MallContentPageState createState() => _MallContentPageState();
}

class _MallContentPageState extends State<MallContentPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  Provide<MallProvode>_initTabBarView(){
    return Provide<MallProvode>(
      builder: (BuildContext context, Widget child, MallProvode provide ){
        return IndexedStack(
          index: widget._provide.currentIndex,
          children: [
            CommodityPage()
          ],
        );
      },
    );
  }

  /// 底部导航
  Provide<MallProvode> _initBottomNavBar(){
    return Provide<MallProvode>(
      builder: (BuildContext context,Widget child,MallProvode mallProvode){
        return Theme(
          data: new ThemeData(
            canvasColor:  Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.grey))
          ),
          child: new BottomNavigationBar(
              elevation: 0.0,
              fixedColor: Color.fromRGBO(58, 130, 240, 1.0),
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
            title: Container(),
          )
      );
    });
    return list;
  }

  /// 底部点击导航
  void _onBottomTap(int index){
    widget._provide.currentIndex = index;
  }
}