import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/data/series/approved_country_model.dart';
import 'package:innetsect/utils/screen_adapter.dart';
import 'package:innetsect/view/my/address_management/city/country_page.dart';
import 'package:innetsect/view/my/address_management/city/provinces_page.dart';
import 'package:innetsect/view/widget/customs_widget.dart';
import 'package:innetsect/view_model/my/address_management/address_management_provide.dart';
import 'package:innetsect/view_model/my/address_management/new_address/new_address_provide.dart';
import 'package:provide/provide.dart';

class NewAddressPage extends PageProvideNode {
  final NewAddressProvide _provide = NewAddressProvide();
  final AddressManagementProvide _addressManagementProvide = AddressManagementProvide.instance;
  NewAddressPage() {
    mProviders.provide(Provider<NewAddressProvide>.value(_provide));
    mProviders.provide(Provider<AddressManagementProvide>.value(_addressManagementProvide));
  }
  @override
  Widget buildContent(BuildContext context) {
    return NewAddressContentPage(_provide,_addressManagementProvide);
  }
}

class NewAddressContentPage extends StatefulWidget {
  final NewAddressProvide _provide;
  final AddressManagementProvide _addressManagementProvide;
  NewAddressContentPage(this._provide,this._addressManagementProvide);
  @override
  _NewAddressContentPageState createState() => _NewAddressContentPageState();
}

class _NewAddressContentPageState extends State<NewAddressContentPage> {

  bool isSelected = false;
  NewAddressProvide _provide;
  AddressManagementProvide _addressManagementProvide;
  String province ;
  String city ;
  String areaName ;
  String areaCode ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget._addressManagementProvide.addressModel!=null?'修改收货地址':'新建收货地址'),
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
      body: ListView(
        physics: BouncingScrollPhysics(),
       // itemExtent: ScreenAdapter.height(720),
        children: <Widget>[
          _setupNewGoodsAddress(),
        ],
      ),
      bottomNavigationBar: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(150),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12))),
        child: _setupBottomBtn(),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addressManagementProvide ??= widget._addressManagementProvide;
    _provide ??= widget._provide;
    _provide.lastUsed = isSelected;
    // 获取国家
    _getCountries();
    // 初始化参数
    if(widget._addressManagementProvide.addressModel==null){
      _provide.initCountryModel();
    }
