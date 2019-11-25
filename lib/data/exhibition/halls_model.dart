
///大厅数据
class  HallsModel {
  int exhibitionID;
  String exhibitionHall;

  HallsModel({
    this.exhibitionID,
    this.exhibitionHall,
  });

  factory HallsModel.fromJson(Map<String, dynamic> json){
    return HallsModel(
      exhibitionID:json['exhibitionID'],
      exhibitionHall:json['exhibitionHall'],
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'exhibitionHall':exhibitionHall,
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