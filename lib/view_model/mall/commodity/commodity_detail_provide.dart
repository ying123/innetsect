
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
  /// 过滤的sku（废弃）
  List<CommoditySkusModel> _skusList=[];
  /// 存储sku颜色特征
  List<CommoditySkusModel> _colorSkuList = [];
  /// 存储sku尺寸特征
  List<CommoditySkusModel> _sizeSkuList = [];
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

  /// 废弃
  List<CommoditySkusModel> get skusList => _skusList;
  /// 重构
  List<CommoditySkusModel> get colorSkuList => _colorSkuList;
  List<CommoditySkusModel> get sizeSkuList => _sizeSkuList;

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
    /// TODO 没有默认sku
//    List<CommoditySkusModel> skuModel = models.skus.where((item)=>item.skuCode == models.defSkuCode).toList();
//    if(skuModel.length>0){
//      skuModel.asMap().keys.map((key){
//        bool flag = false;
//        if(key==0) flag=true;
//        skuModel[key].isSelected=flag;
//        _index = key;
//      });
//      skuModel[0].isSelected = true;
//      _skusModel = skuModel[0];
//    }
    notifyListeners();
  }

  ///**TODO初始化数据(废弃）
//  void setInitData(){
//    if(_orderId!=null) _orderId = null;
//    if(_skusList.length>0)_skusList.clear();
//    // 获取选中size
//    String code="";
//    if(_skusModel==null){
//      //如果没有默认sku，默认拿第一个sku为默认sku
//      _skusModel = _commodityModels.skus[0];
//      _commodityModels.defSkuCode = _commodityModels.skus[0].skuCode;
//    }
//    _skusModel.features.forEach((item){
//      if(item.featureGroup=="尺码"){
//        code = item.featureCode;
//      }
//    });
//    // 通过size过滤对象
//    _commodityModels.skus.forEach((item){
//      item.features.forEach((feaItem){
//        if(feaItem.featureCode == code){
//          _skusList.add(item);
//        }
//      });
//      //默认选中赋值
//      if(item.skuCode==_commodityModels.defSkuCode){
//        _commodityModels.skuCode = item.skuCode;
//        _commodityModels.salesPrice = item.salesPrice;
//        _commodityModels.skuName = item.skuName;
//        _commodityModels.skuPic = item.skuPic;
//        _commodityModels.originalPrice = item.originalPrice;
//      }
//    });
//
//    notifyListeners();
//  }

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

  /// TODO 选择颜色(废弃)
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

  /// TODO 业务需求改动，sku业务逻辑重构
  /// TODO 重构初始化
  void setInitData() {
    if(_orderId!=null) _orderId = null;
    if(_colorSkuList.length>0)_colorSkuList.clear();
    if(_sizeSkuList.length>0)_sizeSkuList.clear();
    /// 如果颜色和尺寸是一个，则默认选中
    if(_commodityModels.skus.length==1){
      _commodityModels.skuName = _commodityModels.skus[0].skuName;
      _commodityModels.skuCode = _commodityModels.skus[0].skuCode;
      _commodityModels.skuPic = _commodityModels.skus[0].skuPic;
      _commodityModels.salesPrice = _commodityModels.skus[0].salesPrice;
      _commodityModels.originalPrice = _commodityModels.skus[0].originalPrice;
      _commodityModels.quantity = 1;
      if(_skusModel==null){
        _skusModel = new CommoditySkusModel();
        _skusModel.skuName = _commodityModels.skus[0].skuName;
        _skusModel.skuCode = _commodityModels.skus[0].skuCode;
        _skusModel.skuPic = _commodityModels.skus[0].skuPic;
        _skusModel.pics = _commodityModels.skus[0].pics;
        _skusModel.features = _commodityModels.skus[0].features;
        _skusModel.qtyInHand = _commodityModels.skus[0].qtyInHand;
      }
    }else{
      /// 如果是多个的赋值给颜色和尺码sku-list
      //循环特征list
//    print(_commodityModels.features);
      _commodityModels.features.forEach((CommodityFeatureModel featuresItem){
//      // 赋值
        CommoditySkusModel skusModels = CommoditySkusModel();
        skusModels.featureCode = featuresItem.featureCode;
        skusModels.featureGroup = featuresItem.featureGroup;
        skusModels.featureValue = featuresItem.featureValue;
        skusModels.qtyInHand = featuresItem.qtyInHand;
        for(var i=0;i<_commodityModels.skus.length;i++){
          CommoditySkusModel items = _commodityModels.skus[i];
          // 匹配颜色sku
          if(featuresItem.featureGroup == '颜色'
              &&featuresItem.featureCode == items.features[1].featureCode){
            skusModels.skuName = items.skuName;
            setSkuColorAndSize(skusModels,items);
            break;
          }
          // 匹配尺码
          if(featuresItem.featureGroup == '尺码'
              &&featuresItem.featureCode == items.features[0].featureCode){
            skusModels.skuName = items.skuName;
            setSkuColorAndSize(skusModels,items);
            break;
          }
        }
        if(featuresItem.featureGroup == '颜色'){
          _colorSkuList.add(skusModels);
        }
        if(featuresItem.featureGroup == '尺码'){
          _sizeSkuList.add(skusModels);
        }
      });
    }
    notifyListeners();
  }
  void setSkuColorAndSize(CommoditySkusModel _skusModels,CommoditySkusModel _skus){
    _skusModels.prodID = _skus.prodID;
    _skusModels.skuCode = _skus.skuCode;
    _skusModels.salesPrice = _skus.salesPrice;
    _skusModels.skuPic = _skus.skuPic;
    _skusModels.originalPrice = _skus.originalPrice;
  }
  /// TODO 选择颜色（重构）
  void onSelectColor(CommoditySkusModel models,int count){
    // 选中颜色
    _colorSkuList.forEach((item)=>{
      if(item.featureCode != models.featureCode){
        item.isSelected = false
      }
    });
    models.isSelected = !models.isSelected;
    _commodityModels.salesPrice = models.salesPrice;
    _commodityModels.originalPrice = models.originalPrice;
    _commodityModels.quantity = count;
    if(_skusModel==null ||_skusModel.features==null|| _skusModel.features.length == 0 ) {
      if(_skusModel==null) _skusModel = CommoditySkusModel();
      if(_skusModel.features==null) _skusModel.features = List<CommodityFeatureModel>();
      _skusModel.qtyInHand = models.qtyInHand;
      CommodityFeatureModel featureModelsTwo = CommodityFeatureModel();
      featureModelsTwo.featureGroup = "尺码";
      _skusModel.features..add(featureModelsTwo);
      CommodityFeatureModel featureModels = CommodityFeatureModel();
      featureModels.featureGroup = "颜色";
      _skusModel.features..add(featureModels);
    }
    if(_skusModel.features!=null&&_skusModel.features.length>0){
      int index = _skusModel.features.indexWhere((items)=>items.featureGroup=='颜色');
      if(index>-1){
        CommodityFeatureModel model = CommodityFeatureModel();
        if(_skusModel.features[index].featureValue==null){
          model.prodID = models.prodID;
          model.featureGroup = models.featureGroup;
          model.featureCode = models.featureCode;
          model.featureValue = models.featureValue;
          model.qtyInHand = models.qtyInHand;
        }
        _skusModel.features.insert(index, model);
        _skusModel.features.removeAt(index+1);
      }
    }
    // 根据选中的颜色和尺寸查询sku
    _commodityModels.skus.forEach((item){
      if(item.features[0].featureCode == _skusModel.features[0].featureCode
          && item.features[1].featureCode == _skusModel.features[1].featureCode){
        _commodityModels.skuName = item.skuName;
        _commodityModels.skuCode = item.skuCode;
        _commodityModels.skuPic = models.skuPic;

        _skusModel.prodID = item.prodID;
        _skusModel.skuName = item.skuName;
        _skusModel.skuCode = item.skuCode;
        _skusModel.skuPic = item.skuPic;
        _skusModel.qtyInHand = item.qtyInHand;
      }
    });
    notifyListeners();
  }

  /// TODO 选择尺寸（重构）
  void onSizeChange(CommoditySkusModel models,int count){
//    _commodityModels.skuCode = models.skuCode;
    // 选中尺码
    _sizeSkuList.forEach((item)=>{
      if(item.featureCode != models.featureCode){
        item.isSelected = false
      }
    });
    models.isSelected = !models.isSelected;
    _commodityModels.salesPrice = models.salesPrice;
    _commodityModels.originalPrice = models.originalPrice;
    _commodityModels.quantity = count;

    if(_skusModel==null || _skusModel.features==null|| _skusModel.features.length == 0 ) {
      if(_skusModel==null) _skusModel = CommoditySkusModel();
      if(_skusModel.features==null) _skusModel.features = List<CommodityFeatureModel>();
      _skusModel.qtyInHand = models.qtyInHand;
      CommodityFeatureModel featureModelsTwo = CommodityFeatureModel();
      featureModelsTwo.featureGroup = "尺码";
      _skusModel.features..add(featureModelsTwo);
      CommodityFeatureModel featureModels = CommodityFeatureModel();
      featureModels.featureGroup = "颜色";
      _skusModel.features..add(featureModels);
    }
    if(_skusModel.features!=null&&_skusModel.features.length>0){
      int index = _skusModel.features.indexWhere((items)=>items.featureGroup=='尺码');
      if(index>-1){
        CommodityFeatureModel model = CommodityFeatureModel();
        if(_skusModel.features[index].featureValue==null){
          model.prodID = models.prodID;
          model.featureGroup = models.featureGroup;
          model.featureCode = models.featureCode;
          model.featureValue = models.featureValue;
          model.qtyInHand = models.qtyInHand;
        }
        _skusModel.features.insert(index, model);
        _skusModel.features.removeAt(index+1);
      }
    }
    // 根据选中的颜色和尺寸查询sku
    _commodityModels.skus.forEach((item){
      if(item.features[0].featureCode == _skusModel.features[0].featureCode
        && item.features[1].featureCode == _skusModel.features[1].featureCode){
        _commodityModels.skuName = item.skuName;
        _commodityModels.skuCode = item.skuCode;
        _commodityModels.skuPic = models.skuPic;
        _skusModel.prodID = item.prodID;
        _skusModel.skuName = item.skuName;
        _skusModel.skuCode = item.skuCode;
        _skusModel.skuPic = item.skuPic;
        _skusModel.qtyInHand = item.qtyInHand;
      }
    });
    notifyListeners();
  }

  void featuresClear(){
    _skusModel.features.clear();
    notifyListeners();
  }

  final CommodityRepo _repo = CommodityRepo();
  /// 颜色尺码请求
  Observable colorAndSizeData({int types,int prodId,String featureGroup,String featureCode}){
    return _repo.colorAndSizeData(types:types, prodId:prodId,featureGroup:featureGroup,featureCode:featureCode)
        .doOnData((result) {
    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

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