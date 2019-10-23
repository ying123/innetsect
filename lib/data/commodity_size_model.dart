class CommoditySizeModel{
  int id;
  String size;
  bool isSelected;

  CommoditySizeModel({
    this.id,
    this.size,
    this.isSelected
  });

  factory CommoditySizeModel.formJson(Map<String,dynamic> json){
    return CommoditySizeModel(
      id: json['id'],
      size: json['size'],
      isSelected: json['isSelected']
    );
  }

  Map<String,dynamic> toJson()=>{
    'id': id,
    'size': size,
    'isSelected': isSelected
  };

}