///品牌商城数据
class BrandMallModel {
  int exhibitProdID;
  int prodID;
  String prodCode;
  String prodPic;
  String prodName;
  int prodClass;
  int prodIdx;
  String brandName;
  String salesPriceRange;
  bool presale;
  String presaleDesc;
  int stockQty;
  int limitMaxQty;
  String unit;
  bool drawable;
  String drawMaxTimes;
  String drawThreshold;
  bool panicBuying;
  String panicBuyingStart;
  String panicBuyingEnd;
  String panicBuyingPreview;
  int panicBuyQtyPerAcct;
  String panicBuyDesc;
  int shopID;
  int exhibitionID;
  String locCode;
  String lastModified;
  String qrCode;
  List badges;

  BrandMallModel({
    this.exhibitProdID,
    this.prodID,
    this.prodCode,
    this.prodPic,
    this.prodName,
    this.prodClass,
    this.prodIdx,
    this.brandName,
    this.salesPriceRange,
    this.presale,
    this.presaleDesc,
    this.stockQty,
    this.limitMaxQty,
    this.unit,
    this.drawable,
    this.drawMaxTimes,
    this.drawThreshold,
    this.panicBuying,
    this.panicBuyingStart,
    this.panicBuyingEnd,
    this.panicBuyingPreview,
    this.panicBuyQtyPerAcct,
    this.panicBuyDesc,
    this.shopID,
    this.exhibitionID,
    this.locCode,
    this.lastModified,
    this.qrCode,
    this.badges,
  });

  factory BrandMallModel.fromJson(Map<String, dynamic> json) {
    return BrandMallModel(
      exhibitProdID: json['exhibitProdID'],
      prodID: json['prodID'],
      prodCode: json['prodCode'],
      prodPic: json['prodPic'],
      prodName: json['prodName'],
      prodClass: json['prodClass'],
      prodIdx: json['prodIdx'],
      brandName: json['brandName'],
      salesPriceRange: json['salesPriceRange'],
      presale: json['presale'],
      presaleDesc: json['presaleDesc'],
      stockQty: json['stockQty'],
      limitMaxQty: json['limitMaxQty'],
      unit: json['unit'],
      drawable: json['drawable'],
      drawMaxTimes: json['drawMaxTimes'],
      drawThreshold: json['drawThreshold'],
      panicBuying: json['panicBuying'],
      panicBuyingStart: json['panicBuyingStart'],
      panicBuyingEnd: json['panicBuyingEnd'],
      panicBuyingPreview: json['panicBuyingPreview'],
      panicBuyQtyPerAcct: json['panicBuyQtyPerAcct'],
      panicBuyDesc: json['panicBuyDesc'],
      shopID: json['shopID'],
      exhibitionID: json['exhibitionID'],
      locCode: json['locCode'],
      lastModified: json['lastModified'],
      qrCode: json['qrCode'],
      badges: json['badges'],
    );
  }

  Map<String, dynamic> toJson() => {
        'exhibitionID': exhibitionID,
        'prodID': prodID,
        'prodCode': prodCode,
        'prodPic': prodPic,
        'prodName': prodName,
        'prodClass': prodClass,
        'prodIdx': prodIdx,
        'brandName': brandName,
        'salesPriceRange': salesPriceRange,
        'presale': presale,
        'presaleDesc': presaleDesc,
        'stockQty': stockQty,
        'limitMaxQty': limitMaxQty,
        'unit': unit,
        'drawable': drawable,
        'drawMaxTimes': drawMaxTimes,
        'drawThreshold': drawThreshold,
        'panicBuying': panicBuying,
        'panicBuyingStart': panicBuyingStart,
        'panicBuyingEnd': panicBuyingEnd,
        'panicBuyingPreview': panicBuyingPreview,
        'panicBuyQtyPerAcct': panicBuyQtyPerAcct,
        'panicBuyDesc': panicBuyDesc,
        'shopID': shopID,
        'exhibitionID': exhibitionID,
        'locCode': locCode,
        'lastModified': lastModified,
        'qrCode': qrCode,
        'badges': badges,
      };
}

class BrandMallModelList {
  List<BrandMallModel> list;

  BrandMallModelList(this.list);

  factory BrandMallModelList.fromJson(List json) {
    return BrandMallModelList(
        json.map((item) => BrandMallModel.fromJson((item))).toList());
  }
}
