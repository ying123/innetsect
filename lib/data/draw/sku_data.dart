
class SkusModel {
  String skuName;
  String skuSpecs;
  num drawID;
  String skuPic;
  num shopID;
  num prodID;
  num limitMaxQty;
  String skuCode;

  SkusModel({
    this.skuName,
    this.skuSpecs,
    this.drawID,
    this.skuPic,
    this.shopID,
    this.prodID,
    this.limitMaxQty,
    this.skuCode,
  });

  factory SkusModel.fromJson(Map<String, dynamic> json) {
    return SkusModel(
      skuName: json['skuName'],
      skuSpecs: json['skuSpecs'],
      drawID: json['drawID'],
      skuPic: json['skuPic'],
      shopID: json['shopID'],
      prodID: json['prodID'],
      limitMaxQty: json['limitMaxQty'],
      skuCode: json['skuCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        'skuName': skuName,
        'skuSpecs': skuSpecs,
        'drawID': drawID,
        'skuPic': skuPic,
        'shopID': shopID,
        'prodID': prodID,
        'limitMaxQty': limitMaxQty,
        'skuCode': skuCode,

      };
}

class SkusModelList {
  List<SkusModel> list;

  SkusModelList(this.list);

  factory SkusModelList.fromJson(List json) {
    return SkusModelList(
        json.map((item) => SkusModel.fromJson((item))).toList());
  }
}
