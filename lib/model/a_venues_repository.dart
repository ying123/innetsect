


import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

///品牌网络请求相关
class AVenuesService {
  ///A场馆数据请求
  Observable loadAVenues(){
    var url = '/api/event/exhibitions/201058021/halls/A/brands';
    var response = get(url);
    return response;
  }
  ///B场馆数据请求
  Observable loadBVenues(){
    var url = '/api/event/exhibitions/201058021/halls/B/brands';
    var response = get(url);
    return response;
  }
}

///品牌数据响应
class  AVenuesRepo {
  ///A场馆数据响应
  final AVenuesService _remote = AVenuesService();
  Observable loadAVenues(){
    return _remote.loadAVenues();
  }
  ///B场馆数据响应
  Observable loadBVenues(){
    return _remote.loadBVenues();
  }
}