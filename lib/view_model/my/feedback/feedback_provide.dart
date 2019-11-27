import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/feedback_repository.dart';
import 'package:rxdart/rxdart.dart';
/// 意见反馈
class FeedbackProvide extends BaseProvide{
  String _content;
  String _phone;

  String get content => _content;
  String get phone => _phone;

  set content(String content){
    _content = content;
    notifyListeners();
  }

  set phone(String phone){
    _phone = phone;
    notifyListeners();
  }

  final FeedBackRepo _repo = FeedBackRepo();

  ///获取订单全部列表
  Observable requestQNA(){
    return _repo.requestQNA(_phone,_content).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}