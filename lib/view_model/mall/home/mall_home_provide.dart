import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/mall/banners_model.dart';
import 'package:innetsect/model/mall/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class MallHomeProvide extends BaseProvide{

  List<BannersModel> _bannersList=[];

  List<BannersModel> get bannersList=>_bannersList;

  void addBannersModel(List<BannersModel> list){
    _bannersList = list;
    notifyListeners();
  }

  //列表项数据
  List listItems = [
    {
      'image': 'assets/images/l1.png',
      'title': "全新联名鞋款发售详情公布",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l2.png',
      'title': "Nike 2019 N7专属系列鞋款正式亮相,是否还是地区限定?",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l1.png',
      'title': "全新联名鞋款发售详情公布",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l2.png',
      'title': "Nike 2019 N7专属系列鞋款正式亮相,是否还是地区限定?",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l1.png',
      'title': "全新联名鞋款发售详情公布",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l2.png',
      'title': "Nike 2019 N7专属系列鞋款正式亮相,是否还是地区限定?",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l2.png',
      'title': "Nike 2019 N7专属系列鞋款正式亮相,是否还是地区限定?",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },
    {
      'image': 'assets/images/l2.png',
      'title': "Nike 2019 N7专属系列鞋款正式亮相,是否还是地区限定?",
      'subTitle': "# 潮流",
      'subTitle1': "# 潮牌",
      'subTitle2': "# 联名",
      'time':"1小时",
      'focusNuber': '1063'
    },

  ];


  /// 请求
  final MallHomeRepo _repo = MallHomeRepo();

  ///展会首页数据
  Observable bannerData() {
    return _repo.bannerData()
        .doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}