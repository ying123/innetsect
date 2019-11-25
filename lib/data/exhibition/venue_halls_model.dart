

import 'package:azlistview/azlistview.dart';

///场馆大厅数据
class  VenueHallsModel extends ISuspensionBean{
  int exhibitionID;
  String locCode;
  String exhibitionHall;
  int locIdx;
  String brandName;
  String brandLogo;
  String poster;
  int exhibiterID;
  String remark;
  String exhibiter;
  String exhibitProducts;
  String tagIndex;
  String tagIndexTwo;
  String namePinyin;

  VenueHallsModel({
    this.exhibitionID,
    this.locCode,
    this.exhibitionHall,
    this.locIdx,
    this.brandName,
    this.brandLogo,
    this.poster,
    this.exhibiterID,
    this.remark,
    this.exhibiter,
    this.exhibitProducts,
    this.tagIndex,
    this.tagIndexTwo,
    this.namePinyin
  });

  factory VenueHallsModel.fromJson(Map<String, dynamic> json){
    return VenueHallsModel(
      exhibitionID:json['exhibitionID'],
      locCode:json['locCode'],
      exhibitionHall: json['exhibitionHall'],
      locIdx: json['locIdx'],
      brandName: json['brandName'],
      brandLogo: json['brandLogo'],
      poster: json['poster'],
      exhibiterID: json['exhibiterID'],
      remark: json['remark'],
      exhibiter: json['exhibiter'],
      exhibitProducts: json['exhibitProducts'],
     
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'locCode':locCode,
    'exhibitionHall':exhibitionHall,
    'locIdx':locIdx,
    'brandName':brandName,
    'brandLogo':brandLogo,
    'poster':poster,
    'exhibiterID':exhibiterID,
    'remark':remark,
    'exhibiter':exhibiter,
    'exhibitProducts':exhibitProducts,
    'tagIndex':tagIndex,
    'tagIndexTwo':tagIndexTwo,
    'namePinyin':namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag(){
    return tagIndex;
  }
}

class  VenueHallsModelList {
  List<VenueHallsModel> list;

  VenueHallsModelList(this.list);

  factory VenueHallsModelList.fromJson(List json){
    return VenueHallsModelList(
      json.map((item)=>VenueHallsModel.fromJson((item))).toList()
    );
  }
}