

import 'package:innetsect/data/commodity_badges_model.dart';
import 'package:innetsect/data/commodity_brand_model.dart';
import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_skus_model.dart';
import 'package:innetsect/data/coupons/promotions.dart';

///商品详情模型
/// 商品类
class CommodityModels{
  // 产品id
  int prodID;
  int shopID;
  int prodType;
  String prodCode;
  // 是否预售
  bool presale;
  String presaleDesc;
  String unit;
  dynamic allowPointRate;
  //产品首页url
  String prodPic;
  //产品名称
  String prodName;
  //系列
  String series;
  //款号
  String styleNo;
  //性别款
  int gender;
  //状态
  String tags;
  //标签 =1已支付
  int status;
  // 价格
  dynamic defSalesPrice;
  // 现价
  String salesPriceRange;
  // 默认sku
  String defSkuCode;
  // sku--list
  List<CommoditySkusModel> skus;
  // feature
  List<CommodityFeatureModel> features;
  List<CommodityBadgesModel> badges;
  // brand
  CommodityBrandModel brandModel;
  int catCode;

  ///订单详情
  int itemID;
  int orderID;
  String skuCode;
  String skuName;
  String skuPic;
  // 订单备注
  String remark;
  // 订单编号
  String orderNo;
  // 发货状态，=3显示提货码
  int syncStatus;
  //支付时间
  String payDate;
  // 支付方式
  int payMode;
  // 下单时间
  String orderDate;
  // 原价
  dynamic originalPrice;
  //数量
  int quantity=0;
  dynamic salesPrice;
  dynamic amount;
  // orderType 0.现售  1.预售 2.中阶 3.高阶
  int orderType;

  /// 售后modal扩展
  // 退换策略,0：此商品不支持退换货,>0申请售后
  int rmaPolicy;
  // 是否申请售后，1已申请 0未申请
  bool rmaRequested;
  // 是否在可退换时间内，0：不可申请，1：可申请
  bool rmaInPeriod;

  //购物车使用
  String types;
  bool isChecked = false;
  bool isDisable = false;

  // 抢购商品扩展
  // 是否显示底部操作栏
  bool orderable = false;
  // 签到信息提示
  String promptingMessage;
  // 是否是抢购商品
  bool panicBuying = false;
  // 限购数量
  int panicBuyQtyPerAcct;
  // 服务器时间
  String panicCountdownTime;
  // 开始时间,开始>服务器时间才开始倒计时
  String panicBuyingStart;
  List<CouponsPromotionsModel> promotions;

  CommodityModels({
    this.prodID,
    this.shopID,
    this.presale,
    this.presaleDesc,
    this.unit,
    this.allowPointRate,
    this.prodPic,
    this.prodName,
    this.series,
    this.styleNo,
    this.gender,
    this.tags,
    this.status,
    this.defSalesPrice,
    this.salesPriceRange,
    this.defSkuCode,
    this.skus,
    this.features,
    this.amount,
    this.itemID,
    this.orderID,
    this.quantity,
    this.salesPrice,
    this.skuCode,
    this.skuName,
    this.skuPic,
    this.types,
    this.isChecked,
    this.prodType,
    this.prodCode,
    this.originalPrice,
    this.isDisable,
    this.payMode,
    this.payDate,
    this.syncStatus,
    this.orderNo,
    this.orderDate,
    this.remark,
    this.rmaPolicy,
    this.rmaRequested,
    this.rmaInPeriod,
    this.orderable,
    this.promptingMessage,
    this.panicBuying,
    this.panicBuyQtyPerAcct,
    this.panicCountdownTime,
    this.panicBuyingStart,
    this.orderType,
    this.badges,
    this.brandModel,
    this.catCode,
    this.promotions
  });

