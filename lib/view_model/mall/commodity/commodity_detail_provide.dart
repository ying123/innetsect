
import 'package:flutter/material.dart';
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/model/commodity_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommodityDetailProvide extends BaseProvide {

  /// 商品id
  int _prodId;
  /// 商品详情
  CommodityModels _commodityModels;
  /// 默认选中的sku
  CommoditySkusModel _skusModel;
  /// 过滤的sku
  List<CommoditySkusModel> _skusList=[];
  /// 数组选中下标
  int _index=0;
  /// 订单号
  int _orderId;
  /// 支付方式list
  List<Map<String,dynamic>> _payList = [
    {"payMode":2,"name":"支付宝","isSelected":true},
    {"payMode":1,"name":"微信","isSelected":false},
  ];
  /// 支付方式
  int _payMode;
  /// 是否立即购买
  bool _isBuy = false;
  /// 支付状态
  bool _resultStatus = false;
  /// 售后按钮显示
  bool _afterBtn = false;
  int _types;
  // 跳转的页面
  String _pages;
  String get pages=>_pages;
  set pages(String pages){
    _pages = pages;
    notifyListeners();
  }
  int get types=>_types;
  set types(int types){
    _types = types;
    notifyListeners();
  }

  CommodityModels get commodityModels => _commodityModels;

  CommoditySkusModel get skusModel =>_skusModel;

  List<CommoditySkusModel> get skusList => _skusList;
  List<Map<String,dynamic>> get payList => _payList;

  int get index=>_index;
  int get orderId=>_orderId;
  bool get isBuy=>_isBuy;
  bool get resultStatus=>_resultStatus;
  int get prodId => _prodId;
  int get payMode => _payMode;
  bool get afterBtn => _afterBtn;

  // 变更支付方式
  void onChangePayMode(int index){
    _payList.forEach((item)=>item['isSelected']=false);
    _payList[index]['isSelected']=true;
    _payMode = _payList[index]['payMode'];
    setPayModel(_payList[index]['payMode']);
    notifyListeners();
  }
  // 默认支付方式
  void defaultPayMode(){
    _payList.forEach((item)=>item['isSelected']=false);
    _payList[0]['isSelected']=true;
    _payMode = _payList[0]['payMode'];
    setPayModel(_payList[0]['payMode']);
    notifyListeners();
  }

  set payMode(int payMode){
    _payMode = payMode;
    notifyListeners();
  }

  set prodId(int prodId){
    _prodId = prodId;
    notifyListeners();
  }

  set isBuy(bool flag){
    _isBuy = flag;
    notifyListeners();
  }

  set resultStatus(bool success){
    _resultStatus = success;
    notifyListeners();
  }

  set afterBtn(bool flag){
    _afterBtn = flag;
    notifyListeners();
  }

  // 设置支付类型
  void setPayModel(int payModel){
    if(_commodityModels!=null){
      _commodityModels.payMode = payModel;
    }
    notifyListeners();
  }

  // 清除商品详情
  void clearCommodityModels(){
    if(_commodityModels!=null && _skusModel!=null){
      _commodityModels = null;
      _skusModel = null;
    }
    notifyListeners();
  }

  // 商品详情
  void setCommodityModels(CommodityModels models){
    _commodityModels = models;
    // 默认sku设置
//    models.defSkuCode
    List<CommoditySkusModel> skuModel = models.skus.where((item)=>item.skuCode == models.defSkuCode).toList();
    if(skuModel.length>0){
      skuModel.asMap().keys.map((key){
        bool flag = false;
        if(key==0) flag=true;
        skuModel[key].isSelected=flag;
        _index = key;
      });
      skuModel[0].isSelected = true;
      _skusModel = skuModel[0];
    }
    notifyListeners();
  }

  // 初始化数据
  void setInitData(){
    if(_orderId!=null) _orderId = null;
    if(_skusList.length>0)_skusList.clear();
    // 获取选中size
    String code="";
    if(_skusModel==null){
      //如果没有默认sku，默认拿第一个sku为默认sku
      _skusModel = _commodityModels.skus[0];
      _commodityModels.defSkuCode = _commodityModels.skus[0].skuCode;
    }
    _skusModel.features.forEach((item){
      if(item.featureGroup=="尺码"){
        code = item.featureCode;
      }
    });
    // 通过size过滤对象
    _commodityModels.skus.forEach((item){
      item.features.forEach((feaItem){
        if(feaItem.featureCode == code){
          _skusList.add(item);
        }
      });
      //默认选中赋值
      if(item.skuCode==_commodityModels.defSkuCode){
        _commodityModels.skuCode = item.skuCode;
        _commodityModels.salesPrice = item.salesPrice;
        _commodityModels.skuName = item.skuName;
        _commodityModels.skuPic = item.skuPic;
        _commodityModels.originalPrice = item.originalPrice;
      }
    });

    notifyListeners();
  }

  // 设置选中的sku，动态变化
  void setSelectSku(CommodityFeatureModel featureModel,int count){
    //
    _skusList.clear();
    _commodityModels.skus.forEach((item){
      item.features.forEach((feaItem){
        // 是否相同的特征code
        if(featureModel.featureCode==feaItem.featureCode){
          _skusList.add(item);
        }
      });
    });

    // 选中的sku特征值
    if(_skusList.length>0){
      _skusModel.features.forEach((feaItem){
        if(feaItem.featureGroup=="颜色"){
          _skusList.forEach((item){
            bool flag = false;
            item.features.forEach((feItem){
              if(feItem.featureGroup==feaItem.featureGroup
               && feItem.featureCode == feaItem.featureCode){
                flag = true;
              }
            });
            if(flag){
              _skusModel = item;
              _commodityModels.skuCode = item.skuCode;
              _commodityModels.salesPrice = item.salesPrice;
              _commodityModels.skuName = item.skuName;
              _commodityModels.skuPic = item.skuPic;
              _commodityModels.originalPrice = item.originalPrice;
              _commodityModels.quantity = count;
            }
          });
        }
      });

    }
    notifyListeners();
  }

  // 选择颜色
  void setSelectColor(CommoditySkusModel models,int count){
    _skusModel = models;
    _commodityModels.skuCode = models.skuCode;
    _commodityModels.salesPrice = models.salesPrice;
    _commodityModels.skuName = models.skuName;
    _commodityModels.skuPic = models.skuPic;
    _commodityModels.originalPrice = models.originalPrice;
    _commodityModels.quantity = count;
    notifyListeners();
  }

  // 设置订单号
  void setOrderId(int orderId){
    _orderId = orderId;
    notifyListeners();
  }

  final CommodityRepo _repo = CommodityRepo();

  /// 详情数据
  Observable detailData({int types,int prodId,BuildContext context}) {
    return _repo
        .detailData(types, prodId,context:context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 创建订单
  Observable createShopping(List json,BuildContext context) {
    return _repo
        .createShopping(json, context)
        .doOnData((result) {
      print(result);
    })
        .doOnError((e, stacktrace) {
          print(e);
    })
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 提交订单
  Observable submitShopping(int addrID,{BuildContext context}) {
    print(addrID);
    return _repo.submitShopping(addrID,context:context)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 支付订单
  Observable payShopping() {
    return _repo.payShopping(_orderId,payMode)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 商品推荐
  Observable recommendedListData(int pageNo,int types,int prodID){
    return _repo.recommendedListData(pageNo, types, prodID).doOnData((res){
    }).doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 支付后商品详情
  Observable getOrderPayDetails({@required int orderID,int payMode,int queryStatus}){
    return _repo.getOrderPayDetails(orderID:orderID, payMode:payMode, queryStatus:queryStatus).doOnData((res){
    }).doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 详情底部webview
  Future getDetailHtml(){
    return _repo.getDetailHtml(this.prodId);
  }

  /// 提货码
  Observable ladingQrCode (int orderID){
    return _repo.ladingQrCode(orderID).doOnData((result){})
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  ///工厂模式
  factory CommodityDetailProvide() => _getInstance();
  static CommodityDetailProvide get instance => _getInstance();
  static CommodityDetailProvide _instance;
  static CommodityDetailProvide _getInstance() {
    if (_instance == null) {
      _instance = new CommodityDetailProvide._internal();
    }
    return _instance;
  }
  CommodityDetailProvide._internal() {
    print('CommodityDetailProvide init');
    // 初始化
  }
}