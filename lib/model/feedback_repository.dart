import 'package:innetsect/api/net_utils.dart';
import 'package:innetsect/data/base.dart';
import 'package:rxdart/rxdart.dart';

/// 意见反馈
class FeedBackService {

  Observable<BaseResponse> requestQNA (String mobile,String question){
    var url = '/api/eshop/qna';
    var json = {
      "mobile": mobile,
      "question": question,
      "status": "0",
      "askDate": new DateTime.now(),
    };
    var response = post(url,body: json);
    return response;
  }
}

class FeedBackRepo{
  final FeedBackService _remote = FeedBackService();

  Observable<BaseResponse> requestQNA(String mobile,String question){
    return _remote.requestQNA(mobile,question);
  }
}