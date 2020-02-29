

import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/coupons/coupons.dart';
import 'package:innetsect/model/coupons/coupons.dart';
import 'package:rxdart/rxdart.dart';

class AllCoupnsProvide extends BaseProvide{

  bool _expansionChanged;
  bool get expansionChanged => _expansionChanged;
  set expansionChanged(bool expansionChanged){
    _expansionChanged = expansionChanged;
    notifyListeners();
  }

  int _listIndex =0;
  int get listIndex => _listIndex;
  set listIndex(int listIndex){
    _listIndex = listIndex;
   // notifyListeners();
  }

///未使用优惠卷列表
  List<CouponsModel> _dontCouponsModelList = List<CouponsModel> ();
  List<CouponsModel> get dontCouponsModelList=> _dontCouponsModelList;
  void addDontCouponsMode(List<CouponsModel> couponsModel){
    _dontCouponsModelList.addAll(couponsModel);
    notifyListeners();
  }

  void cleanCouponsModel(){
    _dontCouponsModelList.clear();
    //notifyListeners();
  }



  CouponsRepo _couponsRepo = CouponsRepo();
  //未使用优惠卷
  Observable dontCouponsRepo(String type, {int pageNo}){
    return _couponsRepo.dontUseCouPons(type ,pageNo:pageNo ).doOnData((item){

    }).doOnError((){

    }).doOnDone((){

    });
  }
  
}