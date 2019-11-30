import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/exhibition/exhibitions_model.dart';
import 'package:innetsect/data/exhibition/halls_model.dart';
import 'package:innetsect/data/exhibition/home_banners_model.dart';
import 'package:innetsect/data/exhibition/home_portlets_model.dart';
import 'package:innetsect/model/exhibition/home_model.dart';

import 'package:rxdart/rxdart.dart';

class HomeProvide extends BaseProvide {



  ExhibitionHomeRepo _repo = ExhibitionHomeRepo();



  ///门票ID
  int portalID ;
  ///门票名字
  String portalName = '';
  ///门票图片
  String portalCover =  '';
  ///展会ID
  int exhibitionID ;
  ///布局
  int layout ;
  String createdDate = '';
  String createdBy = '';
  String lastModified = '';
  String lastModifiedBy = '';


  int shopID;
  String locOverview = '';

  ///商城首页banner
  Observable bannerData() {
    return _repo
        .bannerData()
        .doOnData((result) {})
        .doOnError((e, stack) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///商城首页列表数据
  Observable listData(int pageNo) {
    return _repo
        .listData(pageNo)
        .doOnData((result) {})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///展会数据
  Observable exhibitions (int exhibitionsID){
    return _repo.exhibitions(exhibitionsID).doOnData((item){

    }).doOnError((e, sitack){

    }).doOnDone((){

    });
  }
  /// 扫码
  Observable qrCodeWhisk(Map<String,dynamic> json){
    return _repo.qrCodeWhisk(json).doOnData((item){

    }).doOnError((e, sitack){

    }).doOnDone((){

    });
  }
///首页banner
  List<HomeBannersModel> _bannersList = [];
  List<HomeBannersModel> get bannersList => _bannersList;
///首页列表
  List<HomePortletsModel> _portletsModelList = [];
  List<HomePortletsModel> get portletsModelList => _portletsModelList;


///大厅数据
  List<HallsModel> _hallsModelList = [];
  List<HallsModel> get hallsModelList => _hallsModelList;


  void addBanners(List<HomeBannersModel> list) {
    _bannersList.addAll(list);
    notifyListeners();
  }

  void addPortlets(List<HomePortletsModel> list) {
    _portletsModelList.addAll(list);
    notifyListeners();
  }
///添加大厅
  void addHalls(List<HallsModel> list){
    _hallsModelList.addAll(list);
  }


  void clearList() {
    _bannersList.clear();
    _portletsModelList.clear();
    notifyListeners();
  }
}
