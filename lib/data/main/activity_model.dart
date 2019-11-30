/// 活动model
class ActivityModel{
  int exhibitionID;
  String sessionDate;
  String beginTime;
  String endTime;
  // 2、
  int status;

  ActivityModel({
    this.exhibitionID,
    this.status,
    this.endTime,
    this.beginTime,
    this.sessionDate
  });

  factory ActivityModel.fromJson(Map<String,dynamic> json){
    return ActivityModel(
      exhibitionID: json['exhibitionID'],
      sessionDate: json['sessionDate'],
      beginTime: json['beginTime'],
      endTime: json['endTime'],
      status: json['status']
    );
  }
}

class ActivityModelList{
  List<ActivityModel> list;
  ActivityModelList(this.list);

  factory ActivityModelList.fromJson(List json){
    return ActivityModelList(
        json.map((item)=>ActivityModel.fromJson(item)).toList()
    );
  }
}