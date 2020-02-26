import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/draw_data.dart';
import 'package:innetsect/data/draw/my_draw_data.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

///我的抽签详情

class MyDrawInfoProvide extends BaseProvide{


int _drawID;
int get drawID=>_drawID;
set drawID(int drawID){
  _drawID = drawID;
}

int _shopID;
int get shopID=>_shopID;
set shopID(int shopID){
  _shopID = shopID;
}


///抽签数据
  DrawsModel _drawsModel = DrawsModel();
  DrawsModel get drawsModel=>_drawsModel;
  set drawsModel(DrawsModel drawsModel){
    _drawsModel = drawsModel;
  }






  //MyDrawDataModel
  MyDrawDataModel _dataModel = MyDrawDataModel();
  MyDrawDataModel get dataModel=>_dataModel;
  set dataModel(MyDrawDataModel dataModel){
    _dataModel = dataModel;
  }


  //ViewRegistrationInformationModel
  ViewRegistrationInformationModel _viewRegistrationInformationModel = ViewRegistrationInformationModel();
  ViewRegistrationInformationModel get viewRegistrationInformationModel=>_viewRegistrationInformationModel;
  set viewRegistrationInformationModel(ViewRegistrationInformationModel viewRegistrationInformationModel){
    _viewRegistrationInformationModel = viewRegistrationInformationModel;
    notifyListeners();
  }

  DrawshopRepo _drawshopRepo = DrawshopRepo();
  
  Observable viewRegistrationInformation( ){
    return _drawshopRepo.viewRegistrationInformation(
      id:drawID,shopId:shopID
      ).doOnData((item){

      }).doOnError((e,stack){

      }).doOnDone((){

      });
 
 
  }
///销售单
  Observable salesOrder(int drawId){
    return _drawshopRepo.salesOrder(drawId).doOnData((item){

    }).doOnError((e, stackTeack){

    }).doOnDone((){

    });
  }


   DrawshopRepo _repo = DrawshopRepo();
///抽签信息
  Observable draws(redirectParamId){
    return _repo.draws(drawID: redirectParamId).doOnData((item){

    }).doOnError((e,stack){

    }).doOnDone((){

    });
  }

  
}