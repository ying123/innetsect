import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/hot_spots/hot_spots_homt_url_provide.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HotSpotsHomeUrlPage extends PageProvideNode{
  Map url ;
  HotSpotsHomtUrlProvide _provide = HotSpotsHomtUrlProvide();
  HotSpotsHomeUrlPage({this.url}){
    mProviders.provide(Provider<HotSpotsHomtUrlProvide>.value(_provide));
    _provide.url = url['url'];
    print('==========>url${_provide.url}');
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              size: ScreenAdapter.size(60),
            ),
          ),
      ),
      body: WebView(
        initialUrl: _provide.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
