/// web_view
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatelessWidget {
  // url地址
  final String url;
  // javascript模式，
  // 默认unrestricted没有限制
  // disabled 有限制
  final JavascriptMode javascriptMode;
  // 创建web视图后的回调
  final WebViewCreatedCallback onWebViewCreated;

  WebViewWidget({
    this.url,
    this.javascriptMode=JavascriptMode.unrestricted,
    this.onWebViewCreated
  });

  @override
  Widget build(BuildContext context) {
    return new WebView(
      initialUrl: this.url,
      javascriptMode: this.javascriptMode,
      onWebViewCreated: this.onWebViewCreated,
    );
  }
}
