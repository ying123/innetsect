
import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

class SeriesService {

  /// 品牌
  Observable<BaseResponse> seriesListData (){
    var url = '/api/society/portals/home';
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
}