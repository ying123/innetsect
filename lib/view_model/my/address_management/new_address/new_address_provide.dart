import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/data/series/approved_country_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:innetsect/tools/user_tool.dart';
import 'package:rxdart/rxdart.dart';

class  NewAddressProvide extends BaseProvide{

  int _addressID;
  String _name;
  String _tel;
  String _addressDetail;
  bool _lastUsed;
  String _postalCode;

  get addressID=>_addressID;
  get name=>_name;
  get tel=>_tel;
  get addressDetail=>_addressDetail;
  String get postalCode => _postalCode;
  bool get lastUsed=>_lastUsed;

  set addressID(int addressID){
    _addressID = addressID;
    notifyListeners();
  }
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
  set lastUsed(bool lastUsed){
    _lastUsed = lastUsed;
    notifyListeners();
  }

  set postalCode(String postalCode){
    _postalCode = postalCode;
    notifyListeners();
  }

  List<CountryModel> _countryList=[];
  List<ProvincesModel> _provincesList=[];
  List<ProvincesModel> _cityList=[];
  List<ProvincesModel> _countyList=[];
  // 国家页面使用
  List<ApprovedCountryModel> _countryPageList=[];

  List<CountryModel> get countryList => _countryList;
  List<ProvincesModel> get provincesList => _provincesList;
  List<ProvincesModel> get cityList => _cityList;
  List<ProvincesModel> get countyList => _countyList;
  List<ApprovedCountryModel> get countryPageList => _countryPageList;

  set countryPageList(List<ApprovedCountryModel> list){
    _countryPageList = list;
    notifyListeners();
  }

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

  set provincesModel(ProvincesModel model){
    _provincesModel = model;
    notifyListeners();
  }
  set cityModel(ProvincesModel model){
    _cityModel = model;
    notifyListeners();
  }
  set countyModel(ProvincesModel model){
    _countyModel = model;
    notifyListeners();
  }

  set countryModel(CountryModel model){
    _countryModel = model;
    notifyListeners();
  }
  void setCountryModle(ApprovedCountryModel model){
    _countryModel.telPrefix = model.telPrefix;
    _countryModel.briefName = model.name;
    _countryModel.countryCode = model.countryCode;
    notifyListeners();
  }

  void initCountryModel(){
    CountryModel model = new CountryModel();
    //初始化参数
    model.countryCode = "CN";
    model.briefName = "中国";
    model.telPrefix = "86";
    _countryModel = model;
    notifyListeners();
  }
  // 选外国的时候赋值
  void setForeignAddressModel(){
    _provincesModel = new ProvincesModel();
    _cityModel = new ProvincesModel();
    _countyModel = new ProvincesModel();
    _provincesModel.regionName = "外国";
    _cityModel.regionName = "外国";
    _countyModel.regionName = "外国";
    _countyModel.regionCode = "000000";
    notifyListeners();
  }

  void initProvinces(String province,String city,String county,String areaCode){
    _provincesModel = new ProvincesModel();
    _cityModel = new ProvincesModel();
    _countyModel = new ProvincesModel();
    _provincesModel.regionName = province;
    _cityModel.regionName = city;
    _countyModel.regionName = county;
    _countyModel.regionCode = areaCode;
    notifyListeners();
  }

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
    _provincesModel = null;
    _cityModel = null;
    _countyModel = null;
    notifyListeners();
  }

  void selectProvinces(ProvincesModel model){
    _provincesModel = model;
    _cityModel = null;
    _countyModel = null;
    notifyListeners();
  }

  void selectCity(ProvincesModel model){
    _cityModel = model;
    _countyModel = null;
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
  Observable createAndEditAddresses(BuildContext context,{bool isEdit = false,
  AddressModel addressModel}) {
    if(!isEdit){
      addressModel = AddressModel();
    }
    addressModel.name = _name;
    addressModel.addressDetail = _addressDetail;
    addressModel.tel = _tel;
    addressModel.lastUsed = _lastUsed;
    addressModel.countryCode = _countryModel.countryCode;
    addressModel.province = _provincesModel==null?addressModel.province
        :_provincesModel.regionName;
    addressModel.city = _cityModel==null?addressModel.city
        :_cityModel.regionName;
    addressModel.county = _countyModel==null?addressModel.county
        :_countyModel.regionName;
    addressModel.areaCode=_countyModel==null?addressModel.areaCode
        :_countyModel.regionCode;
    addressModel.postalCode=_postalCode;
    addressModel.acctID = UserTools().getUserData()['id'];
    addressModel.telPrefix = _countryModel.telPrefix;
    Map<String,dynamic> json = addressModel.toJson();
    if(isEdit){
      json['addressID'] = _addressID;
      return _repo
          .editAddresses(json, context)
          .doOnData((result) {

      })
          .doOnError((e, stacktrace) {})
          .doOnListen(() {})
          .doOnDone(() {});
    }else{
      return _repo
          .createAddresses(json, context)
          .doOnData((result) {

      })
          .doOnError((e, stacktrace) {})
          .doOnListen(() {})
          .doOnDone(() {});
    }
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