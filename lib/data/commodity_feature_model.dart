/// 特征类
class CommodityFeatureModel{
  // id
  int prodID;
  // 特征组
  String featureGroup;
  // 特征码
  String featureCode;
  // 特征值
  String featureValue;
  // 是否选中
  bool isSelected;

  CommodityFeatureModel({
    this.prodID,
    this.featureCode,
    this.featureGroup,
    this.featureValue,
    this.isSelected
  });

  factory CommodityFeatureModel.fromJson(Map<String,dynamic> json){
    return CommodityFeatureModel(
        prodID: json['prodID'],
      featureGroup: json['featureGroup'],
      featureCode: json['featureCode'],
      featureValue: json['featureValue'],
        isSelected: json['isSelected']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'featureGroup': featureGroup,
    'featureCode': featureCode,
    'featureValue': featureValue,
    'isSelected': isSelected
  };
}

class CommodityFeatureList{
  List<CommodityFeatureModel> list;

  CommodityFeatureList(this.list);

  factory CommodityFeatureList.fromJson(List json){
    return CommodityFeatureList(
        json.map(
                (item)=>CommodityFeatureModel.fromJson((item))
        ).toList()
    );
  }
}