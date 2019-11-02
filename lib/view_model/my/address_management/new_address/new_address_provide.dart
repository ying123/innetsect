import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/country_model.dart';
import 'package:innetsect/data/provinces_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:rxdart/rxdart.dart';

class  NewAddressProvide extends BaseProvide{

  List<CountryModel> _cityList=[];
  List<ProvincesModel> _provincesList=[];

  List<CountryModel> get cityList => _cityList;
  List<ProvincesModel> get provincesList => _provincesList;

  // 选中国家
  CountryModel _countryModel;

  get countryModel => _countryModel;

  void addCityList(List<CountryModel> list){
    _cityList = list;
    notifyListeners();
  }

  void addProvincesList(List<ProvincesModel> list){
    _provincesList = list;
    notifyListeners();
  }

  void selectCity(CountryModel model){
    _countryModel = model;
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
  Observable getCitys(String code){
    return _repo.getCitys(code).doOnData((result){})
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