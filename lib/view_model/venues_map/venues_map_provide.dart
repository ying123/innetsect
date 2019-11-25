import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/venue_halls_model.dart';
import 'package:innetsect/model/exhibition/halls_model.dart';
import 'package:rxdart/rxdart.dart';



class VenuesMapProvide extends BaseProvide {
  
  List<HallsModel> _menu = [];
  List<HallsModel> get menu=> _menu; 
  void addMenu(List<HallsModel> menu){
    _menu.addAll(menu);
  }
///E5
  List<VenueHallsModel> _hallsModelE5 = [];
  List<VenueHallsModel> get hallsModelE5 => _hallsModelE5;
///E6
  List<VenueHallsModel> _hallsModelE6 = [];
  List<VenueHallsModel> get hallsModelE6 => _hallsModelE6;

  void addHallsModelE5List (List<VenueHallsModel> list){
    _hallsModelE5.addAll(list);
    notifyListeners();
  }
  
  void addHallsModelE6List (List<VenueHallsModel> list){
    _hallsModelE6.addAll(list);
    notifyListeners();
  }

    HallsRepo _repo = HallsRepo();

    Observable hallsData(int exhibitionID, String exhibitionHall ){
        return _repo.halls(exhibitionID, exhibitionHall).doOnData((item){

        }).doOnError((e,stack){

        }).doOnDone((){

        });
    }

}
