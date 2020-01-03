///我的抽签记录数据模型
class MyDrawDataModel {
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
  String drawPic;
  String drawName;
  String startTime;

  MyDrawDataModel({
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
    this.drawPic,
    this.drawName,
    this.startTime,
  });

  factory MyDrawDataModel.fromJson(Map<String, dynamic> json) {
    return MyDrawDataModel(
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
      drawPic: json['drawPic'],
      drawName: json['drawName'],
      startTime: json['startTime'],
    
   
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
        'picUrl': ipAddr,
        'picUrl': platform,
        'picUrl': longitude,
        'picUrl': latitude,
        'picUrl': status,
        'picUrl': expiryTime,
        'picUrl': remark,
        'picUrl': drawPic,
        'picUrl': drawName,
        'picUrl': startTime,
      };
}

class MyDrawDataModelList {
  List<MyDrawDataModel> list;

  MyDrawDataModelList(this.list);

  factory MyDrawDataModelList.fromJson(List json) {
    return MyDrawDataModelList(
        json.map((item) => MyDrawDataModel.fromJson((item))).toList());
  }
}
