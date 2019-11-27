
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
  String html;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomsWidget().customNav(context: context, widget: new Container()),
      body: ListView(
        children: <Widget>[
          html!=null?Container(
            child: Html(
              data: html,
            ),
          ):Container()
        ],
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  _loadData() async{
    await widget._provide.getDetail().then((item){
     setState(() {
       html = item.data;
     });
    });
  }
}
