
///促销活动
class CouponsPromotionsModel {
  String promotionCode;
  String promotionType;
  String promotionBrief;
  num shopID;


  CouponsPromotionsModel({
    this.promotionCode,
    this.promotionType,
    this.promotionBrief,
    this.shopID,
 
  
   
  });

  factory CouponsPromotionsModel.fromJson(Map<String, dynamic> json) {
    return CouponsPromotionsModel(
      promotionCode: json['promotionCode'],
      promotionType: json['promotionType'],
      promotionBrief: json['promotionBrief'],
      shopID: json['shopID'],
      
  
    );
  }

  Map<String, dynamic> toJson() => {
        'promotionCode': promotionCode,
        'promotionType': promotionType,
        'promotionBrief': promotionBrief,
        'shopID': shopID,
      };
}

class CouponsPromotionsModelList {
  List<CouponsPromotionsModel> list;

  CouponsPromotionsModelList(this.list);

  factory CouponsPromotionsModelList.fromJson(List json) {
    return CouponsPromotionsModelList(
        json.map((item) => CouponsPromotionsModel.fromJson((item))).toList());
  }
}
