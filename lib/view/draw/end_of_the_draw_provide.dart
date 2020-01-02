import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';
import 'package:innetsect/data/draw/pics_data.dart';
import 'package:innetsect/data/draw/shops_data.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

///进入店铺抽签登记页
class EndOfTheDrawProvide extends BaseProvide {



  String _platform;
  String get platform=>_platform;
  set platform(String platform){
    _platform = platform;
  }

  String _buttonName;
  String get buttonName=>_buttonName;
  set buttonName(String buttonName){
    _buttonName = buttonName;
  }

  int _buttonStatus ;
  int get buttonStatus=>_buttonStatus;
  set buttonStatus(int buttonStatus){
    _buttonStatus = buttonStatus;
  }
///轮播图
  //PicsModel
  List _picsList = List();
  List get picsList=>_picsList;
  set picsList(List picsList ){
    _picsList = picsList;
  }

  ShopsModel _shopsModel = ShopsModel();
  get shopsModel =>_shopsModel;
  set shopsModel (ShopsModel shopsModel ){
    _shopsModel = shopsModel;
  }

  double _longitude = 132.1;
  double get longitude=>_longitude;
  set longitude(double longitude){
    _longitude = longitude;
  }

  double _latitude=1336.11;
  double get latitude=>_latitude;
   set latitude(double latitude){
     _latitude = latitude;
  }
  

  LotteryRegistrationPageModel _lotteryRegistrationPageModel = LotteryRegistrationPageModel();
  LotteryRegistrationPageModel get lotteryRegistrationPageModel=> _lotteryRegistrationPageModel;
  set lotteryRegistrationPageModel(LotteryRegistrationPageModel lotteryRegistrationPageModel){
    _lotteryRegistrationPageModel = lotteryRegistrationPageModel;
    notifyListeners();
  }

  DrawshopRepo _repo = DrawshopRepo();
  Observable loadLotteryRegistrationPage() {
    return _repo.lotteryRegistrationPage(
        longitude: longitude, latitude: latitude, platform: platform).doOnData((items){

        }).doOnError((e,stack){

        }).doOnDone((){

        });
  }
}
