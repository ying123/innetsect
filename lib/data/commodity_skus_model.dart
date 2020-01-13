import 'package:innetsect/data/commodity_feature_model.dart';
import 'package:innetsect/data/commodity_pic_model.dart';

class CommoditySkusModel{
  int prodID;
  String skuCode;
  String skuName;
  String skuPic;
  double costPrice;
  double originalPrice;
  double salesPrice;
  bool kitting;
  int status;
  List<CommodityPicModel> pics;
  List<CommodityFeatureModel> features;
  bool isSelected = false;
  // 库存
  int qtyInHand;
  // 特征组 -- 重构
  String featureGroup;
  // 特征码 -- 重构
  String featureCode;
  // 特征值 -- 重构
  String featureValue;

  CommoditySkusModel({
    this.prodID,
    this.skuCode,
    this.skuName,
    this.skuPic,
    this.costPrice,
    this.originalPrice,
    this.salesPrice,
    this.kitting,
    this.status,
    this.pics,
    this.features,
    this.isSelected,
    this.qtyInHand,
    this.featureGroup,
    this.featureCode,
    this.featureValue
  });

  factory CommoditySkusModel.fromJson(Map<String,dynamic> json){
    return CommoditySkusModel(
        prodID: json['prodID'],
        skuCode: json['skuCode'],
        skuName: json['skuName'],
        skuPic: json['skuPic'],
        costPrice: json['costPrice'],
        originalPrice: json['originalPrice'],
        salesPrice: json['salesPrice'],
        kitting: json['kitting'],
        status: json['status'],
        pics: json['pics']!=null?CommodityPicList.fromJson(json['pics']).list:[],
        features: json['features']!=null?CommodityFeatureList.fromJson(json['features']).list:[],
        isSelected: json['isSelected'],
        qtyInHand: json['qtyInHand'],
        featureGroup: json['featureGroup'],
        featureCode: json['featureCode'],
        featureValue: json['featureValue']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'skuCode': skuCode,
    'skuName': skuName,
    'skuPic': skuPic,
    'costPrice': costPrice,
    'originalPrice': originalPrice,
    'salesPrice': salesPrice,
    'kitting': kitting,
    'status': status,
    'pics': pics.map((item)=>item.toJson()),
    'features': features.map((item)=>item.toJson()),
    'isSelected': isSelected,
    'qtyInHand': qtyInHand,
    'featureGroup': featureGroup,
    'featureCode': featureCode,
    'featureValue': featureValue
  };

}

class CommoditySkusList{
  List<CommoditySkusModel> list;

  CommoditySkusList(this.list);

  factory CommoditySkusList.fromJson(List json){
    return CommoditySkusList(
        json.map(
                (item)=>CommoditySkusModel.fromJson((item))
        ).toList()
    );
  }
}