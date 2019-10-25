import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_color_model.dart';
import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/data/commodity_size_model.dart';

/// 商品、购物车、计数器 provide
class CommodityAndCartProvide extends BaseProvide{

  // 商品对象
  CommodityModel _commodityModel;
  // 商品List数组对象
  List<CommodityModel> _commodityModelList = new List();
  // 颜色对象list
  List<CommodityColorModel> commodityColorModelList= new List();
  // 尺寸对象list
  List<CommoditySizeModel> commoditySizeModelList= new List();
  // 计数器，用于单个商品计算时
  int _count = 1;
  // 计数器模式, single除购物车之外，multiple购物车中使用
  String _mode = "single";
  // 是否全选
  bool _isSelected = false;

  get commodityModel => _commodityModel;
  get count => _count;
  get commodityModelList => _commodityModelList;
  get mode => _mode;
  get isSelected => _isSelected;

  // 缓存单个商品
  void setCommodityModel(CommodityModel model){
    _commodityModel = model;
    notifyListeners();
  }

  // 将商品添加到购物车list
  void addCommodityModelList(CommodityModel model){
    _commodityModelList.add(model);
    notifyListeners();
  }

  // 增加
  void increment({int idx}) {
    if(_mode=="single"){
      _count ++;
    } else {
      _commodityModelList[idx].count ++;
    }
    notifyListeners();
  }

  // 减少
  void reduce({int idx}) {
    if(_mode=="single"){
      if(_count>0 ){
        _count --;
      }
    } else {
      if(_commodityModelList[idx].count>0){
        _commodityModelList[idx].count --;
      }
    }
    notifyListeners();
  }

  // 设置计数器模式, 默认为单计数
  void setMode({String mode="single"}){
    _mode = mode;
    notifyListeners();
  }

  // 是否选中
  void setSelected(int idx,bool isSelected){
    _commodityModelList[idx].isSelected = !isSelected;
    // 判断是否全选
    _isSelected = _commodityModelList.every((item)=>item.isSelected==true);
    notifyListeners();
  }

  // 所有选中的商品选中或取消
  void setValSelected(bool isSelected){
    _commodityModelList.forEach((item)=>item.isSelected=isSelected);
    notifyListeners();
  }

  // 删除所选
  void onDelSelect(){
    _commodityModelList.removeWhere((item)=>item.isSelected==true);
    notifyListeners();
  }
  // 删除数量为0的商品
  void onDelCountToZero(int idx){
    _commodityModelList.removeAt(idx);
    notifyListeners();
  }
}