import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/commodity_color_model.dart';
import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/data/commodity_size_model.dart';
import 'package:innetsect/data/commodity_types_model.dart';
import 'package:innetsect/enum/commodity_cart_types.dart';

/// 商品、购物车、计数器 provide
class CommodityAndCartProvide extends BaseProvide{

  // 商品对象
  CommodityModel _commodityModel;
  // 购物地址
  AddressModel _addressModel;
  // 订单详情，商品购买对象
  List<CommodityModel> _buyCommodityModelList= new List();
  ///TODO 商品List数组对象(可能会废弃）
  List<CommodityModel> _commodityModelList = new List();
  ///TODO 按类别的商品List数组(即将使用）
  List<CommodityTypesModel> _commodityModelLists = new List();
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
  get addressModel => _addressModel;
  get buyCommodityModelList => _buyCommodityModelList;
  get count => _count;
  get commodityModelList => _commodityModelList;
  get commodityModelLists =>_commodityModelLists;
  get mode => _mode;
  get isSelected => _isSelected;

  // 缓存单个商品
  void setCommodityModel(CommodityModel model){
    _commodityModel = model;
    notifyListeners();
  }

  // 添加商品到订单详情中
  void addBuyCommodityModelList(CommodityModel model){
    _buyCommodityModelList = new List();
    _buyCommodityModelList.add(model);
    notifyListeners();
  }

  ///TODO 将商品添加到购物车list(即将废弃）
  void addCommodityModelList(CommodityModel model){
    _commodityModelList.add(model);
    notifyListeners();
  }

  ///TODO 将商品添加到购物车list(即将使用）
  void addCommodityModelLists(CommodityModel model){
    // 初始化数据结构
    if(_commodityModelLists.length==0){
      for(var i=0;i<=1;i++){
        CommodityTypesModel typesModel= new CommodityTypesModel();
        if(i==0){
          typesModel.types=CommodityCartTypes.exhibition.toString();
        }else{
          typesModel.types=CommodityCartTypes.commodity.toString();
        }
        _commodityModelLists.add(typesModel);
      }
      print(_commodityModelLists);
    }else{
      // 判断是否存在类别是否存在
      for(CommodityTypesModel item in _commodityModelLists){
        if(item.types==model.types){
          if(item.commodityModelList==null){
            item.commodityModelList = new List();
          }
          item.commodityModelList.add(model);
        }
      }
    }
//    _commodityModelLists.add(model);
    notifyListeners();
  }

  // 增加
  void increment({int idx, CommodityModel model}) {
    if(_mode=="single"){
      _count ++;
    } else {
      _commodityModelLists.forEach((item){
        if(item.types == model.types ){
          item.commodityModelList[idx].count ++;
        }
      });
    }
    notifyListeners();
  }

  // 减少
  void reduce({int idx,CommodityModel model}) {
    if(_mode=="single"){
      if(_count>0 ){
        _count --;
      }
    } else {
      _commodityModelLists.forEach((item){
        if(item.types == model.types && item.commodityModelList[idx].count>0){
          item.commodityModelList[idx].count --;
        }
      });
    }
    notifyListeners();
  }

  // 设置计数器模式, 默认为单计数
  void setMode({String mode="single"}){
    _mode = mode;
//    notifyListeners();
  }

  // 是否选中
  void setSelected(int idx,CommodityModel model,bool isSelected){
    bool isSel = true;
    _commodityModelLists.forEach((item){
      if(item.types == model.types ){
        item.commodityModelList[idx].isSelected = !isSelected;
      }

      // 判断是否全选

      isSel = item.commodityModelList.every((item)=>item.isSelected==true);
    });
    _isSelected = isSel;
//    _commodityModelList[idx].isSelected = !isSelected;
    notifyListeners();
  }

  // 所有选中的商品选中或取消
  void setValSelected(bool isSelected){
    _commodityModelLists.forEach((item){
      item.commodityModelList.forEach((items)=>items.isSelected=isSelected);
    });
    notifyListeners();
  }

  // 删除所选
  void onDelSelect(){
    _commodityModelList.removeWhere((item)=>item.isSelected==true);
    notifyListeners();
  }
  // 删除数量为0的商品
  void onDelCountToZero({int idx,CommodityModel model,String mode="single"}){
    if(mode=="single"){
      _commodityModelList.removeAt(idx);
    }else{
      _commodityModelLists.forEach((item){
        if(item.types == model.types ){
          item.commodityModelList.removeAt(idx);
        }
      });
    }
    notifyListeners();
  }
  // 初始化数量
  void initCount(){
    _count = 1;
    notifyListeners();
  }

  ///工厂模式
  factory CommodityAndCartProvide() => _getInstance();
  static CommodityAndCartProvide get instance => _getInstance();
  static CommodityAndCartProvide _instance;
  static CommodityAndCartProvide _getInstance() {
    if (_instance == null) {
      _instance = new CommodityAndCartProvide._internal();
    }
    return _instance;
  }
  CommodityAndCartProvide._internal() {
    print('MainProvide初始化');
    // 初始化
  }

}