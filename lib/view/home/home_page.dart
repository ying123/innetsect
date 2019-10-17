
import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:provide/provide.dart';

class HomePage extends PageProvideNode{
  final HomeProvide _provide = HomeProvide();
  HomePage(){
    mProviders.provide(Provider<HomeProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    
    return HomeContentPage(_provide);
  }
}

class HomeContentPage extends StatefulWidget {
  final HomeProvide _provide;
  HomeContentPage(this._provide);
  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  HomeProvide _provide;

  @override
  void initState() {
    _provide ??= widget._provide;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('进入主页');
    return Scaffold(
      appBar: AppBar(
        title: Text('展会',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenAdapter.size(45)
        ),),
        centerTitle: true,
        leading: Container( ),
        actions: <Widget>[
          Center(
            child: Text('进入商城', style: TextStyle(
              fontSize: ScreenAdapter.size(35),
            ),),
          ),
          SizedBox(
            width: ScreenAdapter.width(26),
          )
        ],
        elevation: 0.0,
      ),
    bottomNavigationBar: getBottomNavagetionbar(),
    );
  }
  Widget getBottomNavagetionbar(){
    //红点联系人
    
  }
}