
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
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



  //DrawsModel
  DrawsModel _drawsModel = DrawsModel();
  DrawsModel get drawsModel=>_drawsModel;
  set drawsModel(DrawsModel drawsModel){
    _drawsModel = drawsModel;
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

  
}