/// 物流model
class ShipperModel{
  String shipperCode;
  String shipperName;
  bool isSelected;

  ShipperModel({
    this.shipperCode,
    this.shipperName,
    this.isSelected
  });

  factory ShipperModel.fromJson(Map<String,dynamic> json){
    return ShipperModel(
      shipperCode: json['shipperCode'],
      shipperName: json['shipperName']
    );
  }

  Map<String,dynamic> toJson()=>{
    'shipperCode': shipperCode,
    'shipperName': shipperName
  };
}

class ShipperModelList{
  final List<ShipperModel> list;
  ShipperModelList(this.list);

  factory ShipperModelList.fromJson(List json){
    return ShipperModelList(
      json.map((item)=>ShipperModel.fromJson(item)).toList()
    );
  }
}