import 'package:innetsect/data/series/approved_model.dart';

/// 品类
class CategoryModel{
  // code编码
  int catCode;
  // 名称
  String catName;
  // 图片
  String catPic;
  // 二级子集
  List<CategoryModel> subCatalogs;
  // 品牌
  List<ApprovedModel> brands;
  // 是否选中
  bool isSelected;

  CategoryModel({
    this.brands,
    this.catCode,
    this.catName,
    this.catPic,
    this.subCatalogs,
    this.isSelected
  }){
    this.isSelected = false;
  }

  factory CategoryModel.fromJosn(Map<String,dynamic> json){
    return CategoryModel(
      catCode: json['catCode'],
      catName: json['catName'],
      catPic: json['catPic'],
      subCatalogs: json['subCatalogs']!=null?CategoryModelList.fromJson(json['subCatalogs']).list:[],
      brands: json['brands']!=null?ApprovedModelList.fromJson(json['brands']).list:[]
    );
  }
}

class CategoryModelList{
  final List<CategoryModel> list;
  CategoryModelList(this.list);

  factory CategoryModelList.fromJson(List list){
    return CategoryModelList(
        list.map(
                (item)=>CategoryModel.fromJosn(item)
        ).toList()
    );
  }
}