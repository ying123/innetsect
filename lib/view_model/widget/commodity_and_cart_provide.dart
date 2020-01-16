import 'package:flutter/cupertino.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/address_model.dart';
import 'package:innetsect/data/commodity_color_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_size_model.dart';
import 'package:innetsect/data/commodity_types_model.dart';
import 'package:innetsect/enum/commodity_cart_types.dart';
import 'package:innetsect/model/commodity_repository.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:rxdart/rxdart.dart';

/// 商品、购物车、计数器 provide
class CommodityAndCartProvide extends BaseProvide{

  // 购物地址
  AddressModel _addressModel;
  ///TODO 按类别的商品List数组(即将使用）
  List<CommodityTypesModel> _commodityTypesModelLists = new List();
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
  double _sum=0.00;

  get addressModel => _addressModel;
  get count => _count;
  List<CommodityTypesModel> get commodityTypesModelLists =>_commodityTypesModelLists;
  get mode => _mode;
  get isSelected => _isSelected;
  get sum=>_sum;
  set sum(double pay){
    _sum = pay;
    notifyListeners();
  }

  set count(int count){
    _count = count;
    notifyListeners();
  }

  /// 购物车请求后将商品添加到购物车list
  void addCarts(CommodityModels model){
    String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
    model.isDisable = false;
    int index = _commodityTypesModelLists.indexWhere((item)=>item.types==types);
    if(index>-1){
      CommodityTypesModel typesModel = _commodityTypesModelLists[index];
      typesModel.commodityModelList.add(model);
      typesModel.commodityModelList.sort((a,b){
        String pinyinA = PinyinHelper.getPinyinE(a.skuName);
        String pinyinB = PinyinHelper.getPinyinE(b.skuName);
        String tagA = pinyinA.substring(0, 1).toUpperCase();
        String tagB = pinyinB.substring(0, 1).toUpperCase();
        return tagA.compareTo(tagB);
      });
    }else{
      CommodityTypesModel typesModel = new CommodityTypesModel();
      typesModel.types = types;
      typesModel.commodityModelList = new List();
      typesModel.commodityModelList.add(model);
      _commodityTypesModelLists.add(typesModel);
    }

    _commodityTypesModelLists.sort((a,b){
      String pinyinA = PinyinHelper.getPinyinE(a.types.split('.')[1]);
      String pinyinB = PinyinHelper.getPinyinE(b.types.split('.')[1]);
      String tagA = pinyinA.substring(0, 1).toUpperCase();
      String tagB = pinyinB.substring(0, 1).toUpperCase();
      return tagA.compareTo(tagB);
    });

    notifyListeners();
  }

  // 初始化数量
  void setInitCount(){
    _count = 1;
    notifyListeners();
  }

  // 增加
  void increment({int idx, CommodityModels model}) {
    if(_mode=="single"){
      if(model.panicBuyQtyPerAcct!=null){
        if(_count<=model.panicBuyQtyPerAcct){
          _count ++;
        }
      }else{
        _count ++;
      }
    } else {
      String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
      _commodityTypesModelLists.forEach((item){
        if(item.types == types ){
          item.commodityModelList[idx].quantity ++;
          if(item.commodityModelList[idx].isChecked){
            _sum+=item.commodityModelList[idx].salesPrice;
          }

          this.reAndIcRequest(item,idx);
        }
      });
    }
    notifyListeners();
  }

  // 减少
  void reduce({int idx,CommodityModels model}) {
    if(_mode=="single"){
      if(_count>1 ){
        _count --;
      }
    } else {
      String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
      _commodityTypesModelLists.forEach((item){
        if(item.types == types ){
          if(item.commodityModelList[idx].quantity>0){
            item.commodityModelList[idx].quantity --;
            if(item.commodityModelList[idx].isChecked){
              _sum-=item.commodityModelList[idx].salesPrice;
            }
            if(item.commodityModelList[idx].quantity>0){
              this.reAndIcRequest(item,idx);
            }
          }
        }
      });
    }
    notifyListeners();
  }

