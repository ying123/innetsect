class LuckySignModel{
  int shopID;
  int prodID;
  //图片
  String prodPic;
  // 名称
  String prodName;
  // 价格
  String salesPriceRange;
  // 购买件数
  int panicBuyQtyPerAcct;
  // 描述
  String panicBuyDesc;
  // 有效时间
  String expiryTime;

  LuckySignModel({
    this.prodID,
    this.panicBuyQtyPerAcct,
    this.shopID,
    this.prodName,
    this.expiryTime,
    this.salesPriceRange,
    this.prodPic,
    this.panicBuyDesc
  });

  factory LuckySignModel.fromJson(Map<String,dynamic> json){
    return LuckySignModel(
      prodID: json['prodID'],
      panicBuyDesc: json['panicBuyDesc'],
      panicBuyQtyPerAcct: json['panicBuyQtyPerAcct'],
      prodName: json['prodName'],
      prodPic: json['prodPic'],
      salesPriceRange: json['salesPriceRange'],
      shopID: json['shopID'],
      expiryTime: json['expiryTime']
    );
  }

}

class LuckySignModelList{
  List<LuckySignModel> list;
  LuckySignModelList(this.list);

  factory LuckySignModelList.fromJson(List list){
    return LuckySignModelList(
      list.map((item)=>LuckySignModel.fromJson(item)).toList()
    );
  }
}