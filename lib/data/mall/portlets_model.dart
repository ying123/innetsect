import 'package:innetsect/data/mall/content_model.dart';
import 'package:innetsect/data/mall/promotion_model.dart';

class PortletsModel{
  int portletID;
  int portalID;
  int portletIdx;
  int portletType;
  int prodCollID;
  int layout;
  dynamic renderer;
  // 查询使用（全部）
  String promotionCode;
  // 商品集合
  PromotionModel promotion;

  List<ContentModel> contents;

  PortletsModel({
    this.contents,
    this.layout,
    this.portalID,
    this.portletID,
    this.portletIdx,
    this.portletType,
    this.prodCollID,
    this.renderer,
    this.promotionCode,
    this.promotion
  });

  factory PortletsModel.fromJson(Map<String,dynamic> json){
    return PortletsModel(
      portalID: json['portalID'],
      portletID: json['portletID'],
      portletIdx: json['portletIdx'],
      portletType: json['portletType'],
      prodCollID: json['prodCollID'],
      layout: json['layout'],
      renderer: json['renderer'],
      contents: json['contents']!=null?ContentModelList.fromJson(json['contents']).list:[],
      promotionCode: json['promotionCode'],
        promotion: json['promotion']!=null?PromotionModel.fromJson(json['promotion']): null
    );
  }
}

class PortletsModelList{

  List<PortletsModel> list;

  PortletsModelList(this.list);

  factory PortletsModelList.fromJson(List json){
    print(json);
    return PortletsModelList(
        json.map(
                (item)=>PortletsModel.fromJson((item))
        ).toList()
    );
  }

}