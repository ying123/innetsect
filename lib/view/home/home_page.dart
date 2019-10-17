import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/home/home_provide.dart';
import 'package:provide/provide.dart';

class HomePage extends PageProvideNode {
  final HomeProvide _provide = HomeProvide();
  HomePage() {
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
    ScreenAdapter.init(context);
    print('进入主页');
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '展会',
          style: TextStyle(
              fontSize: ScreenAdapter.size(40), fontWeight: FontWeight.bold, color: AppConfig.fontPrimaryColor),
        ),
        centerTitle: true,
        leading: Container(),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, ScreenAdapter.height(38), 0, 0),
              child: Text(
                '进入商城',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: ScreenAdapter.size(30),color: AppConfig.fontPrimaryColor),
              ),
            ),
            onTap: (){
             print('进入商城被点击');
             Navigator.pushNamed(context, '/mallPage');
            },
          ),
          SizedBox(
            width: ScreenAdapter.width(20),
          )
        ],
      ),
      body: Center(
        child: Text('进入主页'),
      ),
    );
  }
}
