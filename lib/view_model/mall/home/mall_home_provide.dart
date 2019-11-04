import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/data/mall/portlets_model.dart';
import 'package:innetsect/model/mall/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class MallHomeProvide extends BaseProvide{

  List<BannersModel> _bannersList=[];

  List<PortletsModel> _portletsModelList = [];

  List<BannersModel> get bannersList=>_bannersList;
  List<PortletsModel> get portletsModelList=>_portletsModelList;


  void addBannersModel(List<BannersModel> list){
    _bannersList = list;
    notifyListeners();
  }

  void addListData(List<PortletsModel> list){
    _portletsModelList..addAll(list);
    notifyListeners();
  }

  void clearList(){
    _bannersList.clear();
    _portletsModelList.clear();
  }

  /// 请求
  final MallHomeRepo _repo = MallHomeRepo();

  ///商城首页数据
  Observable bannerData() {
    return _repo.bannerData()
        .doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///商城首页列表数据
  Observable listData(int pageNo) {
    return _repo.listData(pageNo)
        .doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}