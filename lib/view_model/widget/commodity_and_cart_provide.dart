import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_color_model.dart';
import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/data/commodity_size_model.dart';

/// 商品、购物车、计数器 provide
class CommodityAndCartProvide extends BaseProvide{

  // 商品对象
  CommodityModel _commodityModel;
  // 商品List数组对象
  List<CommodityModel> commodityModelList;
  // 颜色对象list
  List<CommodityColorModel> commodityColorModelList;
  // 尺寸对象list
  List<CommoditySizeModel> commoditySizeModelList;
  // 计数器，用于单个商品计算时
  int _count = 1;

  get commodityModel => _commodityModel;
  get count => _count;

  // 缓存单个商品
  void setCommodityModel(CommodityModel model){
    _commodityModel = model;
    notifyListeners();
  }

  // 将商品添加到购物车list
  void addCommodityModelList(CommodityModel model){
    commodityModelList..add(model);
    notifyListeners();
  }

  // 增加
  void increment() {
    _count ++;
    print(_count);
    notifyListeners();
  }

  // 减少
  void reduce() {
    _count --;
    notifyListeners();
  }


}