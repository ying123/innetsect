
class DraweeModel {
  num drawID;
  num shopID;
  num acctID;
  String realName;
  String telPrefix;
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
  
 
 

  DraweeModel({
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

  factory DraweeModel.fromJson(Map<String, dynamic> json) {
    return DraweeModel(
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
        'platform': platform,
        'longitude': longitude,
        'latitude': latitude,
        'status': status,
        'expiryTime': expiryTime,
        'remark': remark,
        'ipAddr': ipAddr,
       
      };
}

class DraweeModelList {
  List<DraweeModel> list;

  DraweeModelList(this.list);

  factory DraweeModelList.fromJson(List json) {
    return DraweeModelList(
        json.map((item) => DraweeModel.fromJson((item))).toList());
  }
}
