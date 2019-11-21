
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/mall/search_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchProvide extends BaseProvide{

  //搜索条件
  String _searchValue;

  String get searchValue=>_searchValue;

  set searchValue(String searchValue){
    _searchValue = searchValue;
    notifyListeners();
  }

  /// 工厂模式
  factory SearchProvide()=> _getInstance();
  static SearchProvide get instance => _getInstance();
  static SearchProvide _instance;
  static SearchProvide _getInstance(){
    if (_instance == null) {
      _instance = new SearchProvide._internal();
    }
    return _instance;
  }

  SearchProvide._internal() {
    print('MallProvode init');
  }

  final SearchRepo _repo = SearchRepo();

  ///获取列表
  Observable onRecommendedTags(){
    return _repo.onRecommendedTags().doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}