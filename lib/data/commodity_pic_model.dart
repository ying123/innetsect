class CommodityPicModel{
  int prodID;
  // 编码
  String skuCode;
  int skuPicIdx;
  // 图片url
  String skuPicUrl;
  CommodityPicModel({
    this.prodID,
    this.skuCode,
    this.skuPicIdx,
    this.skuPicUrl
  });

  factory CommodityPicModel.fromJson(Map<String,dynamic> json){
    return CommodityPicModel(
        prodID: json['prodID'],
        skuCode: json['skuCode'],
        skuPicIdx: json['skuPicIdx'],
        skuPicUrl: json['skuPicUrl']
    );
  }

  Map<String, dynamic> toJson()=>{
    'prodID': prodID,
    'skuCode': skuCode,
    'skuPicIdx': skuPicIdx,
    'skuPicUrl': skuPicUrl
  };
}
class CommodityPicList{
  List<CommodityPicModel> list;

  CommodityPicList(this.list);

  factory CommodityPicList.fromJson(List json){
    return CommodityPicList(
        json.map(
                (item)=>CommodityPicModel.fromJson((item))
        ).toList()
    );
  }
}
