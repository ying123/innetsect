import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/base.dart';
import 'package:innetsect/data/series/category_model.dart';
import 'package:innetsect/model/mall/series_repository.dart';
import 'package:rxdart/rxdart.dart';

/// 分类
class SeriesProvide extends BaseProvide{

  CategoryModel _category;

  CategoryModel get category=>_category;

  void onCheckCatCode(CategoryModel map){
    _category = map;
    notifyListeners();
  }

  /// 工厂模式
  static SeriesProvide _instance;
  factory SeriesProvide()=>_getInstance();
  static SeriesProvide get instance =>_getInstance();
  static SeriesProvide _getInstance(){
    if (_instance == null) {
      _instance = new SeriesProvide._internal();
    }
    return _instance;
  }

  SeriesProvide._internal() {
    print('SeriesProvide init');
  }

  final SeriesRepo _repo = SeriesRepo();

  /// 品牌请求
  Observable<BaseResponse> seriesListData (){
    return _repo.seriesListData().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 品类根导航
  Observable<BaseResponse> getCateGoryRoot (){
    return _repo.getCateGoryRoot().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 品类子类
  Observable<BaseResponse> getSubCateGory (int catCode){
    return _repo.getSubCateGory(catCode).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}