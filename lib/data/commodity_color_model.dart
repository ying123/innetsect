class CommodityColorModel{
  // id
  int id;
  // 颜色
  String colors;
  // 是否选中
  bool isSelected;
  CommodityColorModel({
    this.id,
    this.colors,
    this.isSelected
  });

  factory CommodityColorModel.formJson(Map<String, dynamic> json){
    return CommodityColorModel(
      id: json['id'],
      colors: json['colors'],
      isSelected: json['isSelected']
    );
  }

  Map<String, dynamic> toJson()=>{
    'id': id,
    'colors': colors,
    'isSelected': isSelected
  };


}