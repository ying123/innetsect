/// 活动预约二维码model
class ExActivityQrCodeModel{
  // 预约ID
  int reservationID;
  // 预约时间
  String reservedDate;
  // 预约码
  String reservationCode;
  int acctID;
  int activityID;
  // 状态：1、已预约 2、已中签 3、已使用 4、已失效
  int status;
  // 1、未提醒 2、已提醒
  int remindStatus;
  // 备注
  String remark;
  String activityName;
  String expiryTime;
  ExActivityQrCodeModel({
    this.activityID,
    this.status,
    this.remindStatus,
    this.acctID,
    this.remark,
    this.reservationCode,
    this.reservationID,
    this.reservedDate,
    this.activityName,
    this.expiryTime
  });

  factory ExActivityQrCodeModel.fromJson(Map<String,dynamic> json){
    return ExActivityQrCodeModel(
      activityID: json['activityID'],
      status: json['status'],
      remark: json['remark'],
      remindStatus: json['remindStatus'],
      reservationCode: json['reservationCode'],
      reservationID: json['reservationID'],
      reservedDate: json['reservedDate'],
      acctID: json['acctID'],
      activityName: json['activityName'],
        expiryTime: json['expiryTime']
    );
  }
}

class ExActivityQrCodeModelList{
  List<ExActivityQrCodeModel> list;
  ExActivityQrCodeModelList(this.list);

  factory ExActivityQrCodeModelList.fromJson(List json){
    return ExActivityQrCodeModelList(
      json.map((item)=>ExActivityQrCodeModel.fromJson(item)).toList()
    );
  }
}