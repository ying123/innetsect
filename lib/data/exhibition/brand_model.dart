
import 'package:azlistview/azlistview.dart';

///大厅数据
class  BrandModel extends ISuspensionBean {
  String brandName;
  int exhibitionID;
  String exhibitionHall;
  String locCode;
  int locIdx;
  String brandLogo;
  String poster;
  String remark;
  int prodCount;
  int previewCount;
  String tagIndex;
  String namePinyin;

  BrandModel({
    this.brandName,
    this.exhibitionID,
    this.exhibitionHall,
    this.locCode,
    this.locIdx,
    this.brandLogo,
    this.poster,
    this.remark,
    this.prodCount,
    this.previewCount,
    this.tagIndex,
    this.namePinyin,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json){
    return BrandModel(
      brandName:json['brandName'],
      exhibitionID:json['exhibitionID'],
      exhibitionHall:json['exhibitionHall'],
      locCode:json['locCode'],
      locIdx:json['locIdx'],
      brandLogo:json['brandLogo'],
      poster:json['poster'],
      remark:json['remark'],
      prodCount:json['prodCount'],
      previewCount:json['previewCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'brandName':brandName,
    'exhibitionID':exhibitionID,
    'exhibitionHall':exhibitionHall,
    'locCode':locCode,
    'locIdx':locIdx,
    'brandLogo':brandLogo,
    'poster':poster,
    'remark':remark,
    'prodCount':prodCount,
    'previewCount':previewCount,
    'tagIndex':tagIndex,
    'namePinyin':namePinyin,
    'isShowSuspension':isShowSuspension,
  };

  @override
  String getSuspensionTag() => tagIndex;
}

class  BrandModelList {
  List<BrandModel> list;

  BrandModelList(this.list);

  factory BrandModelList.fromJson(List json){
    return BrandModelList(
      json.map((item)=>BrandModel.fromJson((item))).toList()
    );
  }
}