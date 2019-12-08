import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
class AllocatingWebView extends StatelessWidget {
  // url地址
  final String url;
  // javascript模式，
  // 默认unrestricted没有限制
  // disabled 有限制
  final JavascriptMode javascriptMode;
  // 创建web视图后的回调
  final WebViewCreatedCallback onWebViewCreated;
  AllocatingWebView({this.url,
    this.javascriptMode=JavascriptMode.unrestricted,
    this.onWebViewCreated});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("调货",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900)),leading: true
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: this.javascriptMode,
        onWebViewCreated: this.onWebViewCreated,
      ),
    );
  }
}