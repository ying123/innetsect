class CommodityBrandModel{
  String brandName;
  String brandLogo;
  String brandCover;
  String briefIntroduction;

  CommodityBrandModel({
    this.brandLogo,
    this.brandName,
    this.brandCover,
    this.briefIntroduction
  });

  factory CommodityBrandModel.fromJson(Map<String, dynamic> json){
    return CommodityBrandModel(
        brandName: json['brandName'],
        brandLogo: json['brandLogo'],
        brandCover: json['brandCover'],
        briefIntroduction: json['briefIntroduction']
    );
  }
}