
import 'package:flutter/cupertino.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/brand_mall_model.dart';
import 'package:innetsect/model/exhibition/brand_model.dart';
import 'package:rxdart/rxdart.dart';

class BrandMallPrvide extends BaseProvide {


  List<BrandMallModel>_brandMallList = [];
  List<BrandMallModel> get brandMallList => _brandMallList;
  set brandMallList(List list){
    _brandMallList = list;
    notifyListeners();
  }
  void addBrandMall(List<BrandMallModel> list ){
    _brandMallList.addAll(list);
    notifyListeners();
  }

  void clranBrandMall(){
    _brandMallList.clear();
    notifyListeners();
  }


  BrandRepo _repo = BrandRepo();
  ///品牌商城数据
  Observable brandMallData(int exhibitionID,String branName, int pageNo,BuildContext context){
    return _repo.brandMallModel(exhibitionID,branName, pageNo,context).doOnData((item){

    }).doOnCancel((){

    }).doOnError((e,stack){

    }).doOnDone((){

    });
  }

  ///品牌商城数据
  Observable listData(int exhibitionID){
    return _repo.brandModel(exhibitionID).doOnData((item){

    }).doOnCancel((){

    }).doOnError((e,stack){

    }).doOnDone((){

    });
  }
  
}