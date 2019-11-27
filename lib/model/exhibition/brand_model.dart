
import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class BrandService {
 Observable eshopModel ( ){
    var url = '/api/eshop/app/splash';
    var response = get(url);
    return response;
  }

  ///品牌数据
 Observable brandModel ( int exhibitionID){
    var url = '/api/event/exhibitions/$exhibitionID/brands';
    var response = get(url);
    return response;
  }


///品牌商场
 Observable brandMallModel ( String branName ,int pageNo){
    var url = '/api/event/exhibitions/201058021/products/preview?brand=$branName&pageNo=$pageNo';
    var response = get(url);
    return response;
  }


  }


class BrandRepo {
  final BrandService _remote = BrandService();
  ///
  Observable eshopModel ( ){
    return _remote.eshopModel(  );
  }


  Observable brandModel (int exhibitionID){
    return _remote.brandModel( exhibitionID );
  }

///品牌商场
  Observable brandMallModel (String branName, int exhibitionID){
    return _remote.brandMallModel( branName ,exhibitionID );
  }



  }