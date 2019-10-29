import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/advisory_details_repository.dart';
import 'package:rxdart/rxdart.dart';

class AdvisoryDetailsProvide extends BaseProvide{
  

  int _contentID;
  set contentID(int contentID){
    _contentID = contentID;
    notifyListeners();
  }
  get contentID{
    return _contentID;
  }
///资讯详情数据
  Map _advisoryDetailsData;
  get advisoryDetailsData{
    return _advisoryDetailsData;
  } 

  set advisoryDetailsData(Map advisoryDetailsData){
    _advisoryDetailsData = advisoryDetailsData;
    notifyListeners();
  }

  final AdvisoryDatailsRepo _repo = AdvisoryDatailsRepo();
  Observable loadadvisoryDetails(int content){
    var body = {'contentID':content};

    return _repo.loadadvisoryDetails(body).doOnData((data){
      //print('_repo data:->$data');    
    });
  }

}