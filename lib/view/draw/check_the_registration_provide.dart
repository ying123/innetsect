

import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

class CheckTheRegistrationProvide extends BaseProvide {
  DraweeModel _draweeModel= DraweeModel();
  DraweeModel get draweeModel=>_draweeModel;
  set draweeModel(DraweeModel draweeModel){
    _draweeModel = draweeModel;
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
      id:draweeModel.drawID,shopId:draweeModel.shopID
      ).doOnData((item){

      }).doOnError((e,stack){

      }).doOnDone((){

      });
 
 
  }
}