  void reAndIcRequest(CommodityTypesModel item,int idx){
    this.reAndIcCarts(item.commodityModelList[idx]).doOnListen((){}).doOnCancel((){})
        .listen((res){

    },onError: (e){});
  }

  void setQuantity(CommodityModels models,int idx){
    String types = models.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
    _commodityTypesModelLists.forEach((item){
      if(item.types==types){
        item.commodityModelList[idx].quantity = 1;
      }
    });
    notifyListeners();
  }

  // 设置计数器模式, 默认为单计数
  void setMode({String mode="single"}){
    _mode = mode;
//    notifyListeners();
  }

  // 是否选中
  void setSelected(int idx,CommodityModels model,bool isSelected){
    bool isSel = true;
    String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
    _commodityTypesModelLists.forEach((item){
      if(item.types == types ){

        //已选中的和现在选的进行对比，如果预售相同则选中，否则不可选
        item.commodityModelList.forEach((res){
          if(res.presale==model.presale){
            res.isDisable = false;
          }else{
            res.isDisable = true;
          }
        });

        item.commodityModelList[idx].isChecked = !isSelected;

        _sum = 0;
        item.commodityModelList.where((vl)=>vl.isChecked==true).forEach((res){
          double price =  (res.salesPrice * res.quantity).toDouble();
          // 结算计算
          if(res.isChecked){
            _sum += price;
          }
        });

      }else{
        // 类型不同，只能选同一类型的商品
        item.commodityModelList.forEach((vl)=>vl.isChecked=false);
        int index = item.commodityModelList.indexWhere((vl)=>vl.prodID==model.prodID);
        if(index > -1){
          item.commodityModelList[index].isChecked = !isSelected;
        }
      }

      // 判断是否全选
      isSel = item.commodityModelList.every((item)=>item.isChecked==true);
    });
    _isSelected = isSel;
    notifyListeners();
  }

  // 所有选中的商品选中或取消
  void setValSelected(bool isSelected){
    for(CommodityTypesModel item in _commodityTypesModelLists){
      // 查找是否有选中项
      List<CommodityModels> modelsList = item.commodityModelList.where((res)=>res.isChecked==true).toList();
      if(modelsList.length==0){
        CommodityModels models = item.commodityModelList[0];
        this.selAllSum(item,models,isSelected);
        break;
      }else{
        CommodityModels models = modelsList[0];
        this.selAllSum(item,models,isSelected);
        break;
      }
    }
    if(!isSelected){
      _sum -=_sum;
    }
    notifyListeners();
  }

  void selAllSum(CommodityTypesModel item,CommodityModels models,bool isSelected){
    String types = models.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
    if(item.types == types){
      _sum = 0.00;
      item.commodityModelList.forEach((items){
        items.isChecked=isSelected;
        double price =  (items.salesPrice * items.quantity).toDouble();
        _sum +=price;
      });
    }
  }

  // 删除所选
  void onDelSelect(){
    _commodityTypesModelLists.forEach((item) {
      item.commodityModelList.removeWhere((res)=>res.isChecked==true);
    });

    notifyListeners();
  }

  // 删除数量为0的商品
  void onDelCountToZero({int idx,CommodityModels model,String mode="single"}){
    String types = model.shopID==37?CommodityCartTypes.commodity.toString(): CommodityCartTypes.exhibition.toString();
    if(mode=="single"){
//      _commodityModelList.removeAt(idx);
    }else{
      _commodityTypesModelLists.forEach((item){
        if(item.types == types ){
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

  final CommodityRepo _repo = CommodityRepo();

  /// 详情数据
  Observable addCartsRequest(CommodityModels model,BuildContext context) {
    return _repo.addCarts(model,context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 购物车列表
  Observable getMyCarts(BuildContext context) {
    return _repo.getMyCarts(context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 购物车加减
  Observable reAndIcCarts(CommodityModels model) {
    return _repo.reAndIcCarts(model)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
  /// 购物车删除
  Observable removeCarts(CommodityModels model) {
    return _repo.removeCarts(model)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 删除所选
  Observable removeCartsList(List<CommodityModels> model) {
    return _repo.removeCartsList(model)
        .doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }
}