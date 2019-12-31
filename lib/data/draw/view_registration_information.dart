import 'package:innetsect/data/draw/drawee_data.dart';
import 'package:innetsect/data/draw/shop_product_data.dart';

///查看我的抽签登记信息
class ViewRegistrationInformationModel {
  //DraweeModel
  DraweeModel drawee;
  //ShopProductModel
  ShopProductModel shopProduct;
  bool usable;
  bool expired;
 
  
 
 

  ViewRegistrationInformationModel({
    this.drawee,
    this.shopProduct,
    this.usable,
    this.expired,
   
    
   
  });

  factory ViewRegistrationInformationModel.fromJson(Map<String, dynamic> json) {
    return ViewRegistrationInformationModel(
      drawee: json['drawee']!=null? DraweeModel.fromJson(json['drawee']):null,
      shopProduct: json['shopProduct']!=null? ShopProductModel.fromJson(json['shopProduct']):null,
     expired:json['expired'],
     usable:json['usable'],
    
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawee': drawee,
       'shopProduct': shopProduct,
       'usable': usable,
       'expired': expired,
       
      };
}

class ViewRegistrationInformationModelList {
  List<ViewRegistrationInformationModel> list;

  ViewRegistrationInformationModelList(this.list);

  factory ViewRegistrationInformationModelList.fromJson(List json) {
    return ViewRegistrationInformationModelList(
        json.map((item) => ViewRegistrationInformationModel.fromJson((item))).toList());
  }
}
