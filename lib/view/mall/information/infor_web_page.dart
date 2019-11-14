import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/mall/information/information_provide.dart';
import 'package:provide/provide.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InforWebPage extends PageProvideNode{
  final InformationProvide _provide = InformationProvide.instance;

  InforWebPage(){
    mProviders.provide(Provider<InformationProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return InforWebContentPage(_provide);
  }

}

class InforWebContentPage extends StatefulWidget {
  final InformationProvide _provide;
  InforWebContentPage(this._provide);
  @override
  _InforWebContentPageState createState() => _InforWebContentPageState();
}

class _InforWebContentPageState extends State<InforWebContentPage> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Container()),
      body: Provide<InformationProvide>(
        builder: (BuildContext context,Widget widget,InformationProvide provide){
          return WebView(
            initialUrl: '',
            onWebViewCreated: (WebViewController controller){
              _controller = controller;
              _loadHtml(provide);
            },
          );
        },
      ),
    );
  }

  _loadHtml(InformationProvide provide) async {
    _controller.loadUrl( Uri.dataFromString(
        provide.html,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());

  }
}
