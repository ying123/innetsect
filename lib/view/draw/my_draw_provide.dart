//我的抽签

import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/draw/my_draw_data.dart';
import 'package:innetsect/model/draw/my_drawshop_model.dart';
import 'package:rxdart/rxdart.dart';

class MyDrawProvide extends BaseProvide{

//MyDrawDataModel

List<MyDrawDataModel> _dataModel = List<MyDrawDataModel>();
List<MyDrawDataModel> get dataModel=>_dataModel;
///添加MyDrawDataModel数据
void addDataModel(List<MyDrawDataModel> dataModel){
  _dataModel.addAll(dataModel);
  
}
///清除MyDrawDataModel数据
void clearMyDrawDataModel(){
  _dataModel.clear();
  notifyListeners();
}


  

///我的抽签
  MyDrawshopModelRepo _modelRepo = MyDrawshopModelRepo();
  
  Observable myDrawData(int pageNo, int pageSize){
    return _modelRepo.myDraws(pageNo: pageNo, pageSize: pageSize).doOnData((items){

    }).doOnError((e, stack){

    }).doOnDone((){

    });
  }
  
  
}