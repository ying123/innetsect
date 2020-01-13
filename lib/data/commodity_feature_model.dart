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
  // 可售卖数量
  int qtyInHand;

  CommodityFeatureModel({
    this.prodID,
    this.featureCode,
    this.featureGroup,
    this.featureValue,
    this.isSelected,
    this.qtyInHand
  });

  factory CommodityFeatureModel.fromJson(Map<String,dynamic> json){
    return new CommodityFeatureModel(
        prodID: json['prodID'],
      featureGroup: json['featureGroup'],
      featureCode: json['featureCode'],
      featureValue: json['featureValue'],
        isSelected: json['isSelected'],
        qtyInHand: json['qtyInHand']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'featureGroup': featureGroup,
    'featureCode': featureCode,
    'featureValue': featureValue,
    'isSelected': isSelected,
    'qtyInHand': qtyInHand
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