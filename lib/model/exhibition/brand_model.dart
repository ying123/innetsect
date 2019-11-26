
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

  }