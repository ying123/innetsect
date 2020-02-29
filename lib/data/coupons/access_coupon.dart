
///优惠卷领取

class AccessCouponModel {
  int couponID;
  String couponCode;
  double couponValue;
  String csName;
  int csID;
  int csType;
  num requiredAmount;
  String useLimitDesc;
  bool overlappable;
  int shopID;
  int acctID;
  String mobile;
  int expiryDays;
  String givenTime;
  String takenTime;
  String expiryTime;
  int usingStatus;
  String remark;
  bool discountable;
  String couponTypeText;
  bool expired;
  bool usable;

  AccessCouponModel(
      {this.couponID,
      this.couponCode,
      this.couponValue,
      this.csName,
      this.csID,
      this.csType,
      this.requiredAmount,
      this.useLimitDesc,
      this.overlappable,
      this.shopID,
      this.acctID,
      this.mobile,
      this.expiryDays,
      this.givenTime,
      this.takenTime,
      this.expiryTime,
      this.usingStatus,
      this.remark,
      this.discountable,
      this.couponTypeText,
      this.expired,
      this.usable});

  AccessCouponModel.fromJson(Map<String, dynamic> json) {
    couponID = json['couponID'];
    couponCode = json['couponCode'];
    couponValue = json['couponValue'];
    csName = json['csName'];
    csID = json['csID'];
    csType = json['csType'];
    requiredAmount = json['requiredAmount'];
    useLimitDesc = json['useLimitDesc'];
    overlappable = json['overlappable'];
    shopID = json['shopID'];
    acctID = json['acctID'];
    mobile = json['mobile'];
    expiryDays = json['expiryDays'];
    givenTime = json['givenTime'];
    takenTime = json['takenTime'];
    expiryTime = json['expiryTime'];
    usingStatus = json['usingStatus'];
    remark = json['remark'];
    discountable = json['discountable'];
    couponTypeText = json['couponTypeText'];
    expired = json['expired'];
    usable = json['usable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponID'] = this.couponID;
    data['couponCode'] = this.couponCode;
    data['couponValue'] = this.couponValue;
    data['csName'] = this.csName;
    data['csID'] = this.csID;
    data['csType'] = this.csType;
    data['requiredAmount'] = this.requiredAmount;
    data['useLimitDesc'] = this.useLimitDesc;
    data['overlappable'] = this.overlappable;
    data['shopID'] = this.shopID;
    data['acctID'] = this.acctID;
    data['mobile'] = this.mobile;
    data['expiryDays'] = this.expiryDays;
    data['givenTime'] = this.givenTime;
    data['takenTime'] = this.takenTime;
    data['expiryTime'] = this.expiryTime;
    data['usingStatus'] = this.usingStatus;
    data['remark'] = this.remark;
    data['discountable'] = this.discountable;
    data['couponTypeText'] = this.couponTypeText;
    data['expired'] = this.expired;
    data['usable'] = this.usable;
    return data;
  }
}
class AccessCouponModelList {
  List<AccessCouponModel> list;

  AccessCouponModelList(this.list);

  factory AccessCouponModelList.fromJson(List json) {
    return AccessCouponModelList(
        json.map((item) => AccessCouponModel.fromJson((item))).toList());
  }
}
