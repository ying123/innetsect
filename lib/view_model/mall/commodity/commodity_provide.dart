
import 'package:flutter/cupertino.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/model/commodity_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommodityProvide extends BaseProvide{

  List<CommodityModels> _list=[];

  List<CommodityModels> get list => _list;

  void setList({@required  List<CommodityModels> lists,bool isReload = false}){
    _list..addAll(lists);
    notifyListeners();
  }

  void clearList(){
    _list.clear();
    notifyListeners();
  }

  final CommodityRepo _repo = CommodityRepo();

  ///展会首页数据
  Observable homeListData(int pageNo,String types) {
    return _repo
        .homeListData(pageNo,types)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

}