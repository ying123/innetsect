import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 购买须知
class NoticeService{
  Observable<BaseResponse> listData(){
    var url = '/api/eshop/app/instructions';
    var response = get(url);
    return response;
  }
}

class NoticeRepo{
  final NoticeService _remote = NoticeService();

  Observable<BaseResponse> listData(){
    return _remote.listData();
  }
}