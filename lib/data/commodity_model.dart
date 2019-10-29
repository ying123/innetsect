import 'package:innetsect/data/commodity_color_model.dart';
import 'package:innetsect/data/commodity_size_model.dart';

/// 商品类
class CommodityModel{
  // 商品id
  int id;
  // 商品图片
  String images;
  // 商品描述
  String describe;
  // 商品颜色
  String colors;
  // 商品尺寸
  String size;
  // 商品单价
  double price;
  // 商品数量
  int count;
  // 颜色对象
  CommodityColorModel commodityColorModel;
  // 尺寸对象
  CommoditySizeModel commoditySizeModel;
  // 是否选中
  bool isSelected;
  // 商品类别
  String types;

  CommodityModel({
    this.id,
    this.images,
    this.describe,
    this.colors,
    this.size,
    this.price,
    this.count,
    this.commodityColorModel,
    this.commoditySizeModel,
    this.isSelected,
    this.types
  });

  factory CommodityModel.formJson(Map<String,dynamic> json){
    return CommodityModel(
      id: json['id'],
      images: json['images'],
      describe: json['describe'],
      colors: json['colors'],
      size: json['size'],
      price: json['price'],
      count: json['count'],
      commodityColorModel: json['commodityColorModel'],
      commoditySizeModel: json['commoditySizeModel'],
        isSelected: json['isSelected'],
      types: json['types']
    );
  }

  Map<String, dynamic> toJson()=> {
    'id': id,
    'images': images,
    'describe': describe,
    'colors': colors,
    'size': size,
    'price': price,
    'count': count,
    'commodityColorModel': commodityColorModel,
    'commoditySizeModel': commoditySizeModel,
    'isSelected': isSelected,
    'types': types
  };
}