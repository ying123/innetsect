import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition/vip_card_repository.dart';
import 'package:rxdart/rxdart.dart';
///贵宾卡
class VIPCardProvide extends BaseProvide{


  final VIPCardRepo _repo = VIPCardRepo();

  ///获取订单全部列表
  Observable listData(){
    return _repo.listData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}