
///优惠卷
class CouponsModel {
  num csID;
  num csType;
  int mobile;
  num acctID;
  String takenTime;
  String remark;
  num couponID;
  num couponValue;
  String useLimitDesc;
  num requiredAmount;
  bool overlappable;
  String givenTime;
  String expiryTime;
  num shopID;
  num expiryDays;
  num usingStatus;
  bool discountable;
  String couponCode;
  String csName;

  CouponsModel({
    this.csID,
    this.csType,
    this.mobile,
    this.acctID,
    this.takenTime,
    this.remark,
    this.couponID,
    this.couponValue,
    this.useLimitDesc,
    this.requiredAmount,
    this.overlappable,
    this.givenTime,
    this.expiryTime,
    this.shopID,
    this.expiryDays,
    this.usingStatus,
    this.discountable,
    this.couponCode,
    this.csName
  
   
  });

  factory CouponsModel.fromJson(Map<String, dynamic> json) {
    return CouponsModel(
      csID: json['csID'],
      csType: json['csType'],
      mobile: json['csType'],
      acctID: json['acctID'],
      takenTime: json['takenTime'],
      remark: json['remark'],
      couponID: json['couponID'],
      couponValue: json['couponValue'],
      useLimitDesc: json['useLimitDesc'],
      requiredAmount: json['requiredAmount'],
      overlappable: json['overlappable'],
      givenTime: json['givenTime'],
      expiryTime: json['expiryTime'],
      shopID: json['shopID'],
      expiryDays: json['expiryDays'],
      usingStatus: json['usingStatus'],
      discountable: json['discountable'],
      couponCode: json['couponCode'],
      csName: json['csName'],
  
    );
  }

  Map<String, dynamic> toJson() => {
        'csID': csID,
        'csType': csType,
        'mobile': mobile,
        'acctID': acctID,
        'takenTime': takenTime,
        'remark': remark,
        'couponID': couponID,
        'couponValue': couponValue,
        'useLimitDesc': useLimitDesc,
        'requiredAmount': requiredAmount,
        'overlappable': overlappable,
        'givenTime': givenTime,
        'expiryTime': expiryTime,
        'shopID': shopID,
        'expiryDays': expiryDays,
        'usingStatus': usingStatus,
        'discountable': discountable,
        'couponCode': couponCode,
        'csName': csName,
    
     
      };
}

class CouponsModelList {
  List<CouponsModel> list;

  CouponsModelList(this.list);

  factory CouponsModelList.fromJson(List json) {
    return CouponsModelList(
        json.map((item) => CouponsModel.fromJson((item))).toList());
  }
}
