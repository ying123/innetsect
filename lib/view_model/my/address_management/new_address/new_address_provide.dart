import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/city_model.dart';
import 'package:innetsect/model/address_repository.dart';
import 'package:rxdart/rxdart.dart';

class  NewAddressProvide extends BaseProvide{

  List<CityModel> _cityList=[];
  Map<String,dynamic> _cityJson=new Map();

  List<CityModel> get cityList => _cityList;

  get cityJson => _cityJson;

  void addCityList(List<CityModel> list){
    _cityList = list;
    notifyListeners();
  }
  
  void parseMap(List<CityModel> list){
    list.forEach((item){
      _cityJson..addAll({item.countryCode: item.briefName});
      print(_cityJson);
    });
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
}