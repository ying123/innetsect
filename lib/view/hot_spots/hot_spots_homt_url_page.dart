import 'package:innetsect/base/base.dart';
import 'package:innetsect/view/hot_spots/hot_spots_homt_url_provide.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:webview_flutter/webview_flutter.dart';
class HotSpotsHomeUrlPage extends PageProvideNode{
  Map url ;
  HotSpotsHomtUrlProvide _provide = HotSpotsHomtUrlProvide();
  HotSpotsHomeUrlPage(){
    mProviders.provide(Provider<HotSpotsHomtUrlProvide>.value(_provide));
    _provide.url = url['url'];
  }
  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return HotSpotsHomeUrlContentPage(_provide);
  }
}
class HotSpotsHomeUrlContentPage extends StatefulWidget {
  HotSpotsHomtUrlProvide _provide;
  HotSpotsHomeUrlContentPage(this._provide);
  @override
  _HotSpotsHomeUrlContentPageState createState() => _HotSpotsHomeUrlContentPageState();
}

class _HotSpotsHomeUrlContentPageState extends State<HotSpotsHomeUrlContentPage> {
  HotSpotsHomtUrlProvide _provide;
  @override
  void initState() { 
    super.initState();
    _provide??= widget._provide;
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
