
import 'package:innetsect/base/base.dart';
import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_models.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/model/commodity_repository.dart';
import 'package:rxdart/rxdart.dart';

class CommodityDetailProvide extends BaseProvide {

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
  /// 支付类型
  int _payTypes;

  get commodityModels => _commodityModels;

  get skusModel =>_skusModel;

  List<CommoditySkusModel> get skusList => _skusList;
  get index=>_index;
  get orderId=>_orderId;
  get payTypes=>_payTypes;

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
    if(_skusList.length>0)_skusList.clear();
    // 获取选中size
    String code="";
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
    });

    notifyListeners();
  }

  // 设置选中的sku，动态变化
  void setSelectSku(CommodityFeatureModel featureModel){
    //
    _skusList.clear();
    _commodityModels.skus.forEach((item){
      item.features.forEach((feaItem){
        // 是否相同的特征code
        if(featureModel.featureCode==feaItem.featureCode){
          _skusList.add(item);
          // 判断选中sku是否存在
//          if(_index!=null&&_index > keys){
            _skusModel = item;
            _skusModel.features = item.features;
//          }else{
//            _skusModel = _commodityModels.skus[keys];
//            _index = keys;
//          }
        }
      });
    });
    notifyListeners();
  }

  // 选择颜色
  void setSelectColor(CommoditySkusModel models){
    List<CommodityFeatureModel> list = _skusModel.features;
    models.features = list;
    _skusModel = models;
    _commodityModels.skus.asMap().keys.forEach((keys){
      if(models.skuCode==_commodityModels.skus[keys].skuCode){
        // 判断选中sku是否存在
        if(_index!=null&&_index>keys){
          _index = 0;
        }else{
          _index = keys;
        }
      }
    });
    notifyListeners();
  }

  // 设置订单号
  void setOrderId(int orderId){
    _orderId = orderId;
    notifyListeners();
  }

  // 设置支付类型
  void setPayTypes(int payTypes){
    _payTypes = payTypes;
    notifyListeners();
  }

  final CommodityRepo _repo = CommodityRepo();

  /// 详情数据
  Observable detailData(int prodId) {
    return _repo
        .detailData(37, prodId)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 创建订单
  Observable createShopping(CommodityModels models,
      CommoditySkusModel skuModel,int counts) {
    return _repo
        .createShopping(models,skuModel,counts)
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 提交订单
  Observable submitShopping() {
    return _repo.submitShopping()
        .doOnData((result) {

    })
        .doOnError((e, stacktrace) {})
        .doOnListen(() {})
        .doOnDone(() {});
  }

  /// 支付订单
  Observable payShopping() {
    return _repo.payShopping(_orderId,_payTypes)
        .doOnData((result) {

    })
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