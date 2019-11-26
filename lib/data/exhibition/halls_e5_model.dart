
import 'package:azlistview/azlistview.dart';

///大厅数据
class  HallsE5Model extends ISuspensionBean {
  int exhibitionID;
  String locCode;
  String exhibitionHall;
  int locIdx;
  String name;
  String brandLogo;
  String poster;
  int exhibiterID;
  String remark;
  String exhibiter;
  String exhibitProducts;
  String tagIndex;
  String namePinyin;

  HallsE5Model({
    this.exhibitionID,
    this.locCode,
    this.exhibitionHall,
    this.locIdx,
    this.name,
    this.brandLogo,
    this.poster,
    this.exhibiterID,
    this.remark,
    this.exhibiter,
    this.exhibitProducts,
    this.tagIndex,
    this.namePinyin,
  });

  factory HallsE5Model.fromJson(Map<String, dynamic> json){
    return HallsE5Model(
      exhibitionID:json['exhibitionID'],
      locCode:json['locCode'],
      exhibitionHall:json['exhibitionHall'],
      locIdx:json['locIdx'],
      name:json['brandName'],
      brandLogo:json['brandLogo'],
      poster:json['poster'],
      exhibiterID:json['exhibiterID'],
      remark:json['remark'],
      exhibiter:json['exhibiter'],
      exhibitProducts:json['exhibitProducts'],
    );
  }

  Map<String, dynamic> toJson() => {
    'exhibitionID':exhibitionID,
    'locCode':locCode,
    'exhibitionHall':exhibitionHall,
    'locIdx':locIdx,
    'brandName':name,
    'brandLogo':brandLogo,
    'poster':poster,
    'exhibiterID':exhibiterID,
    'remark':remark,
    'exhibiter':exhibiter,
    'exhibitProducts':exhibitProducts,
    'tagIndex':tagIndex,
    'namePinyin':namePinyin,
    'isShowSuspension':isShowSuspension,
  };

  @override
  String getSuspensionTag() => tagIndex;
}

class  HallsE5ModelList {
  List<HallsE5Model> list;

  HallsE5ModelList(this.list);

  factory HallsE5ModelList.fromJson(List json){
    return HallsE5ModelList(
      json.map((item)=>HallsE5Model.fromJson((item))).toList()
    );
  }
}