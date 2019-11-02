import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/city_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:rxdart/rxdart.dart';

class  NewAddressProvide extends BaseProvide{

  List<CityModel> _cityList=[];

  List<CityModel> get cityList => _cityList;


  void addCityList(List<CityModel> list){
    _cityList = list;
    notifyListeners();
  }
  

  final AddressRepo _repo = AddressRepo();
  ///获取国家
  Observable getCity(){
    return _repo.getCity().doOnData((result){})
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