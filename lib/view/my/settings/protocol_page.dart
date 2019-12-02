import 'package:flutter/material.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view/widget/web_view_widget.dart';

class ProtocolPage extends StatelessWidget {
  final String title;
  final bool leading;
  ProtocolPage({this.title,this.leading=true});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context, leading: leading,
          widget: new Text(title,style: TextStyle(fontSize: ScreenAdapter.size((30)),
          fontWeight: FontWeight.w900))),
      body: WebViewWidget(url: "https://gate.innersect.net/agreement/index.html#/",),
    );
  }
}