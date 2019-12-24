class CommodityBadgesModel{
  String name;
  String bkColor;
  String foreColor;
  CommodityBadgesModel({
    this.name,
    this.bkColor,
    this.foreColor
  });

  factory CommodityBadgesModel.fromJson(Map<String,dynamic> json){
    return CommodityBadgesModel(
      name: json['name'],
      bkColor: json['bkColor'],
      foreColor: json['foreColor']
    );
  }
}

class CommodityBadgesModelList{
  List<CommodityBadgesModel> list;
  CommodityBadgesModelList(this.list);
  
  factory CommodityBadgesModelList.fromJson(List json){
    return CommodityBadgesModelList(
      json.map((item)=>CommodityBadgesModel.fromJson(item)).toList()
    );
  }
}