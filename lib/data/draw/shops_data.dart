
import 'package:innetsect/data/draw/sku_data.dart';

class ShopsModel {
  num drawID;
  num shopID;
  String shopName;
  num drawMaxTimes;
  num limitMaxQty;
  num limitLocID;
  String addr;
  String remark;
  num drawStatus;
  num wonQty;
  List<SkusModel>skus;
  
  
 
 

  ShopsModel({
    this.drawID,
    this.shopID,
    this.shopName,
    this.drawMaxTimes,
    this.limitMaxQty,
    this.limitLocID,
    this.addr,
    this.remark,
    this.drawStatus,
    this.wonQty,
    this.skus
   
  });

  factory ShopsModel.fromJson(Map<String, dynamic> json) {
    return ShopsModel(
      drawID: json['drawID'],
      shopID: json['shopID'],
      shopName: json['shopName'],
      drawMaxTimes: json['drawMaxTimes'],
      limitMaxQty: json['limitMaxQty'],
      limitLocID: json['limitLocID'],
      addr: json['addr'],
      remark: json['remark'],
      drawStatus: json['drawStatus'],
      wonQty: json['wonQty'],
      skus: json['skus']!=null? SkusModelList.fromJson(json['skus']).list:null,
    
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'shopID': shopID,
        'drawMaxTimes': drawMaxTimes,
        'shopName': shopName,
        'limitMaxQty': limitMaxQty,
        'limitLocID': limitLocID,
        'addr': addr,
        'remark': remark,
        'drawStatus': drawStatus,
        'wonQty': wonQty,
      };
}

class ShopsModelList {
  List<ShopsModel> list;

  ShopsModelList(this.list);

  factory ShopsModelList.fromJson(List json) {
    return ShopsModelList(
        json.map((item) => ShopsModel.fromJson((item))).toList());
  }
}
