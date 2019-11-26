import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/base.dart';
import 'package:innetsect/model/exhibition/halls_model.dart';
import 'package:rxdart/rxdart.dart';

class VenuesHallsE6Provide extends BaseProvide{


  HallsRepo _repo = HallsRepo();

    Observable<BaseResponse> hallsData(int exhibitionID, String exhibitionHall ){
        return _repo.halls(exhibitionID, exhibitionHall).doOnData((item){

        }).doOnError((e,stack){

        }).doOnDone((){

        });
    }
  
}