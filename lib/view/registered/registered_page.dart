import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view_model/registered/registered_provide.dart';
import 'package:provide/provide.dart';

class RegisteredPage extends PageProvideNode {
  final RegisteredProvide _provide = RegisteredProvide();
  RegisteredPage() {
    mProviders.provide(Provider<RegisteredProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    return RegidterContentPage();
  }
}

class RegidterContentPage extends StatefulWidget {
  @override
  _RegidterContentPageState createState() => _RegidterContentPageState();
}

class _RegidterContentPageState extends State<RegidterContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('注册'),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/xiangxia.png',
              fit: BoxFit.none,
              width: ScreenAdapter.width(38),
              height: ScreenAdapter.width(38),
            )),
      ),
    );
  }
}
