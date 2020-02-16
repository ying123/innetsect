import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/my_draw_data.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

///我的抽签详情

class MyDrawInfoProvide extends BaseProvide{


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
  
  Observable viewRegistrationInformation(){
    return _drawshopRepo.viewRegistrationInformation(
      id:dataModel.drawID,shopId:dataModel.shopID
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

  
}