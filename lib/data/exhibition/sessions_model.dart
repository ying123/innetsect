


class  SessionsModel {
  int exhibitionID;
  String sessionDate;
  String beginTime;
  String endTime;
  int status;
  bool editable;
  bool deletable;

  SessionsModel({
    this.exhibitionID,
    this.sessionDate,
    this.beginTime,
    this.endTime,
    this.status,
    this.editable,
    this.deletable,
  });

  factory SessionsModel.fromJson(Map<String, dynamic> json){
    return SessionsModel(
      exhibitionID:json['exhibitionID'],
      sessionDate:json['sessionDate'],
      beginTime: json['beginTime'],
      endTime: json['endTime'],
      status: json['status'],
      editable: json['editable'],
      deletable: json['deletable'],
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'sessionDate':sessionDate,
    'beginTime':beginTime,
    'endTime':endTime,
    'status':status,
    'editable':editable,
    'deletable':deletable,
  };
}

class  SessionsModelList {
  List<SessionsModel> list;

  SessionsModelList(this.list);

  factory SessionsModelList.fromJson(List json){
    return SessionsModelList(
      json.map((item)=>SessionsModel.fromJson((item))).toList()
    );
  }
}