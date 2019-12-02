
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/luck_sign_repository.dart';
import 'package:rxdart/rxdart.dart';

/// 我的中签
class LuckSignProvide extends BaseProvide {
  LuckSignRepo _repo =  LuckSignRepo();
  ///列表数据
  Observable getSignList(){
    return _repo.getSignList().doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }

  Observable getDetail (int prodID){
    return _repo.getDetail(prodID).doOnData((item){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }
}