  factory CommodityModels.fromJson(Map<String, dynamic> json){
    return CommodityModels(
        prodID: json['prodID'],
        shopID: json['shopID'],
        presale: json['presale'],
        presaleDesc: json['presaleDesc'],
        unit: json['unit'],
        allowPointRate:json['allowPointRate'],
        prodPic: json['prodPic'],
        prodName: json['prodName'],
        series: json['series'],
        styleNo: json['styleNo'],
        gender: json['gender'],
        tags: json['tags'],
        status: json['status'],
        defSalesPrice: json['defSalesPrice'],
        salesPriceRange: json['salesPriceRange'],
        defSkuCode: json['defSkuCode'],
        skus: json['skus']!=null?CommoditySkusList.fromJson(json['skus']).list:json['skus'],
        features: json['features']!=null?CommodityFeatureList.fromJson(json['features']).list:json['features'],
        brandModel: json['brand']!=null?CommodityBrandModel.fromJson(json['brand']):json['brand'],
        catCode: json['catCode'],
        itemID: json['itemID'],
        orderID: json['orderID'],
        skuCode: json['skuCode'],
        skuName: json['skuName'],
        skuPic: json['skuPic'],
        quantity: json['quantity'],
        salesPrice: json['salesPrice'],
        amount: json['amount'],
        types: json['types'],
        isChecked: json['isChecked'],
        prodType: json['prodType'],
        prodCode: json['prodCode'],
        originalPrice: json['originalPrice'],
        isDisable: json['isDisable'],
        payMode: json['payMode'],
        payDate: json['payDate'],
        syncStatus: json['syncStatus'],
        orderNo: json['orderNo'],
        orderDate: json['orderDate'],
        remark: json['remark'],
        rmaPolicy: json['rmaPolicy'],
        rmaRequested: json['rmaRequested'],
        rmaInPeriod: json['rmaInPeriod'],
        orderable: json['orderable'],
        promptingMessage: json['promptingMessage'],
        panicBuying: json['panicBuying'],
        panicBuyQtyPerAcct: json['panicBuyQtyPerAcct'],
        panicCountdownTime: json['panicCountdownTime'],
        panicBuyingStart: json['panicBuyingStart'],
        orderType: json['orderType'],
        badges: json['badges']!=null?CommodityBadgesModelList.fromJson(json['badges']).list:json['badges'],
        promotions:json['promotions']!=null?CouponsPromotionsModelList.fromJson(json['promotions']).list:json['promotions']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'shopID': shopID,
    'presale': presale,
    'presaleDesc': presaleDesc,
    'prodPic': prodPic,
    'unit': unit,
    'allowPointRate':allowPointRate,
    'prodName': prodName,
    'series': series,
    'styleNo': styleNo,
    'gender': gender,
    'tags': tags,
    'status': status,
    'defSalesPrice': defSalesPrice,
    'salesPriceRange': salesPriceRange,
    'defSkuCode': defSkuCode,
    'skus': skus.map((item)=>item.toJson()),
    'features': features.map((item)=>item.toJson()),
    'types': types,
    'isChecked': isChecked,
    'prodType': prodType,
    'prodCode': prodCode,
    'originalPrice': originalPrice,
    'isDisable': isDisable,
    'payMode': payMode,
    'payDate': payDate,
    'syncStatus': syncStatus,
    'orderNo': orderNo,
    'orderDate': orderDate,
    'remark': remark,
    'rmaPolicy': rmaPolicy,
    'rmaRequested': rmaRequested,
    'rmaInPeriod': rmaInPeriod,
    'orderable': orderable,
    'promptingMessage': promptingMessage,
    'panicBuying': panicBuying,
    'panicBuyQtyPerAcct': panicBuyQtyPerAcct,
    'panicCountdownTime': panicCountdownTime,
    'panicBuyingStart': panicBuyingStart,
    'orderType': orderType
  };
}

class CommodityList{
  List<CommodityModels> list;

  CommodityList(this.list);

  factory CommodityList.fromJson(List json){
    return CommodityList(
        json.map(
                (item)=>CommodityModels.fromJson((item))
        ).toList()
    );
  }
}