import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:rxdart/rxdart.dart';

class  NewAddressProvide extends BaseProvide{

  String _name;
  String _tel;
  String _addressDetail;
  bool _isDefault;

  get name=>_name;
  get tel=>_tel;
  get addressDetail=>_addressDetail;
  get isDefault=>_isDefault;

  set name(String name){
    _name = name;
    notifyListeners();
  }
  set tel(String tel){
    _tel = tel;
    notifyListeners();
  }
  set addressDetail(String addressDetail){
    _addressDetail = addressDetail;
    notifyListeners();
  }
  set isDefault(bool isDefault){
    _isDefault = isDefault;
    notifyListeners();
  }

  List<CountryModel> _countryList=[];
  List<ProvincesModel> _provincesList=[];
  List<ProvincesModel> _cityList=[];
  List<ProvincesModel> _countyList=[];


  List<CountryModel> get countryList => _countryList;
  List<ProvincesModel> get provincesList => _provincesList;
  List<ProvincesModel> get cityList => _cityList;
  List<ProvincesModel> get countyList => _countyList;

  // 选中国家
  CountryModel _countryModel;
  // 选中省份
  ProvincesModel _provincesModel;
  // 选中市
  ProvincesModel _cityModel;
  // 选中区县
  ProvincesModel _countyModel;

  CountryModel get countryModel => _countryModel;
  ProvincesModel get provincesModel => _provincesModel;
  ProvincesModel get cityModel => _cityModel;
  ProvincesModel get countyModel => _countyModel;

  void addCountryList(List<CountryModel> list){
    _countryList = list;
    notifyListeners();
  }

  void addProvincesList(List<ProvincesModel> list){
    _provincesList = list;
    notifyListeners();
  }

  void addCityList(List<ProvincesModel> list){
    _cityList = list;
    notifyListeners();
  }

  void addCountyList(List<ProvincesModel> list){
    _countyList = list;
    notifyListeners();
  }

  void selectCountry(CountryModel model){
    _countryModel = model;
    notifyListeners();
  }

  void selectProvinces(ProvincesModel model){
    _provincesModel = model;
    notifyListeners();
  }

  void selectCity(ProvincesModel model){
    _cityModel = model;
    notifyListeners();
  }

  void selectCounty(ProvincesModel model){
    _countyModel = model;
    notifyListeners();
  }

  void clearSelect(){
    _countryModel = null;
    _provincesModel = null;
    _cityModel = null;
    _countyModel = null;
    notifyListeners();
  }
  

  final AddressRepo _repo = AddressRepo();
  ///获取国家
  Observable getCountriess(){
    return _repo.getCountriess().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  ///获取省
  Observable getProvices(String code){
    return _repo.getProvices(code).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  ///获取市
  Observable getCitys(String countryCode,String parentCode){
    return _repo.getCitys(countryCode,parentCode).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 创建地址
  Observable createAddresses(BuildContext context) {
    Map<String,dynamic> json = AddressModel().toJson();
    json['name'] = _name;
    json['addressDetail'] = _addressDetail;
    json['tel'] = _tel;
    json['isDefault'] = _isDefault;
    json['province'] = _provincesModel.regionName;
    json['countryCode'] = _countryModel.countryCode;
    json['city'] = _cityModel.regionName;
    json['county'] = _countyModel.regionName;
    json['areaCode'] = _countyModel.regionCode;
    json["acctID"] = UserTools().getUserData()['id'];
    return _repo
        .createAddresses(json, context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  ///工厂模式
  factory NewAddressProvide()=> _getInstance();
  static NewAddressProvide get instance => _getInstance();
  static NewAddressProvide _instance;
  static NewAddressProvide _getInstance(){
    if (_instance == null) {
      _instance = new NewAddressProvide._internal();
    }
    return _instance;
  }

  NewAddressProvide._internal() {
    print('NewAddressProvide初始化');
    // 初始化
  }
}