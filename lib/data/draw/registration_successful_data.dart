///登记成功数据
class RegistrationSuccessfulDataModel {
  num drawID;
  num shopID;
  num acctID;
  String realName;
  num telPrefix;
  String mobile;
  String icNo;
  String registerDate;
  String ipAddr;
  String platform;
  num longitude;
  num latitude;
  num status;
  String expiryTime;
  String remark;
 
  RegistrationSuccessfulDataModel({
    this.drawID,
    this.shopID,
    this.acctID,
    this.realName,
    this.telPrefix,
    this.mobile,
    this.icNo,
    this.registerDate,
    this.ipAddr,
    this.platform,
    this.longitude,
    this.latitude,
    this.status,
    this.expiryTime,
    this.remark,
  });

  factory RegistrationSuccessfulDataModel.fromJson(Map<String, dynamic> json) {
    return RegistrationSuccessfulDataModel(
      drawID: json['drawID'],
      shopID: json['shopID'],
      acctID: json['acctID'],
      realName: json['realName'],
      telPrefix: json['telPrefix'],
      mobile: json['mobile'],
      icNo: json['icNo'],
      registerDate: json['registerDate'],
      ipAddr: json['ipAddr'],
      platform: json['platform'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      status: json['status'],
      expiryTime: json['expiryTime'],
      remark: json['remark'],
    );
  }

  Map<String, dynamic> toJson() => {
        'drawID': drawID,
        'shopID': shopID,
        'acctID': acctID,
        'realName': realName,
        'telPrefix': telPrefix,
        'mobile': mobile,
        'icNo': icNo,
        'registerDate': registerDate,
        'ipAddr': ipAddr,
        'platform': platform,
        'longitude': longitude,
        'latitude': latitude,
        'status': status,
        'expiryTime': expiryTime,
        'remark': remark,
      };
}

class RegistrationSuccessfulDataModelList {
  List<RegistrationSuccessfulDataModel> list;

  RegistrationSuccessfulDataModelList(this.list);

  factory RegistrationSuccessfulDataModelList.fromJson(List json) {
    return RegistrationSuccessfulDataModelList(
        json.map((item) => RegistrationSuccessfulDataModel.fromJson((item))).toList());
  }
}
