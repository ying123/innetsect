
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class SeriesService {

  /// 品牌
  Observable<BaseResponse> seriesListData (){
    var url = '/api/eshop/brands/approved';
    var response = get(url);
    return response;
  }

  /// 品类根导航
  Observable<BaseResponse> getCateGoryRoot (){
    var url = '/api/eshop/catalogs/roots?withBrands=true';
    var response = get(url);
    return response;
  }

  /// 品类右边子类
  Observable<BaseResponse> getSubCateGory (int catCode){
    var url = '/api/eshop/catalogs/$catCode?withBrands=true';
    var response = get(url);
    return response;
  }
}

class SeriesRepo {
  final SeriesService _remote = SeriesService();

  /// 品牌
  Observable<BaseResponse> seriesListData (){
    return _remote.seriesListData();
  }

  /// 品类根导航
  Observable<BaseResponse> getCateGoryRoot (){
    return _remote.getCateGoryRoot();
  }

  /// 品类右边子类
  Observable<BaseResponse> getSubCateGory (int catCode){
    return _remote.getSubCateGory(catCode);
  }
}