//    _getCountries();

  }


  Widget _setupNewGoodsAddress() {
      return Column(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(700),
            height: ScreenAdapter.height(100),
            // color: Colors.yellow,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                    top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                    ),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text('收货人姓名',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                      ),
                      Container(
                        width: ScreenAdapter.width(500),
                        margin: EdgeInsets.only(left: 20),
                        child: Provide<NewAddressProvide>(
                          builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                            return TextField(
                              controller: TextEditingController.fromValue(TextEditingValue(
                                  text: provide.name!=null?provide.name:'',
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: provide.name!=null?provide.name.toString().length:''.length
                                  ))
                              )),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.name:"请输入收货人姓名"
                              ),
                              onChanged: (text){
                                provide.name = text;
                              },
                            );
                          })
                      )
                    ],
                  )
          ),
          Container(
            width: ScreenAdapter.width(700),
            height: ScreenAdapter.height(100),
            // color: Colors.yellow,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                    top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                    ),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text('手机号码',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                      ),
                      Container(
                        width: ScreenAdapter.width(500),
                        margin: EdgeInsets.only(left: 20),
                        child: Provide<NewAddressProvide>(
                          builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                            return TextField(
                              controller: TextEditingController.fromValue(TextEditingValue(
                                  text: provide.tel!=null?provide.tel:'',
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: provide.tel!=null?provide.tel.toString().length:''.length
                                  ))
                              )),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.tel:"请输入收货人手机号"
                              ),
                              onChanged: (text){
                                provide.tel=text;
                              },
                            );
                          })
                      )
                    ],
                  )
          ),
          InkWell(
            onTap: () {
              //弹出国家
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context){
                  return CountryPage();
                }
              ));
            },
            child: Container(
                width: ScreenAdapter.width(700),
                height: ScreenAdapter.height(100),
                // color: Colors.yellow,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                        top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                ),
                child: Row(
                  children: <Widget>[
                    Center(
                      child: Text('国家地区',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child:Provide<NewAddressProvide>(
                        builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                          return Text(provide.countryModel!=null?
                          "+ ${provide.countryModel.telPrefix} | ${provide.countryModel.briefName}":""
                          );
                        })
                    )
                  ],
                )
            ),
          ),
          Container(
            width: ScreenAdapter.width(700),
            height: ScreenAdapter.height(100),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                    top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                    ),
                  child:InkWell(
                      onTap: (){
                        if(_provide.countryModel.countryCode=='HK'||_provide.countryModel.countryCode=='TW'
                            ||_provide.countryModel.countryCode=='MO'||_provide.countryModel.countryCode=='CN'){
                          // 选中国家
                          _provide.getProvices(_provide.countryModel.countryCode)
                              .doOnListen(() {}).doOnCancel(() {})
                              .listen((items) {
                            if(items.data!=null&&items.data.length>0){
                              // 跳转到省份界面
                              _provide.addProvincesList(ProvincesModelList.fromJson(items.data).list);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return ProvincesPage();
                                  }
                              ));
                            }
                            print('listen data->$items');
                          }, onError: (e) {});
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Center(
                            child: Text('所在地区',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                          ),
                          Provide<NewAddressProvide>(
                              builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                                Widget widget = new Container();
                                if(provide.provincesModel!=null||provide.cityModel!=null||provide.countyModel!=null){
                                  if(provide.provincesModel!=null&&provide.cityModel!=null
                                      &&provide.countyModel!=null){
                                    widget= Padding(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Text("${provide.provincesModel.regionName} "
                                          "${provide.cityModel.regionName} "
                                          "${provide.countyModel.regionName}"),
                                    );
                                  }
                                }
                                return widget;
                              })
                        ],
                      ),
                    )
          ),
          Container(
            width: ScreenAdapter.width(700),
            height: ScreenAdapter.height(100),
            // color: Colors.yellow,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                    top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                    ),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text('详细地址',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                      ),
                      Container(
                        width: ScreenAdapter.width(500),
                        margin: EdgeInsets.only(left: 20),
                        child: Provide<NewAddressProvide>(
                            builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                              return TextField(
                                controller: TextEditingController.fromValue(TextEditingValue(
                                    text: provide.addressDetail!=null?provide.addressDetail:'',
                                    selection: TextSelection.fromPosition(TextPosition(
                                        affinity: TextAffinity.downstream,
                                        offset: provide.addressDetail!=null?provide.addressDetail.toString().length:''.length
                                    ))
                                )),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: widget._addressManagementProvide.addressModel!=null?widget._addressManagementProvide.addressModel.addressDetail:"请输入详细地址"
                                ),
                                onChanged: (text){
                                  provide.addressDetail=text;
                                },
                              );
                            })
                      )
                    ],
                  )
          ),
          //
          Container(
              width: ScreenAdapter.width(700),
              height: ScreenAdapter.height(100),
              // color: Colors.yellow,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                      top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
              ),
              child: Row(
                children: <Widget>[
                  Center(
                    child: Text('邮政编码',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                  ),
                  Container(
                      width: ScreenAdapter.width(500),
                      margin: EdgeInsets.only(left: 20),
                      child: Provide<NewAddressProvide>(
                          builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                            return TextField(
                              controller: TextEditingController.fromValue(TextEditingValue(
                                  text: provide.postalCode!=null?provide.postalCode:'',
                                  selection: TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: provide.postalCode.toString().length
                                  ))
                              )),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: widget._addressManagementProvide.addressModel!=null?
                                  widget._addressManagementProvide.addressModel.postalCode:"请输入邮政编码"
                              ),
                              onChanged: (text){
                                provide.postalCode=text;
                              },
                            );
                          })
                  )
                ],
              )
          ),
          Container(
            width: ScreenAdapter.width(700),
            height: ScreenAdapter.height(100),
            // color: Colors.yellow,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),),
                    top: BorderSide(color: Color.fromRGBO(234, 234, 234, 1.0),))
                    ),
                  child: Row(
                    children: <Widget>[
                      Provide<NewAddressProvide>(
                      builder: (BuildContext context, Widget child, NewAddressProvide provide) {
                        return CustomsWidget().customRoundedWidget(isSelected: isSelected,iconSize: 20,
                            onSelectedCallback: (){
                              setState(() {
                                isSelected = !isSelected;
                              });
                              provide.lastUsed = isSelected;
                            });
                      }) ,
                      Padding(
                        padding: EdgeInsets.only(left:10),
                        child: Text('设为默认',style: TextStyle(fontSize: ScreenAdapter.size(30)),),
                      )
                    ],
                  )
          ),
        ],
      );
    }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    /// 清空选中国家城市
    _provide.clearSelect();
    widget._addressManagementProvide.addressModel = null;
    widget._addressManagementProvide.listData().doOnListen(() {
      print('doOnListen');
    }).doOnCancel(() {}).listen((item) {
      ///加载数据
      print('listen data->$item');
      List<AddressModel> list = AddressModelList
          .fromJson(item.data)
          .list;
      widget._addressManagementProvide.addListAddress(list);
    }, onError: (e) {});
    _provide.tel = null;
    _provide.name = null;
    _provide.addressDetail = null;
    _provide.provincesModel=null;
    _provide.cityModel = null;
    _provide.countyModel = null;
    _provide.postalCode = null;
  }

  Provide<NewAddressProvide> _setupBottomBtn() {
    return Provide<NewAddressProvide>(
      builder: (BuildContext context, Widget child, NewAddressProvide provide) {
        return Center(
          child: InkWell(
            onTap: () {
              /// 保存地址
              if(provide.name==null){
                CustomsWidget().showToast(title: "请输入收货人姓名");
              }else if(provide.tel==null){
                CustomsWidget().showToast(title: "请输入收货人手机号");
              }else if(provide.countryModel==null||provide.cityModel==null){
                CustomsWidget().showToast(title: "请选择国家地区");
              }else if(provide.addressDetail==null){
                CustomsWidget().showToast(title: "请填写详细地址");
              }else if(provide.postalCode==null ||provide.postalCode==""){
                CustomsWidget().showToast(title: "请填写邮政编码");
              } else if(widget._addressManagementProvide.addressModel!=null){
                provide.createAndEditAddresses(context,isEdit: true,
                    addressModel:widget._addressManagementProvide.addressModel)
                    .doOnListen(() {}).doOnCancel(() {})
                    .listen((items) {
                  print(items.data);
                  if(items.data!=null){
                    /// 列表数据
                    Fluttertoast.showToast(msg: "修改成功",gravity: ToastGravity.CENTER);
                    Navigator.pop(context);
                  }
                }, onError: (e) {});
              }else{
                provide.createAndEditAddresses(context)
                    .doOnListen(() {}).doOnCancel(() {})
                    .listen((items) {
                  print(items.data);
                  if(items.data!=null){
                    /// 列表数据
                    /// 添加新数据
                    _addressManagementProvide.addAddresses(AddressModel.fromJson(items.data));
                    Fluttertoast.showToast(msg: "保存成功",gravity: ToastGravity.CENTER);
                    Navigator.pop(context);
                  }
                }, onError: (e) {});
              }
            },
            child: Container(
              width: ScreenAdapter.width(705),
              height: ScreenAdapter.height(95),
              color: Colors.black,
              child: Center(
                child: Text(
                  widget._addressManagementProvide.addressModel!=null?'修改':'保存',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.size(38)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///获取国家
  void _getCountries(){
    _provide.getCountriess().doOnListen(() {}).doOnCancel(() {}).listen((items) {
      print('listen data->$items');
      _provide.addCountryList(CountryModelList.fromJson(items.data).list);
      _provide.countryPageList = ApprovedCountryModelList.fromJson(items.data).list;

      // 编辑时
      if(widget._addressManagementProvide.addressModel!=null){
        _provide.addressID = widget._addressManagementProvide.addressModel.addressID;
        // 国家
        _provide.countryList.forEach((item){
          print(item.countryCode);
          if(item.countryCode == widget._addressManagementProvide.addressModel.countryCode){
            _provide.selectCountry(item);
          }
        });
        _provide.initProvinces(
            widget._addressManagementProvide.addressModel.province,
            widget._addressManagementProvide.addressModel.city,
            widget._addressManagementProvide.addressModel.county,
            widget._addressManagementProvide.addressModel.areaCode
        );

//        _provide.provincesModel.regionName = widget._addressManagementProvide.addressModel.province;
//        provide.provincesModel.regionName} "
//      "${provide.cityModel.regionName} "
//          "${provide.countyModel.regionName
//        province = widget._addressManagementProvide.addressModel.province;
//        city = widget._addressManagementProvide.addressModel.city;
//        areaName = widget._addressManagementProvide.addressModel.county;
//        areaCode = widget._addressManagementProvide.addressModel.areaCode;
        if(widget._addressManagementProvide.addressModel.areaCode == '000000'){
          _provide.setForeignAddressModel();
        }else{
          // 城市
          if(_provide.provincesList.length>0){
            _provide.provincesList.forEach((item){
              if(item.regionName==province){
                _provide.selectProvinces(item);
              }
            });
          }
          // 省
          if(_provide.cityList.length>0){
            _provide.cityList.forEach((item){
              if(item.regionName==city){
                _provide.selectCity(item);
              }
            });
          }
          // 区
          if(_provide.countyList.length>0){
            _provide.countyList.forEach((item){
              if(item.regionCode==areaCode){
                _provide.selectCounty(item);
              }
            });
          }
        }

        _provide.name = widget._addressManagementProvide.addressModel.name;
        _provide.tel = widget._addressManagementProvide.addressModel.tel;
        _provide.addressDetail = widget._addressManagementProvide.addressModel.addressDetail;
        _provide.lastUsed = widget._addressManagementProvide.addressModel.lastUsed;
        _provide.postalCode = widget._addressManagementProvide.addressModel.postalCode;
        setState(() {
          isSelected = widget._addressManagementProvide.addressModel.lastUsed;
        });
      }
    }, onError: (e) {});
  }
}
