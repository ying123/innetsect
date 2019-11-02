import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/new_address/new_address_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

///县
class CountyPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;

  CountyPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return  CountyContentPage(_provide);
  }
}

class CountyContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  CountyContentPage(this._provide);

  @override
  _CountyContentPageState createState() => _CountyContentPageState();
}

class _CountyContentPageState extends State<CountyContentPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("选择区县",style: TextStyle(fontSize: ScreenAdapter.size((30)),
              fontWeight: FontWeight.w900
          ),
          )
      ),
      body: Provide<NewAddressProvide>(
        builder: (BuildContext context,Widget widget,NewAddressProvide provide){
          CountryModel countryModel = provide.countryModel;
          return Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: provide.countyList.length,
                itemBuilder:(BuildContext context, int index){
                  return new InkWell(
                    onTap: (){
                      // 选中区县
                      provide.selectCounty(provide.countyList[index]);
                      Navigator.pop(context);
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color:AppConfig.assistLineColor))
                      ),
                      padding: EdgeInsets.all(10),
                      child: new Text(provide.countyList[index].regionName),
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
