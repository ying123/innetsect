import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';
import 'package:innetsect/data/draw/pics_data.dart';
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

  LotteryRegistrationPageModel _lotteryRegistrationPageModel = LotteryRegistrationPageModel();
  LotteryRegistrationPageModel get lotteryRegistrationPageModel=> _lotteryRegistrationPageModel;
  set lotteryRegistrationPageModel(LotteryRegistrationPageModel lotteryRegistrationPageModel){
    _lotteryRegistrationPageModel = lotteryRegistrationPageModel;
    notifyListeners();
  }

  DrawshopRepo _repo = DrawshopRepo();
  Observable loadLotteryRegistrationPage() {
    return _repo.lotteryRegistrationPage(
        longitude: 23.12, latitude: 123.21323, platform: platform).doOnData((items){

        }).doOnError((e,stack){

        }).doOnDone((){

        });
  }
}
