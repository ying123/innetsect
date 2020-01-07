

import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/data/draw/view_registration_information.dart';
import 'package:innetsect/model/draw/drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

class CheckTheRegistrationProvide extends BaseProvide {
  
  int _id;
  int get id=>_id;
  set id(int id){
    _id = id;
  }

  int _shopId;
  int get shopId=>_shopId;
  set shopId(int shopId){
    _shopId = shopId;
  }

   double _longitude = 1231.1;
  double get longitude=>_longitude;
  set longitude(double longitude){
    _longitude = longitude;
  }

  double _latitude= 131.11;
  double get latitude=>_latitude;
   set latitude(double latitude){
     _latitude = latitude;
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
      id:id,shopId:_shopId
      ).doOnData((item){

      }).doOnError((e,stack){

      }).doOnDone((){

      });
 
 
  }
}