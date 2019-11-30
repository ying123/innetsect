
///大厅数据
class  HallsModel {
  int exhibitionID;
  String exhibitionHall;
  String overviewPic;

  HallsModel({
    this.exhibitionID,
    this.exhibitionHall,
    this.overviewPic
  });

  factory HallsModel.fromJson(Map<String, dynamic> json){
    return HallsModel(
      exhibitionID:json['exhibitionID'],
      exhibitionHall:json['exhibitionHall'],
        overviewPic: json['overviewPic']
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'exhibitionHall':exhibitionHall,
    'overviewPic': overviewPic
  };
}

class  HallsModelList {
  List<HallsModel> list;

  HallsModelList(this.list);

  factory HallsModelList.fromJson(List json){
    return HallsModelList(
      json.map((item)=>HallsModel.fromJson((item))).toList()
    );
  }
}