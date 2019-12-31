
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/data/draw/lottery_registration_page.dart';
import 'package:innetsect/data/draw/shops_data.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';
///抽签详情
class DrawDetailsProvide extends BaseProvide{

  int _registrationStatus = 1;
  int get registrationStatus=>_registrationStatus;
  set registrationStatus(int registrationStatus){
    _registrationStatus = registrationStatus;
    notifyListeners();
  }


  int _shopID ;
  int get shopID=>_shopID;
  set shopID(int shopID){
    _shopID = shopID;
    notifyListeners();
  }

  ShopsModel _model = ShopsModel();
  ShopsModel get model=>_model;
  set model(ShopsModel model){
    _model = model;
  }


  



  //DrawsModel
  DrawsModel _drawsModel = DrawsModel();
  DrawsModel get drawsModel=>_drawsModel;
  set drawsModel(DrawsModel drawsModel){
    _drawsModel = drawsModel;
    notifyListeners();
  }

  //LotteryRegistrationPageModel
  LotteryRegistrationPageModel _lotteryRegistrationPageModel = LotteryRegistrationPageModel();
  LotteryRegistrationPageModel get lotteryRegistrationPageModel=>_lotteryRegistrationPageModel;
  set lotteryRegistrationPageModel(LotteryRegistrationPageModel lotteryRegistrationPageModel){
      _lotteryRegistrationPageModel = lotteryRegistrationPageModel;
      notifyListeners();
  }



  //DrawshopRepo

  DrawshopRepo _repo = DrawshopRepo();
///抽签信息
  Observable draws(){
    return _repo.draws().doOnData((item){

    }).doOnError((e,stack){

    }).doOnDone((){

    });
  }
///进入店铺抽签登记页
  Observable lotteryRegistrationPage(){
    return _repo.lotteryRegistrationPage(longitude:23.12,latitude:123.21323).doOnData((item){

    }).doOnError((e,stack){

    }).doOnDone((){

    });
  }

  
}