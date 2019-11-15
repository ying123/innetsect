
import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/information/information_repository.dart';
import 'package:rxdart/rxdart.dart';

class InformationProvide extends BaseProvide{
  int _contentID;
  int get contentID=>_contentID;
  set contentID(int contentID){
    _contentID = contentID;
    notifyListeners();
  }

  /// 工厂模式
  factory InformationProvide()=> _getInstance();
  static InformationProvide get instance => _getInstance();
  static InformationProvide _instance;
  static InformationProvide _getInstance(){
    if (_instance == null) {
      _instance = new InformationProvide._internal();
    }
    return _instance;
  }

  InformationProvide._internal() {
    print('InformationProvide init');
  }

  final InformationRepo _repo = InformationRepo();

  ///获取列表
  Observable listData({int pageNo=1}){
    return _repo.listData(pageNo).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 详情
  Future getDetail(){
    return _repo.getDetail(this.contentID);
  }
}