import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class CountryPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;

  CountryPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CountryContentPage(_provide);
  }
}

class CountryContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  CountryContentPage(this._provide);

  @override
  _CountryContentPageState createState() => _CountryContentPageState();
}

class _CountryContentPageState extends State<CountryContentPage> {
  @override
  Widget build(BuildContext context) {
    return Provide<NewAddressProvide>(
      builder: (BuildContext context,Widget widget,NewAddressProvide provide){
        return ListView.builder(
          itemCount: provide.cityList.length,
          itemBuilder:(BuildContext context, int index){
            return new Container(
              padding: EdgeInsets.all(5),
              child: new Text(provide.cityList[index].briefName),
            );
          });
      },
    );
  }
}
