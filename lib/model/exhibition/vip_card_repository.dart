import 'package:innetsect/api/net_utils.dart';
import 'package:rxdart/rxdart.dart';

class VIPCardService{
  Observable listData (){
    var url = '/api/promotion/vipCards/mine';
    var response = get(url);
    return response;
  }
}


class  VIPCardRepo {
  final VIPCardService _remote = VIPCardService();
  Observable listData (){
    return _remote.listData();
  }
}