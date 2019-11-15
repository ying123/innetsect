
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/commodity_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommodityProvide extends BaseProvide{

  final CommodityRepo _repo = CommodityRepo();

  ///展会首页数据
  Observable homeListData(int pageNo,String types) {
    return _repo
        .homeListData(pageNo,types)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

}