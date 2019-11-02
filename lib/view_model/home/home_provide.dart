import 'package:innetsect/base/base.dart';
import 'package:innetsect/model/exhibition_home_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvide extends BaseProvide {

  
  List<String> _bannerImages = [];

  get bannerImages {
    return _bannerImages;
  }

  set banneImages(String bannerImage) {
    _bannerImages.add(bannerImage);
    notifyListeners();
  }

  ///首页portlets数据
  List _portlets = [];

  get portlets {
    return _portlets;
  }

  set portlets(Map portlets) {
    _portlets.add(portlets);
    notifyListeners();
  }

  ///首页contents数据
  List<dynamic> _contents = [];
  get contents {
    return _contents;
  }

  set contents(Map contents) {
    _contents.add(contents);
    notifyListeners();
  }
///内容项ID
  int _contentID ;
  get contentID{
    return _contentID;
  }
  set contentID(int contentID){
    _contentID = contentID;
    notifyListeners();
  }


  ///条形码
  String _barcode = '';
  get barcode {
    return _barcode;
  }

  set barcode(String code) {
    _barcode = code;
    notifyListeners();
  }

//广告内容
  String _advertising = '2019INNERSECT国际潮流文化体验展指南';
  get advertising {
    return _advertising;
  }

  set advertising(String advertising) {
    _advertising = advertising;
    notifyListeners();
  }


  final ExhibitionHomeRepo _repo = ExhibitionHomeRepo();

  ///展会首页数据
  Observable homeDatas() {
    return _repo
        .homeDatas()
        .doOnData((result) {
         
        })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}
