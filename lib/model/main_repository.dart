import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class MainService {
  Observable<BaseResponse> getSplash(){
    var url = '/api/eshop/app/splash';
    var response = get(url);
    return response;
  }

  Observable<BaseResponse> getExhibition(int exhibitionID){
    var url = '/api/event/exhibitions/$exhibitionID';
    var response = get(url);
    return response;
  }
}

class MainRepo{
  final MainService _mainService = MainService();

  Observable<BaseResponse> getSplash(){
    return _mainService.getSplash();
  }

  Observable<BaseResponse> getExhibition(int exhibitionID){
    return _mainService.getExhibition(exhibitionID);
  }

}