import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/county_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class CityPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;

  CityPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CityContentPage(_provide);
  }
}

class CityContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  CityContentPage(this._provide);

  @override
  _CityContentPageState createState() => _CityContentPageState();
}

class _CityContentPageState extends State<CityContentPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("选择市",style: TextStyle(fontSize: ScreenAdapter.size((30)),
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
                itemCount: provide.cityList.length,
                itemBuilder:(BuildContext context, int index){
                  return new InkWell(
                    onTap: (){
                      // 选中市
                      provide.selectCity(provide.cityList[index]);
                      provide.getCitys(countryModel.countryCode,provide.cityList[index].regionCode)
                          .doOnListen(() {}).doOnCancel(() {})
                          .listen((items) {
                        if(items.data!=null&&items.data.length>0){
                          provide.addCountyList(ProvincesModelList.fromJson(items.data).list);
                          // 跳转到区县界面
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return CountyPage();
                              }
                          ));
                        }else{
                          Navigator.pop(context);
                        }
                        print('listen data->$items');
                      }, onError: (e) {});
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color:AppConfig.assistLineColor))
                      ),
                      padding: EdgeInsets.all(10),
                      child: new Text(provide.cityList[index].regionName),
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
