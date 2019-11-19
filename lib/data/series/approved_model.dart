import 'package:azlistview/azlistview.dart';

/// 品牌
class ApprovedModel extends ISuspensionBean{
  String name;
  String tagIndex;
  String brandLogo;
  String namePinyin;

  ApprovedModel({
    this.name,
    this.tagIndex,
    this.brandLogo,
    this.namePinyin
  });

  factory ApprovedModel.fromJson(Map<String,dynamic> json){
    return ApprovedModel(
      brandLogo: json['brandLogo'],
        name: json['brandName']
    );
  }

  Map<String,dynamic> toJson() => {
    'brandLogo': brandLogo,
    'brandName': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;
}

class ApprovedModelList{
  final List<ApprovedModel> list;
  ApprovedModelList(this.list);

  factory ApprovedModelList.fromJson(List json){
    return ApprovedModelList(
      json.map(
          (item)=>ApprovedModel.fromJson((item))
      ).toList()
    );
  }
}