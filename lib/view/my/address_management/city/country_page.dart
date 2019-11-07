import 'package:flutter/material.dart';
import 'package:innetsect/base/app_config.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/provinces_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class CountryPage extends PageProvideNode{

  final NewAddressProvide _provide = NewAddressProvide.instance;
  final AddressManagementProvide _addressManagementProvide = AddressManagementProvide.instance;

  CountryPage(){
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
    mProviders.provide(Provider<AddressManagementProvide>.value(_addressManagementProvide));
  }

  @override
  Widget buildContent(BuildContext context) {
    // TODO: implement buildContent
    return CountryContentPage(_provide,_addressManagementProvide);
  }
}

class CountryContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  final AddressManagementProvide _addressManagementProvide;
  CountryContentPage(this._provide,this._addressManagementProvide);

  @override
  _CountryContentPageState createState() => _CountryContentPageState();
}

class _CountryContentPageState extends State<CountryContentPage> {
  AddressManagementProvide _addressManagementProvide;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: CustomsWidget().customNav(context: context,
            widget: new Text("选择国家",style: TextStyle(fontSize: ScreenAdapter.size((30)),
                fontWeight: FontWeight.w900
            ),
            )
        ),
      body: Provide<NewAddressProvide>(
        builder: (BuildContext context,Widget widget,NewAddressProvide provide){
          return Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: provide.countryList.length,
                itemBuilder:(BuildContext context, int index){
                  return new InkWell(
                    onTap: (){
                      // 选中国家
                      provide.getProvices(provide.countryList[index].countryCode)
                          .doOnListen(() {}).doOnCancel(() {})
                          .listen((items) {
                            if(items.data!=null&&items.data.length>0){
                              // 跳转到省份界面
                              provide.addProvincesList(ProvincesModelList.fromJson(items.data).list);
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (BuildContext context){
                                  return ProvincesPage();
                                }
                              ));
                            }else{
                              if(_addressManagementProvide.addressModel!=null){
                                _addressManagementProvide.addressModel.province = "";
                                _addressManagementProvide.addressModel.city = "";
                                _addressManagementProvide.addressModel.county = "";
                                _addressManagementProvide.addressModel.areaCode = "";
                              }
                              Navigator.pop(context);
                            }
                            print('listen data->$items');
                          }, onError: (e) {});

                      provide.selectCountry(provide.countryList[index]);
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color:AppConfig.assistLineColor))
                      ),
                      padding: EdgeInsets.all(10),
                      child: new Text(provide.countryList[index].briefName),
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressManagementProvide = widget._addressManagementProvide;
  }
}
