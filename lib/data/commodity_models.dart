

import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_skus_model.dart';

/// 商品类
class CommodityModels{
  // 产品id
  int prodID;
  int shopID;
  // 是否预售
  bool presale;
  String unit;
  double allowPointRate;
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
  //退换策略
  int rmaPolicy;
  //状态
  String tags;
  //标签
  int status;
  // 价格
  double defSalesPrice;
  // 列表价格
  String salesPriceRange;
  // 默认sku
  String defSkuCode;
  // sku--list
  List<CommoditySkusModel> skus;
  // feature
  List<CommodityFeatureModel> features;

  ///订单详情
  int itemID;
  int orderID;
  String skuCode;
  String skuName;
  String skuPic;
  int quantity;
  double salesPrice;
  double amount;

  CommodityModels({
    this.prodID,
    this.shopID,
    this.presale,
    this.unit,
    this.allowPointRate,
    this.prodPic,
    this.prodName,
    this.series,
    this.styleNo,
    this.gender,
    this.rmaPolicy,
    this.tags,
    this.status,
    this.defSalesPrice,
    this.salesPriceRange,
    this.defSkuCode,
    this.skus,
    this.features
  });

  factory CommodityModels.fromJson(Map<String, dynamic> json){
    return CommodityModels(
        prodID: json['prodID'],
        shopID: json['shopID'],
        presale: json['presale'],
        unit: json['unit'],
        allowPointRate:json['allowPointRate'],
        prodPic: json['prodPic'],
        prodName: json['prodName'],
        series: json['series'],
        styleNo: json['styleNo'],
        gender: json['gender'],
        rmaPolicy: json['rmaPolicy'],
        tags: json['tags'],
        status: json['status'],
        defSalesPrice: json['defSalesPrice'],
        salesPriceRange: json['salesPriceRange'],
        defSkuCode: json['defSkuCode'],
        skus: json['skus']!=null?CommoditySkusList.fromJson(json['skus']).list:json['skus'],
        features: json['features']!=null?CommodityFeatureList.fromJson(json['features']).list:json['features']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'shopID': shopID,
    'presale': presale,
    'prodPic': prodPic,
    'unit': unit,
    'allowPointRate':allowPointRate,
    'prodName': prodName,
    'series': series,
    'styleNo': styleNo,
    'gender': gender,
    'rmaPolicy': rmaPolicy,
    'tags': tags,
    'status': status,
    'defSalesPrice': defSalesPrice,
    'salesPriceRange': salesPriceRange,
    'defSkuCode': defSkuCode,
    'skus': skus.map((item)=>item.toJson()),
    'features': features.map((item)=>item.toJson())
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