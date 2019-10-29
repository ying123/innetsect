import 'package:innetsect/data/commodity_model.dart';
import 'package:innetsect/enum/commodity_cart_types.dart';

class CommodityTypesModel{

  String types;
  List<CommodityModel> commodityModelList;

  CommodityTypesModel({
    this.types,
    this.commodityModelList
  });

  factory CommodityTypesModel.formJson(Map<String,dynamic> json) {
    return CommodityTypesModel(
      types: json['types'],
      commodityModelList: json['commodityModelList']
    );
  }


  Map<String, dynamic> toJson()=> {
    'types': types,
    'commodityModelList': commodityModelList
  };

  String getTypes(String types){
    String title = "";
    if(types == CommodityCartTypes.exhibition.toString()) return title="展会";
    if(types == CommodityCartTypes.commodity.toString()) return title="商城";
    return title;
  }
}