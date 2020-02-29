
///商品优惠卷列表
class ListOfCouponsModel {
  int csID;
  String csPic;
  int csType;
  String csName;
  int shopID;
  int givingMethod;
  String givenTime;
  String endTime;
  int quantity;
  bool requiredAmountUsed;
  double requiredAmount;
  bool requiredQtyUsed;
  int requiredQty;
  double couponValue;
  double discountRate;
  int takenLimitMode;
  String expiredAt;
  int expiryDaysAfterTaken;
  int whiteListID;
  String whiteListName;
  int blackListID;
  String blackListName;
  bool overlappable;
  bool useLimitProd;
  String useLimitDesc;
  int approvedStatus;
  bool couponGenerated;
  int takenQuantity;
  String remark;
  String createdDate;
  String createdBy;
  String lastModified;
  String lastModifiedBy;
  int usedQuantity;
  bool hased;
  bool expored;
  String promotionCode;

  ListOfCouponsModel({
    this.csID,
      this.csPic,
      this.csType,
      this.csName,
      this.shopID,
      this.givingMethod,
      this.givenTime,
      this.endTime,
      this.quantity,
      this.requiredAmountUsed,
      this.requiredAmount,
      this.requiredQtyUsed,
      this.requiredQty,
      this.couponValue,
      this.discountRate,
      this.takenLimitMode,
      this.expiredAt,
      this.expiryDaysAfterTaken,
      this.whiteListID,
      this.whiteListName,
      this.blackListID,
      this.blackListName,
      this.overlappable,
      this.useLimitProd,
      this.useLimitDesc,
      this.approvedStatus,
      this.couponGenerated,
      this.takenQuantity,
      this.remark,
      this.createdDate,
      this.createdBy,
      this.lastModified,
      this.lastModifiedBy,
      this.usedQuantity,
      this.hased,
      this.expored,
      this.promotionCode
  
   
  });

    ListOfCouponsModel.fromJson(Map<String, dynamic> json) {
    csID = json['csID'];
    csPic = json['csPic'];
    csType = json['csType'];
    csName = json['csName'];
    shopID = json['shopID'];
    givingMethod = json['givingMethod'];
    givenTime = json['givenTime'];
    endTime = json['endTime'];
    quantity = json['quantity'];
    requiredAmountUsed = json['requiredAmountUsed'];
    requiredAmount = json['requiredAmount'];
    requiredQtyUsed = json['requiredQtyUsed'];
    requiredQty = json['requiredQty'];
    couponValue = json['couponValue'];
    discountRate = json['discountRate'];
    takenLimitMode = json['takenLimitMode'];
    expiredAt = json['expiredAt'];
    expiryDaysAfterTaken = json['expiryDaysAfterTaken'];
    whiteListID = json['whiteListID'];
    whiteListName = json['whiteListName'];
    blackListID = json['blackListID'];
    blackListName = json['blackListName'];
    overlappable = json['overlappable'];
    useLimitProd = json['useLimitProd'];
    useLimitDesc = json['useLimitDesc'];
    approvedStatus = json['approvedStatus'];
    couponGenerated = json['couponGenerated'];
    takenQuantity = json['takenQuantity'];
    remark = json['remark'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    lastModified = json['lastModified'];
    lastModifiedBy = json['lastModifiedBy'];
    usedQuantity = json['usedQuantity'];
    hased = json['hased'];
    expored = json['expored'];
    promotionCode = json['promotionCode'];
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['csID'] = this.csID;
    data['csPic'] = this.csPic;
    data['csType'] = this.csType;
    data['csName'] = this.csName;
    data['shopID'] = this.shopID;
    data['givingMethod'] = this.givingMethod;
    data['givenTime'] = this.givenTime;
    data['endTime'] = this.endTime;
    data['quantity'] = this.quantity;
    data['requiredAmountUsed'] = this.requiredAmountUsed;
    data['requiredAmount'] = this.requiredAmount;
    data['requiredQtyUsed'] = this.requiredQtyUsed;
    data['requiredQty'] = this.requiredQty;
    data['couponValue'] = this.couponValue;
    data['discountRate'] = this.discountRate;
    data['takenLimitMode'] = this.takenLimitMode;
    data['expiredAt'] = this.expiredAt;
    data['expiryDaysAfterTaken'] = this.expiryDaysAfterTaken;
    data['whiteListID'] = this.whiteListID;
    data['whiteListName'] = this.whiteListName;
    data['blackListID'] = this.blackListID;
    data['blackListName'] = this.blackListName;
    data['overlappable'] = this.overlappable;
    data['useLimitProd'] = this.useLimitProd;
    data['useLimitDesc'] = this.useLimitDesc;
    data['approvedStatus'] = this.approvedStatus;
    data['couponGenerated'] = this.couponGenerated;
    data['takenQuantity'] = this.takenQuantity;
    data['remark'] = this.remark;
    data['createdDate'] = this.createdDate;
    data['createdBy'] = this.createdBy;
    data['lastModified'] = this.lastModified;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['usedQuantity'] = this.usedQuantity;
    data['hased'] = this.hased;
    data['expored'] = this.expored;
    data['promotionCode'] = this.promotionCode;
    return data;
  }
}

class ListOfCouponsModelList {
  List<ListOfCouponsModel> list;

  ListOfCouponsModelList(this.list);

  factory ListOfCouponsModelList.fromJson(List json) {
    return ListOfCouponsModelList(
        json.map((item) => ListOfCouponsModel.fromJson((item))).toList());
  }
}
