import 'package:azlistview/azlistview.dart';

/// 城市
class ApprovedCountryModel extends ISuspensionBean{
  String name;
  String tagIndex;
  String tagIndexTwo;
  String telPrefix;
  String namePinyin;

  ApprovedCountryModel({
    this.name,
    this.tagIndex,
    this.tagIndexTwo,
    this.telPrefix,
    this.namePinyin
  });

  factory ApprovedCountryModel.fromJson(Map<String,dynamic> json){
    return ApprovedCountryModel(
        telPrefix: json['telPrefix'],
        name: json['briefName']
    );
  }

  Map<String,dynamic> toJson() => {
    'telPrefix': telPrefix,
    'briefName': name,
    'tagIndex': tagIndex,
    'tagIndexTwo': tagIndexTwo,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;
}

class ApprovedCountryModelList{
  final List<ApprovedCountryModel> list;
  ApprovedCountryModelList(this.list);

  factory ApprovedCountryModelList.fromJson(List json){
    return ApprovedCountryModelList(
        json.map(
                (item)=>ApprovedCountryModel.fromJson((item))
        ).toList()
    );
  }
}