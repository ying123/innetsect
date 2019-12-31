
class ShopProductModel {
  num drawID;
  num shopID;
  String startTime;
  String endTime;
  String registerPrompt;
  String drawRule;
  String shopName;
  String addr;
  num limitLocID;
  num drawAwardType;
  num limitMaxQty;
  num prodID;
  String prodPic;
  String prodName;
  String prodSizeRange;
  num prodPrice;
  num drawStatus;
  String startBuyingTime;
  String expiryTime;
  List winnerMobiles;
  bool registered;
  bool locatedIn;
  num status;
  bool onlineAwardType;
  
 
 

  ShopProductModel({
    this.drawID,
    this.shopID,
    this.startTime,
    this.endTime,
    this.registerPrompt,
    this.drawRule,
    this.shopName,
    this.addr,
    this.limitLocID,
    this.drawAwardType,
    this.limitMaxQty,
    this.prodID,
    this.prodPic,
    this.prodName,
    this.prodSizeRange,
    this.prodPrice,
    this.drawStatus,
    this.startBuyingTime,
    this.expiryTime,
    this.winnerMobiles,
    this.registered,
    this.locatedIn,
    this.status,
    this.onlineAwardType,
    
   
  });

  factory ShopProductModel.fromJson(Map<String, dynamic> json) {
    return ShopProductModel(
      drawID: json['drawID'],
      shopID: json['shopID'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      registerPrompt: json['registerPrompt'],
      drawRule: json['drawRule'],
      shopName: json['shopName'],
      addr: json['addr'],
      limitLocID: json['limitLocID'],
      drawAwardType: json['drawAwardType'],
      limitMaxQty: json['limitMaxQty'],
      prodID: json['prodID'],
      prodPic: json['prodPic'],
      prodName: json['prodName'],
      prodSizeRange: json['prodSizeRange'],
      prodPrice: json['prodPrice'],
      drawStatus: json['drawStatus'],
      startBuyingTime: json['startBuyingTime'],
      expiryTime: json['expiryTime'],
      winnerMobiles: json['winnerMobiles'],
      registered: json['registered'],
      locatedIn: json['locatedIn'],
      status: json['status'],
      onlineAwardType: json['onlineAwardType'],
    
   
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'shopID': shopID,
        'startTime': startTime,
        'endTime': endTime,
        'registerPrompt': registerPrompt,
        'drawRule': drawRule,
        'shopName': shopName,
        'addr': addr,
        'limitLocID': limitLocID,
        'drawAwardType': drawAwardType,
        'limitMaxQty': limitMaxQty,
        'prodID': prodID,
        'prodPic': prodPic,
        'prodName': prodName,
        'prodSizeRange': prodSizeRange,
        'prodPrice': prodPrice,
        'drawStatus': drawStatus,
        'startBuyingTime': startBuyingTime,
        'expiryTime': expiryTime,
        'winnerMobiles': winnerMobiles,
        'registered': registered,
        'locatedIn': locatedIn,
        'status': status,
        'onlineAwardType': onlineAwardType,
     
      };
}

class ShopProductModelList {
  List<ShopProductModel> list;

  ShopProductModelList(this.list);

  factory ShopProductModelList.fromJson(List json) {
    return ShopProductModelList(
        json.map((item) => ShopProductModel.fromJson((item))).toList());
  }
}
