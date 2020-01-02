import 'package:innetsect/base/base.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/draw/country_code_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class CountryCodePage extends PageProvideNode{
  final CountryCodeProvide _provide = CountryCodeProvide();
  CountryCodePage(){
    mProviders.provide(Provider<CountryCodeProvide>.value(_provide));
  }
  @override
  Widget buildContent(BuildContext context) {
    
    return CountryCodeContentPage(_provide);
  }
}
class CountryCodeContentPage extends StatefulWidget {
  final CountryCodeProvide provide;
  CountryCodeContentPage(this.provide);
  @override
  _CountryCodeContentPageState createState() => _CountryCodeContentPageState();
}

class _CountryCodeContentPageState extends State<CountryCodeContentPage> {
  CountryCodeProvide provide;
  @override
  void initState() { 
    super.initState();
    provide??= widget.provide;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择国家或地区'),
        centerTitle: true,
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
    );
  }
}