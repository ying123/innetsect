import 'package:innetsect/data/commodity_models.dart';

///商品集合
class PromotionModel{
  String promotionType;
  int promotionID;
  // 图片
  String promotionPic;
  // 名称
  String promotionName;
  // 商城id
  int shopID;
  // 商品list对象
  List<CommodityModels> products;
  // 点击跳转筛选参数值code
  String promotionCode;

  PromotionModel({
    this.shopID,
    this.products,
    this.promotionID,
    this.promotionName,
    this.promotionPic,
    this.promotionType,
    this.promotionCode
  });

  factory PromotionModel.fromJson(Map<String,dynamic> json){
    return PromotionModel(
        shopID: json['shopID'],
        products: json['products']!=null?CommodityList.fromJson(json['products']).list:[],
        promotionID: json['promotionID'],
        promotionName: json['promotionName'],
        promotionPic: json['promotionPic'],
        promotionType: json['promotionType'],
        promotionCode: json['promotionCode']
    );
  }

  Map<String,dynamic> toJson()=>{
    'shopID': shopID,
    'products': products,
    'promotionID': promotionID,
    'promotionName': promotionName,
    'promotionPic': promotionPic,
    'promotionType': promotionType,
    'promotionCode': promotionCode
  };
}