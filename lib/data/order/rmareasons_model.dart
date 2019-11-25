/// 申请原因model
class RmareasonsModel{
  int reasonType;
  String reasonName;
  bool isSelected;

  RmareasonsModel({
    this.reasonName,
    this.reasonType,
    this.isSelected
  });

  factory RmareasonsModel.fromJson(Map<String,dynamic> json){
    return RmareasonsModel(
      reasonName: json['reasonName'],
      reasonType: json['reasonType']
    );
  }
}

class RmareasonsModelList{
  final List<RmareasonsModel> list;

  RmareasonsModelList(this.list);
  factory RmareasonsModelList.fromJson(List json){
    return RmareasonsModelList(
        json.map(
                (item)=>RmareasonsModel.fromJson((item))
        ).toList()
    );
  }
}