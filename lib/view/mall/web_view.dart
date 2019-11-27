import 'package:flutter/material.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';

class WebView extends StatelessWidget {
  final String url;
  WebView({this.url}):assert(url!=null);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
        widget: Text(''),),
      body: WebViewWidget(url: this.url,)
    );
  }
}