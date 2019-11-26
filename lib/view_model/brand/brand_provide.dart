
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/brand_model.dart';
import 'package:rxdart/rxdart.dart';

class BrandProvide extends BaseProvide{



  BrandRepo _repo = BrandRepo();

  Observable splashData(){
    return _repo.eshopModel().doOnListen((){

    }).doOnData((item){

    }).doOnDone((){

    });
  }


///品牌数据
  Observable brandModel(int exhibitionID){
    return _repo.brandModel(exhibitionID).doOnData((item){

    }).doOnDone((){

    }).doOnError((e, stack){

    });
  }
  
}