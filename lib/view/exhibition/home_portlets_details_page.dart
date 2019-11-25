import 'package:innetsect/base/base.dart';
import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/exhibition/home_portlets_details_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
///首页列表详情
class HomePortletsDetailsPage  extends PageProvideNode{
  final HomeProtletsDetailsProvide _provide = HomeProtletsDetailsProvide();
  Map contentID;
  HomePortletsDetailsPage({this.contentID}){
    mProviders.provide(Provider<HomeProtletsDetailsProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
   
    return HomePortletsDetailsContentPage(_provide,contentID);
  }
}
class HomePortletsDetailsContentPage extends StatefulWidget {
  final HomeProtletsDetailsProvide _provide;
  Map contentID;
  HomePortletsDetailsContentPage(this._provide,this.contentID);
  @override
  _HomePortletsDetailsContentPageState createState() => _HomePortletsDetailsContentPageState();
}

class _HomePortletsDetailsContentPageState extends State<HomePortletsDetailsContentPage> {
  HomeProtletsDetailsProvide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??=widget._provide;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.chevron_left,size: ScreenAdapter.size(60),),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebviewScaffold(
           url: 'https://test.innersect.net/api/society/contents/${widget.contentID['contentID']}/detailPage',
           withZoom: true,
           withLocalStorage: true,
           hidden: true,
          )
        ],
      ),
    );
  }
}