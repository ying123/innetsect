///活动model
class ExActivityModel{
  // 活动ID
  int activityID;
  // 活动类型 1、普通 2、发售
  int activityType;
  // 活动海报
  String poster;
  // 活动名称
  String activityName;
  // 背景色
  String bgColor;
  //活动简介
  String brief;
  //展会ID
  int exhibitionID;
  //展位编码
  String locCode;
  //开始时间
  String startTime;
  //结束时间
  String endTime;
  //预告时间
  String noticeTime;
  //延期提示
  String delayRemark;
  //需预约，发售活动无需预约
  bool reservable;
  //允许预约人数
  int reservableQty;
  // 预约开始时间
  dynamic reserveStart;
  // 已预约人数
  int reservedQty;
  //预留分钟
  int preservedMinutes;
  // 状态 0、未批准 1、已批准 -1 已取消
  int approvedStatus;
  String broadcastMessage;
  int remindMethod;
  String remindMessage;
  int remindStatus;
  //状态，0、未开始  1、进行中
  int status;
  //当前登录用户是否预约该活动
  bool reserved;
  //是否在可预约的时间范围内
  bool inReservingTime;
  // 是否取消预约
  bool cancelable;
  // 二维码ID
  int reservationID;

  ExActivityModel({
    this.activityID,
    this.activityName,
    this.exhibitionID,
    this.endTime,
    this.startTime,
    this.status,
    this.activityType,
    this.approvedStatus,
    this.bgColor,
    this.brief,
    this.broadcastMessage,
    this.delayRemark,
    this.locCode,
    this.noticeTime,
    this.poster,
    this.preservedMinutes,
    this.remindMessage,
    this.remindMethod,
    this.remindStatus,
    this.reservable,
    this.reservableQty,
    this.reservedQty,
    this.reserveStart,
    this.reserved,
    this.inReservingTime,
    this.cancelable,
    this.reservationID
  });

  factory ExActivityModel.fromJson(Map<String,dynamic> json){
    return ExActivityModel(
      activityID: json['activityID'],
      activityName: json['activityName'],
      exhibitionID: json['exhibitionID'],
        endTime: json['endTime'],
        startTime: json['startTime'],
        status: json['status'],
        activityType: json['activityType'],
        approvedStatus: json['approvedStatus'],
        bgColor: json['bgColor'],
        brief: json['brief'],
        broadcastMessage: json['broadcastMessage'],
        delayRemark: json['delayRemark'],
        locCode: json['locCode'],
        noticeTime: json['noticeTime'],
        poster: json['poster'],
        preservedMinutes: json['preservedMinutes'],
        remindMessage: json['remindMessage'],
        remindMethod: json['remindMethod'],
        remindStatus: json['remindStatus'],
        reservable: json['reservable'],
        reservableQty: json['reservableQty'],
        reservedQty: json['reservedQty'],
        reserveStart: json['reserveStart'],
        reserved: json['reserved'],
        inReservingTime: json['inReservingTime'],
        cancelable: json['cancelable'],
        reservationID: json['reservationID']
    );
  }

}

class ExActivityModelList{
  List<ExActivityModel> list;
  ExActivityModelList(this.list);
  
  factory ExActivityModelList.fromJson(List json){
    return ExActivityModelList(
      json.map((item)=>ExActivityModel.fromJson(item)).toList()
    );
  }
}