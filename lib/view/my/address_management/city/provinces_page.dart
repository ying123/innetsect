import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/city_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class ProvincesPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;

  ProvincesPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return ProvincesContentPage(_provide);
  }
}

class ProvincesContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  ProvincesContentPage(this._provide);

  @override
  _ProvincesContentPageState createState() => _ProvincesContentPageState();
}

class _ProvincesContentPageState extends State<ProvincesContentPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomsWidget().customNav(context: context,
          widget: new Text("选择省份",style: TextStyle(fontSize: ScreenAdapter.size((30)),
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
                itemCount: provide.provincesList.length,
                itemBuilder:(BuildContext context, int index){
                  return new InkWell(
                    onTap: (){
                      // 选中省份
                      provide.selectProvinces(provide.provincesList[index]);
                      provide.getCitys(countryModel.countryCode,provide.provincesList[index].regionCode)
                          .doOnListen(() {}).doOnCancel(() {})
                          .listen((items) {
                        if(items.data!=null&&items.data.length>0){
                          // 跳转到市界面
                          provide.addCityList(ProvincesModelList.fromJson(items.data).list);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context){
                                return CityPage();
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
                      child: new Text(provide.provincesList[index].regionName),
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
